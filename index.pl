#!/usr/bin/perl

# for locally installed modules - change as necessary
use lib qw( ../../perl5/lib/perl5 );

use warnings;
use strict;
use version; our $VERSION = qv(6.01);
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Apache::DBI qw();
use File::Basename qw();
use Readonly;
use English qw( -no_match_vars );
use HTML::Tiny;

my $h = HTML::Tiny->new;

my $cgi = CGI->new;

my ( $name, $path, $suffix ) = File::Basename::fileparse($PROGRAM_NAME);

my $dbh = DBI->connect(
    "DBI:SQLite:dbname=$path/cardlist.sqlite",
    undef, undef,
    {   sqlite_unicode => 1,
        ReadOnly       => 1,
    }
);

Readonly my $CARD_MAX => 10;

my $to_page = sub {
    return $cgi->submit(
        -NAME  => '.State',
        -CLASS => 'topage',
        -VALUE => shift
    );
};

my $donate = $h->div(
    { style => 'display: inline-block;', },
    [   $h->div(
            {   class => 'boxheader',
                style => 'background-color: #e17000; color: #ffffff;',
            },
            [   $h->b(
                    '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your donations help keep this site alive!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
                ),
            ]
        ),

        $h->div(
            {   class => 'boxcontent',
                style => 'background-color: #ffffff; color: #000000;',
            },
            [   $h->table(
                    {   border      => '0',
                        cellpadding => '0',
                        cellspacing => '4',
                    },
                    [   $h->tr(
                            [   $h->td(
                                    [   $h->script(
                                            {   type => 'text/javascript',
                                                src  => 'coinwidget/coin.js',
                                            }
                                        ),
                                        $h->script(
                                            {   type => 'text/javascript',
                                                src => 'coinwidget/config.js',
                                            }
                                        ),
                                    ]
                                ),
                            ]
                        )
                    ]
                ),
            ]
        ),
    ]
);

my $output
    = header()
    . qq {<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n}
    . qq {<html xmlns="http://www.w3.org/1999/xhtml">};

$output .= $h->head(
    [   $h->title( { foo => 'bar' }, 'Tanto Cuore &#9829; Town Randomizer' ),
        $h->meta(
            {   'http-equiv' => 'Content-Type',
                content      => "text/html;charset=ISO-8859-1",
            }
        ),
        $h->meta(
            {   'http-equiv' => 'X-UA-Compatible',
                content      => 'IE=edge',
            }
        ),
        $h->meta(
            {   name => 'description',
                content =>
                    'A card randomizer utility for the games Tanto Cuore, Tanto Cuore: Expanding the House, Tanto Cuore: Romantic Vacation, Tanto Cuore: Oktoberfest, and Tanto Cuore: Winter Romance.',
            }
        ),

        $h->closed(
            'link',
            {   rel  => 'shortcut icon',
                href => './images/favicon.ico',
            }
        ),
        $h->closed(
            'link',
            {   rel  => 'stylesheet',
                type => 'text/css',
                href => './css/tc.css',
            }
        ),

        $h->script(
            {   type => 'text/javascript',
                src  => './js/jquery-1.7.2.min.js',
            }
        ),
        $h->script(
            {   type => 'text/javascript',
                src  => './js/tooltip.js',
            }
        ),

    ]
);

$output .= <<'END_PAGE_HEADING';
<body style="background-color:#ffccee;background-image:url('images/hearts.gif')">
<div align="center">
END_PAGE_HEADING

$output .= $cgi->start_form();

