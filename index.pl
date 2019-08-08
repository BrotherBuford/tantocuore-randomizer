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
use HTML::Entities;

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

Readonly my %COLOR_OF => (
    '1'   => '#ffccee',
    '2'   => '#ffddbb',
    '3'   => '#cceeff',
    '4'   => '#ddaa88',
    '5'   => '#5b97ab',
    '101' => '#ffffaa',
);

my $to_page = sub {
    return $cgi->submit(
        -NAME  => '.Page',
        -CLASS => 'topage',
        -VALUE => shift
    );
};

my $card_format = sub {
    my ($cf_gameset, $cf_cardnum, $cf_name,
        $cf_title,   $cf_notes,   $cf_cost,
        $cf_attack,  $cf_vp,      $cf_chambermaid
    ) = @ARG;

    my $prgameset;
    my $gameset;

    ( $prgameset, $gameset )
        = ( $cf_gameset eq '1' )   ? ( q{},  q{} )
        : ( $cf_gameset eq '2' )   ? ( q{},  '-II' )
        : ( $cf_gameset eq '3' )   ? ( q{},  '-III' )
        : ( $cf_gameset eq '4' )   ? ( q{},  '-IV' )
        : ( $cf_gameset eq '5' )   ? ( q{},  '-V' )
        : ( $cf_gameset eq '101' ) ? ( 'PR', q{} )
        :                            ( $prgameset, $gameset );

    my $cardnumber      = sprintf '%02d', "$cf_cardnum";
    my $carddesignation = $prgameset . $cardnumber . $gameset;

    my $suboutput = qq{<tr bgcolor='$COLOR_OF{$cf_gameset}' title='};

    my $tooltip = $h->table(
        {   border      => '0',
            cellpadding => '8',
            cellspacing => '0',
        },
        [   $h->tr(
                { valign => 'top', },
                [   $h->td(
                        $h->img(
                            {   src    => "./cards/$carddesignation.jpg",
                                width  => '125',
                                height => '179',
                            }
                        )
                    ),
                    $h->td(
                              $h->b( $h->tag( 'u', "$cf_name" ) )
                            . $h->br
                            . $h->i("$cf_title")
                            . $h->br
                            . $h->hr
                            . "$cf_notes"
                    )
                ]
            )
        ]
    );

    encode_entities($tooltip);
    $suboutput .= $tooltip;

    my $display_name = $cf_name;
    if ($cf_title) {
        $display_name .= qq{ ($cf_title)};
    }

    if ( $cf_attack eq '1' ) {
        $display_name
            = $h->tag( 'font', { color => '#990000' }, "$display_name" );
    }

    if ( $cf_vp eq '1' ) {
        $display_name = $h->b("$display_name");
    }

    if ( $cf_chambermaid eq '1' ) {
        $display_name = $h->i("$display_name");
    }

    $suboutput
        .= qq{' rel='tooltip' class='tooltip'><td>$carddesignation</td><td>}
        . $display_name
        . qq{</td><td align='center'>$cf_cost</td></tr>\n};

    return $suboutput;
};

my $cardlist_other_query = sub {

    my ( $sub_gameset, $sub_cardnumber ) = @ARG;
    my @query_result = ();
    my $sql          = <<"END_SQL";
	  SELECT
   gameset,
   cardnumber,
   name,
   title,
   description,
   cost,
   attack,
   vp,
   chambermaid
	  FROM cardlist_other WHERE cardnumber = '$sub_cardnumber'
          AND gameset = '$sub_gameset'
END_SQL

    my $cursor = $dbh->prepare($sql);

    $cursor->execute;

    @query_result = $cursor->fetchrow;

    $cursor->finish;

    return @query_result;

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
    . qq {<html xmlns="http://www.w3.org/1999/xhtml">\n};

$output .= $h->head(
    [   $h->title('Tanto Cuore &#9829; Town Randomizer'),
        $h->meta(
            {   'http-equiv' => 'Content-Type',
                content      => 'text/html;charset=ISO-8859-1',
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
    @selectedbans = scalar $cgi->param('banned');

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
    @selectedsets = scalar $cgi->param('sets');

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

                                        {   align  => 'center',
                                            valign => 'middle',
                                        },
                                        '&nbsp;&nbsp;'
                                            . &{$to_page}('Randomize')

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
                . $h->small('All option sections may be combined')
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
        .= '<p class="hiddenoptions">' . &{$to_page}('Randomize') . '</p>';
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

    my $sql = q{};

    if ( !$cgi->param('sets') ) {
        $suboutput
            .= qq{<p class="error"><b>Error:</b> No game sets selected.  You must choose at least one game set.</b></p>\n};
    }
    else {

        my @sets = ();
        @sets = $cgi->param('sets');
        my %set_is        = ();
        my $setlist_sql = q{};
        my $banlist_sql = q{};
        my $options_sql = q{};
        my @chiefs      = ();
        for my $elem (@sets) {

            $cgi->param(
                -name  => 'sets',
                -value => "$elem"
            );

            $setlist_sql .= qq{ or gameset = "$elem"};
            $set_is{$elem} = 1;
            if ( $elem ne '101' ) {
                push @chiefs, $elem;
            }
        }

        $suboutput .= hidden( -name => 'sets' );

        $setlist_sql =~ s{\A\sor}{}xms;

        my @banned = ();
        @banned = $cgi->param('banned');

        my %ban_for = ();

        for my $elem (@banned) {

            $cgi->param(
                -name  => 'banned',
                -value => "$elem"
            );
            $ban_for{$elem} = 1;
            $banlist_sql .= qq{ and ID != "$elem"};
        }
        $suboutput .= hidden( -name => 'banned' );
        $banlist_sql =~ s{\A\sand}{}xms;

        if ( $cgi->param('attack') ) {
            $cgi->param(
                -name  => 'attack',
                -value => $cgi->param('attack')
            );
        SWITCH: {
                if ( $cgi->param('attack') eq '1' ) {
                    $options_sql = ' and (attack != "1") and (events != "1")';
                    last SWITCH;
                }
                if ( $cgi->param('attack') eq '2' ) {
                    $sql = ' and (attack = "1")';
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
            $options_sql = ' and (events != "1")';
            $suboutput .= hidden( -name => 'events' );
        }

        if ( $cgi->param('beer') eq '2' ) {
            $cgi->param(
                -name  => 'beer',
                -value => $cgi->param('beer')
            );
            $options_sql = ' and (beer != "1")';
        }
        if ( $cgi->param('beer') ) {
            $suboutput .= hidden( -name => 'beer' );
        }

        if ( $cgi->param('buildings') ) {
            $cgi->param(
                -name  => 'buildings',
                -value => $cgi->param('buildings')
            );
            $options_sql = ' and (buildings != "1")';
            $suboutput .= hidden( -name => 'buildings' );
        }

        if ( $cgi->param('private') ) {
            $cgi->param(
                -name  => 'private',
                -value => $cgi->param('private')
            );
            $options_sql = ' and (private != "1")';
            $suboutput .= hidden( -name => 'private' );
        }

        if ( $cgi->param('reminiscences') ) {
            if ( $cgi->param('reminiscences') eq '1' ) {
                $options_sql = ' and (reminiscences != "1")';
            }
            $cgi->param(
                -name  => 'reminiscences',
                -value => $cgi->param('reminiscences')
            );
            $suboutput .= hidden( -name => 'reminiscences' );
        }

        if ( $cgi->param('couples') ) {
            $cgi->param(
                -name  => 'couples',
                -value => $cgi->param('couples')
            );
            $options_sql = ' and (couples != "1")';
            $suboutput .= hidden( -name => 'couples' );
        }

        my %cost_of = ();

        my @fields = ();
        my @list   = ();
        my %list_has   = ();
        $sql = <<'END_SQL';
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

        ($sql) .=
              ($banlist_sql) ? ( ' and (' . $banlist_sql . ')' )
            : ($options_sql) ? ($options_sql)
            :                  (q{});

        my $cursor = $dbh->prepare($sql);

        $cursor->execute;

        @fields = ();
        @list   = ();
        %list_has   = ();

        while ( @fields = $cursor->fetchrow ) {

            $cost_of{ $fields['0'] } = "$fields['5']";

            $list_has{"$fields['0']"} = &{$card_format}(
                $fields['2'], $fields['4'],  $fields['1'],
                $fields['3'], $fields['12'], $fields['5'],
                $fields['8'], $fields['7'],  $fields['6']
            );

        }

        $cursor->finish;

        my $barmaiderror = q{};
        if (   ( $cgi->param('beer') eq '1' )
            && ( !$list_has{'55'} && !$list_has{'56'} ) )
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

                    ($crescenterror)
                        = ( $list_has{'14'} && !( $list_has{'15'} || $list_has{'16'} ) )
                        ? ('1')
                        : ( $list_has{'15'} && !( $list_has{'14'} || $list_has{'16'} ) )
                        ? ('1')
                        : ( $list_has{'16'} && !( $list_has{'14'} || $list_has{'15'} ) )
                        ? ('1')
                        : ($crescenterror);
                    last SWITCH;
                }
                if (   ( $cgi->param('crescent') eq '2' )
                    && ( $list_has{'14'} || $list_has{'15'} || $list_has{'16'} )
                    && !( $list_has{'14'} && $list_has{'15'} && $list_has{'16'} ) )
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
        my %costignore_has = ();
        for my $elem (@costlist) {
        SWITCH: {
                if ( $elem eq '2' ) {
                    $costignore_has{'2'} = 1;
                    last SWITCH;
                }
                if ( $elem eq '3' ) {
                    $costignore_has{'3'} = 1;
                    last SWITCH;
                }
                if ( $elem eq '5' ) {
                    $costignore_has{'5'} = 1;
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
            && !exists $costignore_has{'5'} )
        {
            push @costlist, '5';
        }

        my $chiefsindex  = rand @chiefs;
        my $chiefs       = $chiefs[$chiefsindex];
        my $chiefsoutput = q{};

    SWITCH: {
            if ( $chiefs eq '1' ) {
                $chiefsoutput
                    = &{$card_format}( &{$cardlist_other_query}(qw(1 1)) );

                $chiefsoutput
                    .= &{$card_format}( &{$cardlist_other_query}(qw(1 2)) );

                if (   ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore_has{'2'}
                    && ( $cgi->param('attack') ne '1' ) )
                {
                    push @costlist, '2';
                }

                last SWITCH;
            }
            if ( $chiefs eq '2' ) {
                $chiefsoutput
                    = &{$card_format}( &{$cardlist_other_query}(qw(2 1)) );

                $chiefsoutput
                    .= &{$card_format}( &{$cardlist_other_query}(qw(2 2)) );

                if ( ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore_has{'3'} )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            if ( $chiefs eq '3' ) {
                $chiefsoutput
                    = &{$card_format}( &{$cardlist_other_query}(qw(3 1)) );

                $chiefsoutput
                    .= &{$card_format}( &{$cardlist_other_query}(qw(3 2)) );

                if ( ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore_has{'3'} )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            if ( $chiefs eq '4' ) {
                $chiefsoutput
                    = &{$card_format}( &{$cardlist_other_query}(qw(4 1)) );

                $chiefsoutput
                    .= &{$card_format}( &{$cardlist_other_query}(qw(4 2)) );

                if (   ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore_has{'3'}
                    && ( $cgi->param('attack') ne '1' ) )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            if ( $chiefs eq '5' ) {
                $chiefsoutput
                    = &{$card_format}( &{$cardlist_other_query}(qw(5 1)) );

                $chiefsoutput
                    .= &{$card_format}( &{$cardlist_other_query}(qw(5 2)) );

                if ( ( $cgi->param('reminiscences') eq '2' )
                    && !exists $costignore_has{'3'} )
                {
                    push @costlist, '3';
                }

                last SWITCH;
            }
            my $nothing = 0;
        }

        my $apprenticeerror;
        if (   ( $cgi->param('apprentice') eq '1' )
            && ( !$list_has{'66'} )
            && $chiefs eq '4' )
        {
            $apprenticeerror = 1;
        }
        $suboutput .= hidden( -name => 'apprentice' );

        my $costerror;
        if ( $cgi->param('cost') || ( $cgi->param('reminiscences') eq '2' ) )
        {
            my %counter_has = ();
            for my $elem ( values %cost_of ) {
                for my $elem2 (@costlist) {
                    if ( $elem eq $elem2 ) {
                        if ( !exists $counter_has{"$elem2"} ) {
                            $counter_has{"$elem2"} = 1;
                        }
                        else { $counter_has{"$elem2"}++; }
                    }
                }
            }

            for my $elem (@costlist) {
                if ( !exists $counter_has{$elem} ) { $costerror = 1; }
            }

        }

    SWITCH: {
            if ( keys %list_has < $CARD_MAX ) {
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
            @id_numbers = keys %list_has;
            my $counter = 1;
            my @listkey = ();

            my %cache_has = ();

            while ( $counter <= $CARD_MAX ) {

                my $num = q{};

                if (   $chiefs eq '4'
                    && $cgi->param('apprentice') eq '1'
                    && !( exists $cache_has{'66'} )
                    && !( exists $ban_for{'66'} )
                    && $counter != $CARD_MAX + 1 )
                {
                    $num = '66';
                }

                if ( $num ne '66' ) {
                    if (@costlist) {
                        my @costcache    = ();
                        my $costtosearch = q{};
                        $costtosearch = shift @costlist;
                        for my $elem ( keys %cost_of ) {
                            if ( $cost_of{$elem} eq $costtosearch ) {
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
                    && (   !( exists $cache_has{'14'} )
                        || !( exists $cache_has{'15'} )
                        || !( exists $cache_has{'16'} ) )
                    && ( $num eq '14' || $num eq '15' || $num eq '16' )
                    );

                redo
                    if (
                       ( $cgi->param('crescent') eq '2' )
                    && ( $counter > $CARD_MAX - 2 )
                    && (   !( exists $cache_has{'14'} )
                        || !( exists $cache_has{'15'} )
                        || !( exists $cache_has{'16'} ) )
                    && (   ( $num eq '14' )
                        || ( $num eq '15' )
                        || ( $num eq '16' ) )
                    );

                redo
                    if exists $cache_has{$num}
                    ;    # redo the loop if the number already exists
                $cache_has{"$num"} = 1;

                $listkey[$counter] = $num;
                $counter++;

                if (   ( $cgi->param('beer') eq '1' )
                    && ( $counter != $CARD_MAX + 1 )
                    && (   !( exists $cache_has{'55'} )
                        && !( exists $cache_has{'56'} ) )
                    )
                {
                    my @barmaid_ids = qw(55 56);
                    my $newnum      = $barmaid_ids[ rand @barmaid_ids ];
                    if (   !( exists $cache_has{"$newnum"} )
                        && !( exists $ban_for{"$newnum"} ) )
                    {
                        $cache_has{"$newnum"} = 1;
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
                        if ( !( exists $cache_has{"$newnum"} ) ) {
                            redo CRESCENT if exists $ban_for{"$newnum"};
                            $cache_has{"$newnum"} = 1;
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
                        if ( !( exists $cache_has{"$newnum"} ) ) {
                            redo CRESCENT if exists $ban_for{"$newnum"};
                            $cache_has{"$newnum"} = 1;
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
                        if ( !( exists $cache_has{"$newnum"} ) ) {
                            redo CRESCENT if exists $ban_for{"$newnum"};
                            $cache_has{"$newnum"} = 1;
                            $listkey[$counter] = $newnum;
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '2' )
                        && ( $num eq '14' )
                        && ( $counter < $CARD_MAX ) )
                    {
                        if ( !( exists $cache_has{"$15"} ) ) {
                            $cache_has{'15'} = 1;
                            $listkey[$counter] = '15';
                            $counter++;
                        }
                        if ( !( exists $cache_has{"$16"} ) ) {
                            $cache_has{'16'} = 1;
                            $listkey[$counter] = '16';
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '2' )
                        && ( $num eq '15' )
                        && ( $counter < $CARD_MAX ) )
                    {
                        if ( !( exists $cache_has{"$14"} ) ) {
                            $cache_has{'14'} = 1;
                            $listkey[$counter] = '14';
                            $counter++;
                        }
                        if ( !( exists $cache_has{"$16"} ) ) {
                            $cache_has{'16'} = 1;
                            $listkey[$counter] = '16';
                            $counter++;
                        }
                        last CRESCENT;
                    }
                    if (   ( $cgi->param('crescent') eq '2' )
                        && ( $num eq '16' )
                        && ( $counter < $CARD_MAX ) )
                    {
                        if ( !( exists $cache_has{"$14"} ) ) {
                            $cache_has{'14'} = 1;
                            $listkey[$counter] = '14';
                            $counter++;
                        }
                        if ( !( exists $cache_has{"$15"} ) ) {
                            $cache_has{'15'} = 1;
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
                $suboutput .= $list_has{"$listitem"};
            }

            my @removebuffer          = ();
            my @removerembuffer       = ();
            my @removeeventsbuffer    = ();
            my @removebuildingsbuffer = ();
            if ( exists $set_is{'1'} ) {
                if ( $cgi->param('events')
                    || ( $cgi->param('attack') eq '1' ) )
                {
                    push
                        @removebuffer,
                        (
                        &{$card_format}( &{$cardlist_other_query}(qw(1 20)) )
                        );
                    push
                        @removebuffer,
                        (
                        &{$card_format}( &{$cardlist_other_query}(qw(1 21)) )
                        );
                }
                if ( $cgi->param('attack') eq '1' ) {
                    push
                        @removebuffer,
                        (
                        &{$card_format}( &{$cardlist_other_query}(qw(1 19)) )
                        );
                    push
                        @removebuffer,
                        (
                        &{$card_format}( &{$cardlist_other_query}(qw(1 25)) )
                        );
                }
            }
            if ( exists $set_is{'2'} ) {
                if ( $cgi->param('buildings') eq '1' ) {
                    push @removebuffer,
                        (
                        &{$card_format}( &{$cardlist_other_query}(qw(2 27)) )
                        );
                }
                if ( $cgi->param('attack') eq '1' ) {
                    push
                        @removebuffer,
                        (
                        &{$card_format}( &{$cardlist_other_query}(qw(2 20)) )
                        );
                }
            }

            if ( ( exists $set_is{'3'} && $cgi->param('reminiscences') eq '1' )
                || ( !exists $set_is{'3'} ) )
            {
                push
                    @removebuffer,
                    (
                    &{$card_format}( &{$cardlist_other_query}(qw(101 14)) ) );
            }
            if (exists $set_is{'3'}
                && (   ( $cgi->param('attack') eq '1' )
                    && ( $cgi->param('reminiscences') ne '1' ) )
                )
            {
                push
                    @removerembuffer,
                    ( &{$card_format}( &{$cardlist_other_query}(qw(3 30)) ) );
            }

            if ( ( exists $set_is{'4'} && $cgi->param('beer') eq '2' )
                || !exists $set_is{'4'} )
            {
                push
                    @removebuffer,
                    (
                    &{$card_format}( &{$cardlist_other_query}(qw(101 19)) ) );
                push
                    @removebuffer,
                    (
                    &{$card_format}( &{$cardlist_other_query}(qw(101 34)) ) );
            }
            if ( exists $set_is{'4'} ) {
                if ((   (   (   $cgi->param('beer') eq '2' && !(
                                    (   exists $set_is{'2'}
                                        || ( exists $set_is{'5'}
                                            && !$cgi->param('couples') )
                                    )
                                    || !(
                                        !exists $set_is{'2'}
                                        || ( exists $set_is{'5'}
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
                        &{$card_format}( &{$cardlist_other_query}(qw(4 20)) )
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
                        &{$card_format}( &{$cardlist_other_query}(qw(4 21)) )
                        );
                }
            }

            if ( exists $set_is{'5'} ) {

                my $blizzard = 0;
                if ( $cgi->param('couples')
                    && ( !exists $set_is{'2'} || !exists $set_is{'4'} ) )
                {
                    $blizzard = 1;
                }
                if ( exists $set_is{'2'} || exists $set_is{'4'} ) {
                    $blizzard = 0;
                }
                if ((   !exists $set_is{'2'}
                        && (!exists $set_is{'4'}
                            || ( exists $set_is{'4'}
                                && $cgi->param('beer') eq '2' )
                        )
                    )
                    && ( $cgi->param('couples') || $cgi->param('buildings') )
                    )
                {
                    $blizzard = 1;
                }
                if ( ( exists $set_is{'2'} || exists $set_is{'4'} )
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
                        &{$card_format}( &{$cardlist_other_query}(qw(5 20)) )
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
                        ( &{$card_format}
                            ( &{$cardlist_other_query}(qw(101 43)) ) );
                }
            }

            if (   ( @removebuffer && !$cgi->param('private') )
                || @removerembuffer
                || @removeeventsbuffer )
            {
                $suboutput
                    .= '<tr bgcolor="#ffffff"><th colspan="3">&nbsp;</th></tr><tr bgcolor="#000000"><th colspan="3"><font color="#ffffff">Remove the following from game:</font></th></tr>';
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
<tr><td width="25" bgcolor="$COLOR_OF{1}">&nbsp;</td><td>Tanto Cuore</td></tr>
<tr><td width="25" bgcolor="$COLOR_OF{2}">&nbsp;</td><td>Expanding the House</td></tr>
<tr><td width="25" bgcolor="$COLOR_OF{3}">&nbsp;</td><td>Romantic Vacation</td></tr>
<tr><td width="25" bgcolor="$COLOR_OF{4}">&nbsp;</td><td>Oktoberfest</td></tr>
<tr><td width="25" bgcolor="$COLOR_OF{5}">&nbsp;</td><td>Winter Romance</td></tr>
<tr><td width="25" bgcolor="$COLOR_OF{101}">&nbsp;</td><td>Promo Card</td></tr>
</table>

<br /><table><tr><th colspan="2">Text Legend:</th></tr><tr><td>Red:</td><td><font color="#990000">Card can negatively affect other players</font></td></tr><tr><td>Bold:</td><td><b>Card has a VP indicator</b></td></tr><tr><td>Italics:</td><td><i>Chambermaid</i></td></tr></table>
END_COLORKEY

            $suboutput
                .= '<br /><p>'
                . &{$to_page}('Randomize Again With Same Options')
                . "</p>\n";

            $suboutput
                .= '<p>'
                . &{$to_page}('New Randomization Criteria')
                . "</p>\n";
            $newbutton = 0;
            $suboutput .= "</td></tr></table>\n";

        }

    }
    if ($newbutton) {
        $suboutput
            .= '<p>' . &{$to_page}('New Randomization Criteria') . "</p>\n";
    }

    $suboutput .= '<br />' . $donate;

    return $suboutput;
};

my %page_is         = ();
my $current_screen = q{};

%page_is = (
    'Default'                           => \&{$front_page},
    'New Randomization Criteria'        => \&{$front_page},
    'Randomize'                         => \&{$randomize},
    'Randomize Again With Same Options' => \&{$randomize},
);

$current_screen = $cgi->param('.Page') || 'Default';

if ( !$page_is{$current_screen} ) {
    croak "No screen for $current_screen";
}

while ( my ( $screen_name, $function ) = each %page_is ) {
    $output .= $function->( $screen_name eq $current_screen );
}

$output .= $cgi->end_form();
$dbh->disconnect;

$output .= <<'END_FOOTER';
</div>
</body>
</html>
END_FOOTER

print $output || croak;