my $front_page = sub {
    my $active = shift;
    if ( !$active ) {
        return;
    }

    my $suboutput = q{};
    my @list      = ();
    my @fields    = ();

    my $sql = <<'END_SQL';
	  SELECT
   ID,
   name,
   gameset,
   title
	  FROM cardlist order by gameset, name
END_SQL

    my $cursor = $dbh->prepare($sql);

    $cursor->execute;

    @fields = ();

    my @selectedbans = ();
    @selectedbans = $cgi->param('banned');

    while ( @fields = $cursor->fetchrow ) {

        my $gameset = q{};

        ($gameset)
            = ( $fields[2] eq '1' )   ? ('Tanto Cuore')
            : ( $fields[2] eq '2' )   ? ('Expanding the House')
            : ( $fields[2] eq '3' )   ? ('Romantic Vacation')
            : ( $fields[2] eq '4' )   ? ('Oktoberfest')
            : ( $fields[2] eq '5' )   ? ('Winter Romance')
            : ( $fields[2] eq '101' ) ? ('Intl. Tabletop Day 2016 (Promo)')
            :                           ($gameset);

        push @list,
            $h->option(
            {   class => "banlist$fields[2]",
                value => "$fields[0]",
            },
            "$gameset - $fields[1] ($fields[3])"
            );
    }

    $cursor->finish;

    my @selectedsets = ();
    @selectedsets = $cgi->param('sets');

    $suboutput .= $h->h2(
        {   style =>
                'font-family:Title;font-size:32px;color:#562271;font-weight:normal',
            align => 'center',
        },
        'Tanto Cuore '
            . $h->span( { style => 'color:#ff6699' }, '&#9829;' )
            . 'Town Randomizer'
        )

        . $h->div(
        { style => 'display: inline-block;' },
        [

            $h->div(
                {   class => 'boxheader',
                    style => 'background-color: #cc99ff; color: #000066;'
                },
                [

                    $h->b('Include cards from set(s):'),
                ]
            ),

            $h->div(
                { class => 'boxcontent' },
                [

                    $h->small(
                        'Maid/butler chief pairs will be randomly selected from all chosen sets'
                    ),

                    $h->table(
                        {   border      => '0',
                            cellpadding => '0',
                            cellspacing => '4',
                        },
                        [   $h->tr(
                                [   $h->td(
                                        $h->select(
                                            {   title =>
                                                    'Click to select set(s)',
                                                size     => '6',
                                                id       => 'sets',
                                                class    => 'sets',
                                                name     => 'sets',
                                                multiple => 'multiple',
                                            },
                                            [   $h->option(
                                                    { value => '1', },
                                                    'Tanto Cuore',
                                                    { value => '2', },
                                                    'Expanding the House',
                                                    { value => '3', },
                                                    'Romantic Vacation',
                                                    { value => '4', },
                                                    'Oktoberfest',
                                                    { value => '5', },
                                                    'Winter Romance',
                                                    { value => '101', },
                                                    'Intl. Tabletop Day 2016 (Promo)',
                                                ),
                                            ]
                                        ),

                                        $h->td(
                                            {   align  => 'center',
                                                valign => 'middle',
                                            },
                                            '&nbsp;&nbsp'
                                                . &$to_page('Randomize')
                                        ),
                                    ),
                                ]
                            ),
                        ]
                    ),
                ]
            ),
        ]
        )
        . $h->br
        . $h->br

        . $h->div(
        {   style =>
                'display: inline-block; border-radius: 100px;  background-color: #ff99cc; padding-left: 20px; padding-right: 20px; padding-top: 5px; padding-bottom:5px; margin-bottom:15px;'
        },
        $h->div(
            {   id    => 'optionnote',
                style => 'display:none'
            },
            $h->b(
                $h->i('Select one or more sets to view randomizer options')
            )
            )
            . $h->div(
            { class => 'hiddenoptions' },
            $h->b(
                $h->i(
                    'You may also include the following selection criteria')
                )
                . $h->br
                . $h->small('All option sections may be combined</small>')
            )

        ) . $h->br;

    $suboutput .= <<'END_OPTIONS';
    <div style="display: inline-block;" class="hiddenoptions">

<div class="boxheader" style="background-color: #5544dd; color: #ffffff;"><b>Set-specific options</b></div>

<div class="boxcontent">

<div style="display:inline-block; padding-top:15px; padding-bottom: 15px;">

<div id="tcbox">

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #096fb8"><b>Keeping the Crescent sisters together</b></div>
<div style="background-color: #ffffff; padding-top:5px; padding-bottom:5px;">
<label for="crescent">If <i><u>and only if</u></i> a Crescent sister (Azure, Viola, or Rouge) is selected,<br />also include at least </label>
    <select name="crescent" id="crescent">
    <option>0</option>
    <option>1</option>
    <option>2</option>
    </select>
      other Crescent(s) in results
</div>
</div>

<br />
</div>


<div id="tcethbox">


<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #1f1a23"><b>Private Maids</b></div>
<div style="background-color: #ffffff;">
<table>
  <tr><td valign="top"><input type="checkbox" name="private" id="private" value="1" />&nbsp;</td><td valign="top" align="left"><label for="private">Exclude all cards that affect or require Private Maids</label><br /><small><i>Select this option if using Tanto Cuore and/or Expanding the House <b>without</b> Private Maids</i></small></td></tr>
</table> 
</div>
</div>

<br />

</div>


<div id="tcobox">

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #8652a1"><b>Events</b></div>
<div style="background-color: #ffffff;">
<table>
  <tr><td valign="top"><input type="checkbox" name="events" id="events" value="1" />&nbsp;</td><td valign="top" align="left"><label for="events">Exclude all cards that affect or require Event cards</label><br /><small><i>Select this option if using Tanto Cuore, Oktoberfest, and/or Winter Romance <b>without</b> Event cards<br /><b>NOTE:</b> Winter Romance "Drama" cards are treated as Event cards.</i></small></td></tr>
</table> 
</div>
</div>

<br />

</div>


<div id="ethbox">

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #f37a45"><b>Buildings</b></div>
<div style="background-color: #ffffff;">
<table>
  <tr><td valign="top"><input type="checkbox" name="buildings" id="buildings" value="1" />&nbsp;</td><td valign="top" align="left"><label for="buildings">Exclude all cards that affect or require Building cards</label><br /><small><i>Select this option if using Expanding the House, Oktoberfest, and/or Winter Romance <b>without</b> Building cards</i></small></td></tr>
</table> 
</div>
</div>

<br />

</div>


<div id="rvbox">

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #fbb450"><b>Reminiscences</b></div>
<div style="background-color: #ffffff; padding-right:5px;">
<table>
  <tr><td valign="middle"><input type="radio" name="reminiscences" class="reminiscences" id="reminiscences0" value="0" checked="checked" />&nbsp;</td><td valign="bottom" align="left"><label for="reminiscences0">No preference on Reminiscence cards</label></td></tr>
  <tr><td valign="middle"><input type="radio" name="reminiscences" id="reminiscences2" class="reminiscences" value="2" />&nbsp;</td><td valign="bottom" align="left"><label for="reminiscences2">Ensure a cost spread that permits all Reminiscence cards to be played</label></td></tr>
  <tr><td valign="top"><input type="radio" name="reminiscences" class="reminiscences" id="reminiscences1" value="1" />&nbsp;</td><td valign="top" align="left"><label for="reminiscences1">Exclude all cards that affect or require Reminiscence cards</label><br /><small><i>Select this option if using Romantic Vacation <b>without</b> Reminiscence cards</i></small></td></tr>
</table> 
</div>  

</div>
<br />
</div>


<div id="obox">

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #DE9D0F"><b>Beer</b></div>
<div style="background-color: #ffffff;">
<table>
  <tr><td valign="top"><input type="radio" name="beer" class="beer" id="beer1" value="1" checked="checked" />&nbsp;</td><td valign="top" align="left"><label for="beer1">Ensure at least one bar maid in results to allow beer cards to be utilized</label><br /><small><i>Select this option if using Oktoberfest <b>with</b> the beer mechanic (Beer cards and the Beer Fest building)</i></small></td></tr>
  <tr><td valign="top"><input type="radio" name="beer" class="beer" id="beer2" value="2" />&nbsp;</td><td valign="top" align="left"><label for="beer2">Exclude all cards that affect or require Beer cards</label><br /><small><i>Select this option if using Oktoberfest <b>without</b> the beer mechanic (Beer cards and the Beer Fest building)</i></small></td></tr>
</table> 
</div>
</div>


<br />

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #096fb8"><b>Apprentice Maid</b></div>
<div style="background-color: #ffffff;">
<table>
  <tr><td valign="top"><input type="checkbox" name="apprentice" id="apprentice" value="1" />&nbsp;</td><td valign="top" align="left"><label for="apprentice">Require Nicole Schmieg in the results if <i><u>and only if</u></i> Anja Brunner is selected as the Maid Chief<br /><small><i>Note: Nicole is treated as an attack card as she can be placed in any player's deck, so this option is mutually<br />exclusive with the "No attack cards" option.</i></small></label></td></tr>
</table> 
</div>


</div>

<br />


</div>


<div id="wrbox">

<div style="border-style:solid; border-width:1px;">
<div style="color: #ffffff; background-color: #ad9c92"><b>Couples</b></div>
<div style="background-color: #ffffff;">
<table>
  <tr><td valign="top"><input type="checkbox" name="couples" id="couples" value="1" />&nbsp;</td><td valign="top" align="left"><label for="couples">Do not use Winter Romance approach/couple mechanics</label><br /><small><i>(Friends, Trial, Drama cards, Meetup Spot cards, Chapel, and Social Bonus)</i></small></td></tr>
</table> 
</div>
</div>



</div>



</div>
</div>
  
<br />

<div class="boxheader" style="background-color: #cc6699; color: #ffffff;"><b>Maid/butler cost requirements</b></div>


<div class="boxcontent">
Require at least one general maid/butler of each of the following employ costs:
  <br /><select size="7" name="cost" multiple="multiple">
  <option value="2" class="love">2 Love</option>
  <option value="3" class="love">3 Love</option>
  <option value="4" class="love">4 Love</option>
  <option value="5" class="love">5 Love</option>
  <option value="6" id="love6">6 Love</option>
  <option value="7" class="love">7 Love</option>
  <option value="8" id="love8">8 Love</option>
  </select>

</div>    

<br />    

<div class="boxheader" style="background-color: #333333; color: #ffffff;"><b>Attack cards</b></div>

<div class="boxcontent">
<table>
  <tr><td valign="middle"><input type="radio" name="attack" id="attack0" value="0" checked="checked" />&nbsp;</td><td valign="bottom" align="left"><label for="attack0">No preference on attack cards</label></td></tr> 
  <tr><td valign="top"><input type="radio" name="attack" id="attack1" value="1" />&nbsp;</td><td valign="bottom" align="left"><label for="attack1"><b>No attack cards.</b> Exclude all cards of any type that can affect other players' VP or deck/hand<br /><small>As <b>Event</b> cards are strictly attack cards this option assumes you are <i>not</i> using them and excludes any cards that affect <b>Events</b><br />even if the cards themselves are not inherently attack cards, and no specific <b>Events</b> will be listed to remove from game.<br /><i style="color: #990000">This option does <b>not</b> affect the Approach mechanic in Winter Romance.</i></small></label></td></tr>
  <tr><td valign="top"><input type="radio" name="attack" id="attack2" value="2" /></td><td valign="middle" align="left"><span id="attack2text"><label for="attack2"><b>ONLY attack cards.</b> Include <u>only</u> general maids that can affect other players' VP or deck/hand</label></span></td></tr>
</table> 
</div>


<br />
  
<div class="boxheader" style="background-color: #990000; color: #ffffff;"><b>Banned cards</b></div>


<div class="boxcontent">
Select cards to <i>not</i> include in results:<br /><select size="5" name="banned" id="banned" class="banned" multiple="multiple">
<option value="0" id="pleaseselect" disabled="disabled" style="display:none">Please select a game set</option>
END_OPTIONS

    for my $listitem (@list) {
        my $item = q{};
        $item = $listitem;
        $item =~ s{banlist.?}{banlistnoscript}xms;
        $suboutput .= $item;
    }

    $suboutput .= '</select></div></div>';

    $suboutput
        .= '<p class="hiddenoptions">' . &$to_page('Randomize') . '</p>';
    $suboutput
        .= '<p class="hiddenoptions"><input type="reset" value="Clear All Selections" /></p>';
    $suboutput .= '<select id="banlist" style="display: none">';

    for my $listitem (@list) {
        $suboutput .= $listitem;
    }
    $suboutput .= '</select>';

    $suboutput .= <<"END_PAGE_FOOTER";
<script type="text/javascript">
//<![CDATA[
document.getElementById('pleaseselect').style.display = 'block';
\$(".banlistnoscript").remove();
//]]>
</script>


<p>&nbsp;</p>
 $donate
<p>&nbsp;</p>
<p><small>Find a bug?  Submit an issue on <a href="https://github.com/BrotherBuford/tantocuore-randomizer" target="_new">GitHub</a></small></p>

<p style="font-size: 0.55em">This game utility is a fan work not affiliated with Arclight, Inc. or Japanime Games.<br /><a href="http://www.tantocuore.com/">Tanto Cuore Official English Website</a> &#8226; <a href="http://www.arclight.co.jp/ag/tc/">Tanto Cuore Official Japanese Website</a><br /><a href="https://www.facebook.com/JapanimeGames/">Japanime Games Facebook Page</a></p>


<!-- <p>
      <a href="http://validator.w3.org/check?uri=referer"><img
          src="./images/xhtml1.0.png"
          alt="Valid XHTML 1.0" height="15" width="80" /></a>
</p> -->

<script type="text/javascript" src="./js/functions.js"></script>
END_PAGE_FOOTER

    return $suboutput;
};

my $randomize = sub {
    my $active = shift;
    if ( !$active ) {
        return;
    }

    my $suboutput = q{};
    my $newbutton = 1;

    my %color = (
        '1'   => '#ffccee',
        '2'   => '#ffddbb',
        '3'   => '#cceeff',
        '4'   => '#ddaa88',
        '5'   => '#5b97ab',
        '101' => '#ffffaa',
    );

    if ( !$cgi->param('sets') ) {
        $suboutput
            .= qq{<p class="error"><b>Error:</b> No game sets selected.  You must choose at least one game set.</b></p>\n};
    }
    else {

        my @sets = ();
        @sets = $cgi->param('sets');
        my %sets        = ();
        my $setlist_sql = q{};
        my @chiefs      = ();
        for my $elem (@sets) {

            $cgi->param(
                -name  => 'sets',
                -value => "$elem"
            );

            $setlist_sql .= qq{ or gameset = "$elem"};
            $sets{$elem} = 1;
            if ( $elem ne '101' ) {
                push @chiefs, $elem;
            }
        }

        $suboutput .= hidden( -name => 'sets' );

        $setlist_sql =~ s{\A\sor}{}xms;

        my @banned = ();
        @banned = $cgi->param('banned');

        my %banlist = ();

        my $banlist_sql = q{};
        for my $elem (@banned) {

            $cgi->param(
                -name  => 'banned',
                -value => "$elem"
            );
            $banlist{$elem} = 1;
            $banlist_sql .= qq{ and ID != "$elem"};
        }
        $suboutput .= hidden( -name => 'banned' );
        $banlist_sql =~ s{\A\sand}{}xms;

        my $attack_sql = q{};
        if ( $cgi->param('attack') ) {
            $cgi->param(
                -name  => 'attack',
                -value => $cgi->param('attack')
            );
        SWITCH: {
                if ( $cgi->param('attack') eq '1' ) {
                    $attack_sql = ' and (attack != "y") and (events != "y")';
                    last SWITCH;
                }
                if ( $cgi->param('attack') eq '2' ) {
                    $attack_sql = ' and (attack = "y")';
                    last SWITCH;
                }
                my $nothing = 0;
            }
            $suboutput .= hidden( -name => 'attack' );
        }

        my $events_sql = q{};

        if ( $cgi->param('events') ) {
            $cgi->param(
                -name  => 'events',
                -value => $cgi->param('events')
            );
            $events_sql = ' and (events != "y")';
            $suboutput .= hidden( -name => 'events' );
        }

        my $beer_sql = q{};
        if ( $cgi->param('beer') eq '2' ) {
            $cgi->param(
                -name  => 'beer',
                -value => $cgi->param('beer')
            );
            $beer_sql = ' and (beer != "y")';
        }
        if ( $cgi->param('beer') ) {
            $suboutput .= hidden( -name => 'beer' );
        }

        my $buildings_sql = q{};
        if ( $cgi->param('buildings') ) {
            $cgi->param(
                -name  => 'buildings',
                -value => $cgi->param('buildings')
            );
            $buildings_sql = ' and (buildings != "y")';
            $suboutput .= hidden( -name => 'buildings' );
        }

        my $private_sql = q{};
        if ( $cgi->param('private') ) {
            $cgi->param(
                -name  => 'private',
                -value => $cgi->param('private')
            );
            $private_sql = ' and (private != "y")';
            $suboutput .= hidden( -name => 'private' );
        }

        my $reminiscences_sql = q{};
        if ( $cgi->param('reminiscences') ) {
            if ( $cgi->param('reminiscences') eq '1' ) {
                $reminiscences_sql = ' and (reminiscences != "y")';
            }
            $cgi->param(
                -name  => 'reminiscences',
                -value => $cgi->param('reminiscences')
            );
            $suboutput .= hidden( -name => 'reminiscences' );
        }

        my $couples_sql = q{};
        if ( $cgi->param('couples') ) {
            $cgi->param(
                -name  => 'couples',
                -value => $cgi->param('couples')
            );
            $private_sql = ' and (couples != "y")';
            $suboutput .= hidden( -name => 'couples' );
        }

        my %costlist = ();

        my @fields = ();
        my @list   = ();
        my %list   = ();
        my $sql    = <<'END_SQL';
	  SELECT
   ID,
   name,
   gameset,
   title,
   cardnumber,
   cost,
   chambermaid,
   vp,
   attack,
   events,
   buildings,
   reminiscences,
   description,
   private,
   couples
	  FROM cardlist WHERE
END_SQL

        $sql .= '(' . $setlist_sql . ')';
        if ($banlist_sql) {
            $sql .= ' and (' . $banlist_sql . ')';
        }
        if ($attack_sql) {
            $sql .= $attack_sql;
        }
        if ($events_sql) {
            $sql .= $events_sql;
        }
        if ($buildings_sql) {
            $sql .= $buildings_sql;
        }
        if ($private_sql) {
            $sql .= $private_sql;
        }
        if ($reminiscences_sql) {
            $sql .= $reminiscences_sql;
        }
        if ($beer_sql) {
            $sql .= $beer_sql;
        }
        if ($couples_sql) {
            $sql .= $couples_sql;
        }

        my $cursor = $dbh->prepare($sql);

        $cursor->execute;

        @fields = ();
        @list   = ();
        %list   = ();

        while ( @fields = $cursor->fetchrow ) {

            $costlist{ $fields[0] } = "$fields[5]";

            my $prgameset;
            my $gameset;

            ( $prgameset, $gameset )
                = ( $fields[2] eq '1' )   ? ( q{},  q{} )
                : ( $fields[2] eq '2' )   ? ( q{},  '-II' )
                : ( $fields[2] eq '3' )   ? ( q{},  '-III' )
                : ( $fields[2] eq '4' )   ? ( q{},  '-IV' )
                : ( $fields[2] eq '5' )   ? ( q{},  '-V' )
                : ( $fields[2] eq '101' ) ? ( 'PR', q{} )
                :                           ( $prgameset, $gameset );

            my $cardname = "$fields[1] ($fields[3])";

            if ( "$fields[6]" eq 'y' ) {
                $cardname = $h->i("$cardname");
            }

            if ( "$fields[7]" eq 'y' ) {
                $cardname = $h->b("$cardname");
            }

            if ( "$fields[8]" eq 'y' ) {
                $cardname = $h->tag( 'font', { color => '#990000;', },
                    "$cardname" );
            }

            my $cardnumber = sprintf '%02d', "$fields[4]";

            $list{"$fields[0]"}
                = qq {<tr bgcolor="$color{$fields[2]}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/$prgameset$cardnumber$gameset.jpg' width='125' height='179'></td><td><b><u>$fields[1]</u></b><br /><i>$fields[3]</i><br /><hr />$fields[12]</td></tr></table>" rel="tooltip" class="tooltip"><td>$prgameset$cardnumber$gameset</td><td>$cardname</td><td align="center">$fields[5]</td></tr>\n};
        }

        $cursor->finish;

        my $barmaiderror = q{};
        if (   ( $cgi->param('beer') eq '1' )
            && ( !$list{'55'} && !$list{'56'} ) )
        {
            $barmaiderror = 1;
        }

        my $crescenterror = q{};
        if ( $cgi->param('crescent') ) {
            $cgi->param(
                -name  => 'crescent',
                -value => $cgi->param('crescent')
            );
        SWITCH: {
                if ( $cgi->param('crescent') eq '1' ) {
                CRESCENT: {
                        if ( $list{'14'} && !( $list{'15'} || $list{'16'} ) )
                        {
                            $crescenterror = 1;
                            last CRESCENT;
                        }
                        if ( $list{'15'} && !( $list{'14'} || $list{'16'} ) )
                        {
                            $crescenterror = 1;
                            last CRESCENT;
                        }
                        if ( $list{'16'} && !( $list{'14'} || $list{'15'} ) )
                        {
                            $crescenterror = 1;
                            last CRESCENT;
                        }
                        my $nothing = 0;
                    }
                    last SWITCH;
                }
                if (   ( $cgi->param('crescent') eq '2' )
                    && ( $list{'14'} || $list{'15'} || $list{'16'} )
                    && !( $list{'14'} && $list{'15'} && $list{'16'} ) )
                {
                    $crescenterror = 1;
                    last SWITCH;
                }
                my $nothing = 0;
            }

            $suboutput .= hidden( -name => 'crescent' );
        }

        my @costlist = ();
        @costlist = $cgi->param('cost');
        my %costignore = ();
        for my $elem (@costlist) {
        SWITCH: {
                if ( $elem eq '2' ) {
                    $costignore{'2'} = 1;
                    last SWITCH;
                }
                if ( $elem eq '3' ) {
                    $costignore{'3'} = 1;
                    last SWITCH;
                }
                if ( $elem eq '5' ) {
                    $costignore{'5'} = 1;
                    last SWITCH;
                }
                my $nothing = 0;
            }

            $cgi->param(
                -name  => 'cost',
                -value => "$elem"
            );
            $suboutput .= hidden( -name => 'cost' );
        }

        if ( ( $cgi->param('reminiscences') eq '2' )
            && !exists $costignore{'5'} )
        {
            push @costlist, '5';
        }

        my $chiefsindex  = rand @chiefs;
        my $chiefs       = $chiefs[$chiefsindex];
        my $chiefsoutput = q{};
    SWITCH: {
            if ( $chiefs eq '1' ) {
                $chiefsoutput
                    = qq{<tr bgcolor="$color{'1'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01.jpg' width='125' height='179'></td><td><b><u>Marianne Soleil</u></b><br /><i>Maid Chief</i><br /><hr />VP: 6</td></tr></table>" rel="tooltip" class="tooltip"><td>01</td><td><b>Marianne Soleil (Maid Chief)</b></td><td align="center">9</td></tr>\n};
                $chiefsoutput
                    .= qq{<tr bgcolor="$color{'1'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02.jpg' width='125' height='179'></td><td><b><u>Colette Framboise</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br />Chambermaid &#8658; [Serving -2]<br /><b>------ At the end of the game ------</b><br />If you have more Colettes employed than any other player, you gain a bonus 5 VP.  (You gain 5 VP total, not per Colette)</td></tr></table>" rel="tooltip" class="tooltip"><td>02</td><td><b><i>Colette Framboise (Chambermaid Chief)</i></b></td><td align="center">3</td></tr>\n};

                if (   ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore{'2'}
                    && ( $cgi->param('attack') ne '1' ) )
                {
                    push @costlist, '2';
                }

                last SWITCH;
            }
            if ( $chiefs eq '2' ) {
                $chiefsoutput
                    = qq{<tr bgcolor="$color{'2'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-II.jpg' width='125' height='179'></td><td><b><u>Claudine de la Rochelle</u></b><br /><i>Maid Chief</i><br /><hr />VP: 5</td></tr></table>" rel="tooltip" class="tooltip"><td>01-II</td><td><b>Claudine de la Rochelle (Maid Chief)</b></td><td align="center">8</td></tr>\n};
                $chiefsoutput
                    .= qq{<tr bgcolor="$color{'2'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-II.jpg' width='125' height='179'></td><td><b><u>Aline du Roi</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br />Chambermaid &#8658; [Serving -2]</td></tr></table>" rel="tooltip" class="tooltip"><td>02-II</td><td><b><i>Aline du Roi (Chambermaid Chief)</i></b></td><td align="center">2</td></tr>\n};

                if ( ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore{'3'} )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            if ( $chiefs eq '3' ) {
                $chiefsoutput
                    = qq{<tr bgcolor="$color{'3'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-III.jpg' width='125' height='179'></td><td><b><u>Sophia Marfil</u></b><br /><i>Maid Chief</i><br /><hr />VP: 5</td></tr></table>" rel="tooltip" class="tooltip"><td>01-III</td><td><b>Sophia Marfil (Maid Chief)</b></td><td align="center">8</td></tr>\n};
                $chiefsoutput
                    .= qq{<tr bgcolor="$color{'3'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-III.jpg' width='125' height='179'></td><td><b><u>Beatrice Escudo</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: ?<br />Chambermaid &#8658; [Serving -2]<br /><b>------ Chambermaid bonus ------</b><br />Each Beatrice: 2 VP</td></tr></table>" rel="tooltip" class="tooltip"><td>02-III</td><td><b><i>Beatrice Escudo (Chambermaid Chief)</i></b></td><td align="center">2</td></tr>\n};

                if ( ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore{'3'} )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            if ( $chiefs eq '4' ) {
                $chiefsoutput
                    = qq{<tr bgcolor="$color{'4'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-IV.jpg' width='125' height='179'></td><td><b><u>Anja Brunner</u></b><br /><i>Maid Chief</i><br /><hr />VP: 6<br /><hr /><b>------ At the end of the game ------</b><br />If you have more than 3 Nicole in your deck, Anja gains an extra 1 VP.</td></tr></table>" rel="tooltip" class="tooltip"><td>01-IV</td><td><b>Anja Brunner (Maid Chief)</b></td><td align="center">10</td></tr>\n};
                $chiefsoutput
                    .= qq{<tr bgcolor="$color{'4'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-IV.jpg' width='125' height='179'></td><td><b><u>Matilde Wiese</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br />Chambermaid &#8658; [Serving -2]<br /><b>------ During your Starting Phase ------</b><br />You may put a chambermaided Matilde into your Discard pile.  If you do, choose a card from your hand and put it back to the Town.</td></tr></table>" rel="tooltip" class="tooltip"><td>02-IV</td><td><b><i>Matilde Wiese (Chambermaid Chief)</i></b></td><td align="center">2</td></tr>\n};

                if (   ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore{'3'}
                    && ( $cgi->param('attack') ne '1' ) )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            if ( $chiefs eq '5' ) {
                $chiefsoutput
                    = qq{<tr bgcolor="$color{'5'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-V.jpg' width='125' height='179'></td><td><b><u>Leopold Niebling</u></b><br /><i>Butler Chief</i><br /><hr />VP: 6<hr /><b>------ At the end of the game ------</b><br />-1 VP for each Couple you have in your Private Quarters.</td></tr></table>" rel="tooltip" class="tooltip"><td>01-V</td><td><b>Leopold Niebling (Butler Chief)</b></td><td align="center">10</td></tr>\n};
                $chiefsoutput
                    .= qq{<tr bgcolor="$color{'5'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-V.jpg' width='125' height='179'></td><td><b><u>Beverly Snowfeldt</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br /><br />This card can not be used in an Approach.<br /><br />Chambermaid &#8658; [Serving -2]<br /><b>------ Chambermaid bonus ------</b><br />Gain 2 VP if you have one or more Leopold cards.</td></tr></table>" rel="tooltip" class="tooltip"><td>02-V</td><td><b><i>Beverly Snowfeldt (Chambermaid Chief)</i></b></td><td align="center">2</td></tr>\n};

                if ( ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore{'3'} )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            my $nothing = 0;
        }

        my $apprenticeerror;
        if (   ( $cgi->param('apprentice') eq '1' )
            && ( !$list{'66'} )
            && $chiefs eq '4' )
        {
            $apprenticeerror = 1;
        }
        $suboutput .= hidden( -name => 'apprentice' );

        my $costerror;
        if ( $cgi->param('cost') || ( $cgi->param('reminiscences') eq '2' ) )
        {
            my %counter = ();
            for my $elem ( values %costlist ) {
                for my $elem2 (@costlist) {
                    if ( $elem eq $elem2 ) {
                        if ( !exists $counter{"$elem2"} ) {
                            $counter{"$elem2"} = 1;
                        }
                        else { $counter{"$elem2"}++; }
                    }
                }
            }

            for my $elem (@costlist) {
                if ( !exists $counter{$elem} ) { $costerror = 1; }
            }

        }

    SWITCH: {
            if ( keys %list < $CARD_MAX ) {
                $suboutput
                    .= qq{<p class="error"><b>Error:</b> Less than $CARD_MAX cards available to randomize.</p>\n};
                last SWITCH;
            }
            if ($costerror) {
                $suboutput
                    .= qq{<p class="error"><b>Error:</b> No cards of one or more required cost(s) in pool of available cards.</p>\n};
                last SWITCH;
            }
            if ($crescenterror) {
                $suboutput
                    .= qq{<p class="error"><b>Error:</b> Not enough Crescent sisters in pool of available cards to meet selected minimum.</p>\n};
                last SWITCH;
            }
            if ($barmaiderror) {
                $suboutput
                    .= qq{<p class="error"><b>Error:</b> No Bar Maids in pool of available cards. (Beer cards are unusable)</p>\n};
                last SWITCH;
            }
            if ($apprenticeerror) {
                $suboutput
                    .= qq{<p class="error"><b>Error:</b> Nicole Schmieg is not available in the pool of available cards but is required by the option selections.</p>\n};
                last SWITCH;
            }

            $suboutput .= qq{<table cellpadding="10" bgcolor="#ffffff">\n};
            $suboutput .= qq{<tr><td valign="top"><table cellpadding="3">\n};
            $suboutput
                .= qq{<tr bgcolor="#036a76"><th><font color="#ffffff">Card&nbsp;#</font></th><th><font color="#ffffff">Maid/Butler Chiefs</font></th><th><font color="#ffffff">Cost</font></th></tr>\n};

            $suboutput .= $chiefsoutput;

            $suboutput
                .= qq{<tr bgcolor="#096fb8"><th><font color="#ffffff">Card&nbsp;#</font></th><th><font color="#ffffff">General Maids/Butlers</font></th><th><font color="#ffffff">Cost</font></th></tr>\n};

            my @id_numbers = ();
            @id_numbers = keys %list;
            my $counter = 1;
            my @listkey = ();

            my %cache = ();

            while ( $counter <= $CARD_MAX ) {

                my $num = q{};

                if (   $chiefs eq '4'
                    && $cgi->param('apprentice') eq '1'
                    && !( exists $cache{'66'} )
                    && !( exists $banlist{'66'} )
                    && $counter != $CARD_MAX + 1 )
                {
                    $num = '66';
                }

                if ( $num ne '66' ) {
                    if (@costlist) {
                        my @costcache    = ();
                        my $costtosearch = q{};
                        $costtosearch = shift @costlist;
                        for my $elem ( keys %costlist ) {
                            if ( $costlist{$elem} eq $costtosearch ) {
                                push @costcache, $elem;
                            }
                        }
                        $num = $costcache[ rand @costcache ];

                    }
                    else {
                        $num = $id_numbers[ rand @id_numbers ];

                    }
                }

                redo
                    if (
                       ( $cgi->param('crescent') eq '1' )
                    && ( $counter == $CARD_MAX )
                    && (   !( exists $cache{'14'} )
                        || !( exists $cache{'15'} )
                        || !( exists $cache{'16'} ) )
                    && ( $num eq '14' || $num eq '15' || $num eq '16' )
                    );

                redo
                    if (
                       ( $cgi->param('crescent') eq '2' )
                    && ( $counter > $CARD_MAX - 2 )
                    && (   !( exists $cache{'14'} )
                        || !( exists $cache{'15'} )
                        || !( exists $cache{'16'} ) )
                    && (   ( $num eq '14' )
                        || ( $num eq '15' )
                        || ( $num eq '16' ) )
                    );

                redo
                    if exists $cache{$num}
                    ;    # redo the loop if the number already exists
                $cache{"$num"} = 1;

                $listkey[$counter] = $num;
                $counter++;

                if (   ( $cgi->param('beer') eq '1' )
                    && ( $counter != $CARD_MAX + 1 )
                    && (   !( exists $cache{'55'} )
                        && !( exists $cache{'56'} ) )
                    )
                {
                    my @barmaid_ids = qw(55 56);
                    my $newnum      = $barmaid_ids[ rand @barmaid_ids ];
                    if (   !( exists $cache{"$newnum"} )
                        && !( exists $banlist{"$newnum"} ) )
                    {
                        $cache{"$newnum"} = 1;
                        $listkey[$counter] = $newnum;
                        $counter++;
                    }
                }

            CRESCENT: {
                    if (   ( $cgi->param('crescent') eq '1' )
                        && ( $num eq '14' )
                        && ( $counter != $CARD_MAX + 1 ) )
                    {
                        my @crescent_ids = qw(15 16);
                        my $newnum = $crescent_ids[ rand @crescent_ids ];
                        if ( !( exists $cache{"$newnum"} ) ) {
                            redo CRESCENT if exists $banlist{"$newnum"};
                            $cache{"$newnum"} = 1;
                            $listkey[$counter] = $newnum;
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '1' )
                        && ( $num eq '15' )
                        && ( $counter != $CARD_MAX + 1 ) )
                    {
                        my @crescent_ids = qw(14 16);
                        my $newnum = $crescent_ids[ rand @crescent_ids ];
                        if ( !( exists $cache{"$newnum"} ) ) {
                            redo CRESCENT if exists $banlist{"$newnum"};
                            $cache{"$newnum"} = 1;
                            $listkey[$counter] = $newnum;
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '1' )
                        && ( $num eq '16' )
                        && ( $counter != $CARD_MAX + 1 ) )
                    {
                        my @crescent_ids = qw(14 15);
                        my $newnum = $crescent_ids[ rand @crescent_ids ];
                        if ( !( exists $cache{"$newnum"} ) ) {
                            redo CRESCENT if exists $banlist{"$newnum"};
                            $cache{"$newnum"} = 1;
                            $listkey[$counter] = $newnum;
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '2' )
                        && ( $num eq '14' )
                        && ( $counter < $CARD_MAX ) )
                    {
                        if ( !( exists $cache{"$15"} ) ) {
                            $cache{'15'} = 1;
                            $listkey[$counter] = '15';
                            $counter++;
                        }
                        if ( !( exists $cache{"$16"} ) ) {
                            $cache{'16'} = 1;
                            $listkey[$counter] = '16';
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '2' )
                        && ( $num eq '15' )
                        && ( $counter < $CARD_MAX ) )
                    {
                        if ( !( exists $cache{"$14"} ) ) {
                            $cache{'14'} = 1;
                            $listkey[$counter] = '14';
                            $counter++;
                        }
                        if ( !( exists $cache{"$16"} ) ) {
                            $cache{'16'} = 1;
                            $listkey[$counter] = '16';
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '2' )
                        && ( $num eq '16' )
                        && ( $counter < $CARD_MAX ) )
                    {
                        if ( !( exists $cache{"$14"} ) ) {
                            $cache{'14'} = 1;
                            $listkey[$counter] = '14';
                            $counter++;
                        }
                        if ( !( exists $cache{"$15"} ) ) {
                            $cache{'15'} = 1;
                            $listkey[$counter] = '15';
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    my $nothing = 0;
                }
            }

            my @listkeysorted = ();
            @listkeysorted = sort { $a <=> $b } @listkey;

            for my $listitem (@listkeysorted) {
                $suboutput .= $list{"$listitem"};
            }

            my @removebuffer          = ();
            my @removerembuffer       = ();
            my @removeeventsbuffer    = ();
            my @removebuildingsbuffer = ();
            if ( exists $sets{'1'} ) {
                if ( $cgi->param('events')
                    || ( $cgi->param('attack') eq '1' ) )
                {
                    push
                        @removebuffer,
                        (
                        qq{<tr bgcolor="$color{'1'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20.jpg' width='125' height='179'></td><td><b><u>Nord Twilight</u></b><br /><i>Black Maid</i><br /><hr />VP: -4<br /><b>------ During your Starting Phase ------</b><br />You may discard all but one card from your hand.  If you do, send two illnesses from the town onto one maid in any Private Quarters of your choice.</td></tr></table>" rel="tooltip" class="tooltip"><td>20</td><td><b><i><font color="#990000">Nord Twilight (Black Maid)</font></i></b></td><td align="center">4</td></tr>\n}
                        );
                    push
                        @removebuffer,
                        (
                        qq{<tr bgcolor="$color{'1'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/21.jpg' width='125' height='179'></td><td><b><u>Sora Nakachi</u></b><br /><i>Private Maid</i><br /><hr />VP: 2<br /><b>------ During your Starting Phase ------</b><br />You may move one Event card from a Private Quarter of your choice to an equivalent place in another player's Private Quarters.</td></tr></table>" rel="tooltip" class="tooltip"><td>21</td><td><b><i><font color="#990000">Sora Nakachi (Private Maid)</font></i></b></td><td align="center">7</td></tr>\n}
                        );
                }
                if ( $cgi->param('attack') eq '1' ) {
                    push
                        @removebuffer,
                        (
                        qq{<tr bgcolor="$color{'1'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/19.jpg' width='125' height='179'></td><td><b><u>Amber Twilight</u></b><br /><i>Black Maid</i><br /><hr />VP: -3<br /><b>------ At the start of each other player's Discard Phase ------</b><br />The active player must discard the top card of their deck.  If the discarded card was not a Maid card, the number of cards they draw for their hand is decreased by 1.</td></tr></table>" rel="tooltip" class="tooltip"><td>19</td><td><b><i><font color="#990000">Amber Twilight (Black Maid)</font></i></b></td><td align="center">5</td></tr>\n}
                        );
                    push
                        @removebuffer,
                        (
                        qq{<tr bgcolor="$color{'1'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/25.jpg' width='125' height='179'></td><td><b><u>Eugenie Fontaine</u></b><br /><i>Private Maid</i><br /><hr /><b>------ During your Starting Phase ------</b><br />You may look at 1 random card in another player's hand.  After, you may allow that player to look at 1 random card from your hand.  If you do, exchange those two cards.</td></tr></table>" rel="tooltip" class="tooltip"><td>25</td><td><i><font color="#990000">Eugenie Fontaine (Private Maid)</font></i></td><td align="center">5</td></tr>\n}
                        );
                }
            }
            if ( exists $sets{'2'} ) {
                if ( $cgi->param('buildings') eq '1' ) {
                    push
                        @removebuffer,
                        (
                        qq{<tr bgcolor="$color{'2'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/27-II.jpg' width='125' height='179'></td><td><b><u>Silk Amanohara</u></b><br /><i>Exorcist Maid</i><br /><hr /><b>------ During your Starting Phase ------</b><br />If you have 3 or more buildings in your Private Quarters, you may draw a card.</td></tr></table>" rel="tooltip" class="tooltip"><td>27-II</td><td><i>Silk Amanohara (Exorcist Maid)</i></td><td align="center">4</td></tr>\n}
                        );
                }
                if ( $cgi->param('attack') eq '1' ) {
                    push
                        @removebuffer,
                        (
                        qq{<tr bgcolor="$color{'2'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20-II.jpg' width='125' height='179'></td><td><b><u>Mika Yakushido</u></b><br /><i>Black Maid</i><br /><hr />VP: -2<br />This maid may be placed in any player's Private Quarters.<br /><b>------ During your Starting Phase ------</b></b><br />You must discard a '1 Love' from your hand.  If you can't, reveal your hand, and put Mika back face down at the bottom of the Private Maid pile.</td></tr></table>" rel="tooltip" class="tooltip"><td>20-II</td><td><b><i><font color="#990000">Mika Yakushido (Black Maid)</font></i></b></td><td align="center">6</td></tr>\n}
                        );
                }
            }

            if ( ( exists $sets{'3'} && $cgi->param('reminiscences') eq '1' )
                || ( !exists $sets{'3'} ) )
            {
                push
                    @removebuffer,
                    (
                    qq{<tr bgcolor="$color{'101'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR14.jpg' width='125' height='179'></td><td><b><u>Liliana Giornata</u></b><br /><i>Private Maid</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr />VP: 2<br /><b>------ During your Starting Phase ------</b><br />If you have the Reminiscence card \'Astronomic Observation\' in your Private Quarters, you gain [Love +1] and [Employment +1]</td></tr></table>" rel="tooltip" class="tooltip"><td>PR14</td><td><b><i>Liliana Giornata (Private Maid)</i></b></td><td align="center">5</td></tr>\n}
                    );
            }
            if (exists $sets{'3'}
                && (   ( $cgi->param('attack') eq '1' )
                    && ( $cgi->param('reminiscences') ne '1' ) )
                )
            {
                push
                    @removerembuffer,
                    (
                    qq{<tr bgcolor="$color{'3'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/30-III.jpg' width='125' height='179'></td><td><b><u>Scary Night</u></b><br /><i>Reminiscence</i><br /><b><i>Note: There are 3 of these cards in the set</i></b><br /><hr />VP: 3<br /><b>1 card with an employ cost 3<br />1 card with an employ cost 2</b><br />Every other player discards down to 3 cards in their hand.</td></tr></table>" rel="tooltip" class="tooltip"><td>30-III</td><td colspan="2"><font color="#990000"><b>Scary Night</b></font> (3 cards)</td></tr>\n}
                    );
            }

            if ( ( exists $sets{'4'} && $cgi->param('beer') eq '2' )
                || !exists $sets{'4'} )
            {
                push
                    @removebuffer,
                    (
                    qq{<tr bgcolor="$color{'101'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR19.jpg' width='125' height='179'></td><td><b><u>Astrid Wende</u></b><br /><i>Private Maid</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr />VP: 1<br /><b>------ During your Starting Phase ------</b><br />You may discard the top card of your deck.  If your discarded card was a Love card, you may discard 2 cards with a cost 4 or more.  If you do, gain a beer card.</td></tr></table>" rel="tooltip" class="tooltip"><td>PR19</td><td><b><i>Astrid Wende (Private Maid)</i></b></td><td align="center">6</td></tr>\n}
                    );
                push
                    @removebuffer,
                    (
                    qq{<tr bgcolor="$color{'101'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR34.jpg' width='125' height='179'></td><td><b><u>Ursula Fassbender</u></b><br /><i>Private Maid</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr />VP: 1<br /><b>------ At the end of the game ------</b><br />If you have 4 or more Beer cards in your Private Quarters, gain +3 VP.</td></tr></table>" rel="tooltip" class="tooltip"><td>PR34</td><td><b><i>Ursula Fassbender (Private Maid)</i></b></td><td align="center">4</td></tr>\n}
                    );
            }
            if ( exists $sets{'4'} ) {
                if ((   (   (   $cgi->param('beer') eq '2' && !(
                                    (   exists $sets{'2'}
                                        || ( exists $sets{'5'}
                                            && !$cgi->param('couples') )
                                    )
                                    || !(
                                        !exists $sets{'2'}
                                        || ( exists $sets{'5'}
                                            && $cgi->param('couples') )
                                    )
                                )
                            )
                            || ( $cgi->param('buildings') )
                        )
                        && !(
                               $cgi->param('events')
                            || $cgi->param('attack') eq '1'
                        )
                    )
                    && !(
                        $cgi->param('attack') eq '2'
                        && !$cgi->param('buildings')
                    )
                    )
                {
                    push
                        @removeeventsbuffer,
                        (
                        qq{<tr bgcolor="$color{'4'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20-IV.jpg' width='125' height='179'></td><td><b><u>Heavy Storm</u></b><br /><i>Event</i><br /><b><i>Note: There are 8 of these in the set</i></b><br /><hr />This is placed onto a Building in any player's Private Quarters.  All cards placed underneath this card are treated as though they don't exist.<br /><b>------ At the beginning of your turn ------</b><br />You may Discard a '3 Love' Card from your hand.  If you do, put this card back to the Town.</td></tr></table>" rel="tooltip" class="tooltip"><td>20-IV</td><td><font color="#990000">Heavy Storm</font></td><td align="center">5</td></tr>\n}
                        );
                }
                if (( $cgi->param('beer') eq '2' )
                    && (!(     $cgi->param('events')
                            || $cgi->param('attack') eq '1'
                        )
                    )
                    )
                {
                    push
                        @removeeventsbuffer,
                        (
                        qq{<tr bgcolor="$color{'4'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/21-IV.jpg' width='125' height='179'></td><td><b><u>Let me drink!</u></b><br /><i>Event</i><br /><b><i>Note: There are 8 of these in the set</i></b><br /><hr />When you gain this card, put this card onto your Private Quarters.<br /><b>------ At the beginning of your turn ------</b><br />Discard a Love card from your hand and remove this card from the game.  If you do, take a Beer card from any player's Private Quarters and add it to your Private Quarters.</td></tr></table>" rel="tooltip" class="tooltip"><td>21-IV</td><td><font color="#990000">Let me drink!</font></td><td align="center">5</td></tr>\n}
                        );
                }
            }

            if ( exists $sets{'5'} ) {

                my $blizzard = 0;
                if ( $cgi->param('couples')
                    && ( !exists $sets{'2'} || !exists $sets{'4'} ) )
                {
                    $blizzard = 1;
                }
                if ( exists $sets{'2'} || exists $sets{'4'} ) {
                    $blizzard = 0;
                }
                if ((   !exists $sets{'2'}
                        && (!exists $sets{'4'}
                            || ( exists $sets{'4'}
                                && $cgi->param('beer') eq '2' )
                        )
                    )
                    && ( $cgi->param('couples') || $cgi->param('buildings') )
                    )
                {
                    $blizzard = 1;
                }
                if ( ( exists $sets{'2'} || exists $sets{'4'} )
                    && $cgi->param('buildings') )
                {
                    $blizzard = 1;
                }
                if ( $cgi->param('events') || $cgi->param('attack') eq '1' ) {
                    $blizzard = 0;
                }

                if ($blizzard) {

                    push
                        @removeeventsbuffer,
                        (
                        qq{<tr bgcolor="$color{'5'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20-V.jpg' width='125' height='179'></td><td><b><u>Blizzard</u></b><br /><i>Event</i><br /><b><i>Note: There are 8 of these in the set</i></b><br /><hr />Play this card on top of a Building card.  Any VP and any ability from cards underneath this card are lost.<br /><b>------ Employ Phase ------</b><br />You may discard any four Love cards to return this card to the town.</td></tr></table>" rel="tooltip" class="tooltip"><td>20-V</td><td><font color="#990000">Blizzard</font></td><td align="center">6</td></tr>\n}
                        );

                }
                if ((   !$cgi->param('couples')
                        && (   $cgi->param('attack') eq '1'
                            || $cgi->param('events') )
                    )
                    && !$cgi->param('buildings')
                    )
                {
                    push
                        @removebuildingsbuffer,
                        (
                        qq{<tr bgcolor="$color{'101'}" title="<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR43.jpg' width='125' height='179'></td><td><b><u>Chapel</u></b><br /><i>Building</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr /><br />When another player is playing an Event card against you, you may remove this Chapel card from the game.  If you do, ignore the effects of that Event card.</td></tr></table>" rel="tooltip" class="tooltip"><td>PR43</td><td><font color="#000000">Chapel</font></td><td align="center">6</td></tr>\n}
                        );
                }
            }

            if (   ( @removebuffer && !$cgi->param('private') )
                || @removerembuffer
                || @removeeventsbuffer )
            {
                $suboutput
                    .= '<tr bgcolor="#ffffff"><th colspan="3"></th>&nbsp;</tr><tr bgcolor="#000000"><th colspan="3"><font color="#ffffff">Remove the following from game:</font></th></tr>';
                if ( @removebuffer && !$cgi->param('private') ) {
                    $suboutput
                        .= qq{<tr bgcolor="#1f1a23"><th><font color="#ffffff">Card&nbsp;#</font></th><th><font color="#ffffff">Private Maids</font></th><th><font color="#ffffff">Cost</font></th></tr>\n};
                    for my $elem (@removebuffer) {
                        $suboutput .= $elem;
                    }
                }

                if (@removerembuffer) {
                    $suboutput
                        .= qq{<tr bgcolor="#fbb450"><th><font color="#ffffff">Card&nbsp;#</font></th><th colspan="2"><font color="#ffffff">Reminiscences</font></th></tr>\n};
                    for my $elem (@removerembuffer) {
                        $suboutput .= $elem;
                    }
                }

                if (@removeeventsbuffer) {
                    $suboutput
                        .= qq{<tr bgcolor="#8652A1"><th><font color="#ffffff">Card&nbsp;#</font></th><th><font color="#ffffff">Events</font></th><th><font color="#ffffff">Cost</font></th></tr>\n};
                    for my $elem (@removeeventsbuffer) {
                        $suboutput .= $elem;
                    }
                }

                if (@removebuildingsbuffer) {
                    $suboutput
                        .= qq{<tr bgcolor="#f37a45"><th><font color="#ffffff">Card&nbsp;#</font></th><th><font color="#ffffff">Buildings</font></th><th><font color="#ffffff">Cost</font></th></tr>\n};
                    for my $elem (@removebuildingsbuffer) {
                        $suboutput .= $elem;
                    }
                }

            }

            $suboutput .= <<"END_COLORKEY";
</table></td>

<td align="center" valign="top" width="310">

<small><b>Touch or hover over each card name for information on the card's effects.</b><br /><br /></small>

<table>

<tr><th colspan="2">Color Legend:</th></tr>
<tr><td width="25" bgcolor="$color{1}">&nbsp;</td><td>Tanto Cuore</td></tr>
<tr><td width="25" bgcolor="$color{2}">&nbsp;</td><td>Expanding the House</td></tr>
<tr><td width="25" bgcolor="$color{3}">&nbsp;</td><td>Romantic Vacation</td></tr>
<tr><td width="25" bgcolor="$color{4}">&nbsp;</td><td>Oktoberfest</td></tr>
<tr><td width="25" bgcolor="$color{5}">&nbsp;</td><td>Winter Romance</td></tr>
<tr><td width="25" bgcolor="$color{101}">&nbsp;</td><td>Promo Card</td></tr>
</table>

<br /><table><tr><th colspan="2">Text Legend:</th></tr><tr><td>Red:</td><td><font color="#990000">Card can negatively affect other players</font></td></tr><tr><td>Bold:</td><td><b>Card has a VP indicator</b></td></tr><tr><td>Italics:</td><td><i>Chambermaid</i></td></tr></table>
END_COLORKEY

            $suboutput
                .= '<br /><p>'
                . &$to_page('Randomize Again With Same Options')
                . "</p>\n";

            $suboutput
                .= '<p>' . &$to_page('New Randomization Criteria') . "</p>\n";
            $newbutton = 0;
            $suboutput .= "</td></tr></table>\n";

        }

    }
    if ($newbutton) {
        $suboutput
            .= '<p>' . &$to_page('New Randomization Criteria') . "</p>\n";
    }

    $suboutput .= '<br />' . $donate;

    return $suboutput;
};

my %states         = ();
my $current_screen = q{};

%states = (
    'Default'                           => \&$front_page,
    'New Randomization Criteria'        => \&$front_page,
    'Randomize'                         => \&$randomize,
    'Randomize Again With Same Options' => \&$randomize,
);

$current_screen = $cgi->param('.State') || 'Default';

if ( !$states{$current_screen} ) {
    croak "No screen for $current_screen";
}

while ( my ( $screen_name, $function ) = each %states ) {
    $output .= $function->( $screen_name eq $current_screen );
}

$output .= $cgi->end_form();
$dbh->disconnect;

$output .= <<'END_FOOTER';
</div>
</body>
</html>
END_FOOTER

print $output;

