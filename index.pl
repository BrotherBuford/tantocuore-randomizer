#!/usr/bin/perl

package TantoCuoreRandomizer;

use lib qw( /home/brotherbuford/perlmods/lib/perl/5.14
	    /home/brotherbuford/perlmods/lib/perl/5.14.2
	    /home/brotherbuford/perlmods/share/perl/5.14
	    /home/brotherbuford/perlmods/share/perl/5.14.2
	    /home/brotherbuford/perlmods/local/share/perl/5.14.2
	    /home/brotherbuford/perlmods/local/lib/perl/5.14.2 );

# use FCGI;
use Socket qw( :crlf ); # server agnostic line endings in $CRLF

use strict;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Apache::DBI();
use HTML::Entities;
      
$main::cgi = new CGI; # to take advantage of the "param" decoding method

$main::dbh = DBI->connect('DBI:mysql:tantocuore:mysql.nekomusume.net', 'tantocuore','TantoCuorePass',
		       { PrintError => 0}) || die $DBI::errstr;

my %States;
my $Current_Screen;

%States = (
	   'Default'              => \&TantoCuoreRandomizer::front_page,
	   'New Randomization Criteria'              => \&TantoCuoreRandomizer::front_page,
	   'Randomize'       => \&TantoCuoreRandomizer::randomize,
	   'Randomize Again With Same Options'       => \&TantoCuoreRandomizer::randomize
	  );

$Current_Screen = param(".State") || "Default";
die "No screen for $Current_Screen" unless $States{$Current_Screen};

my $cgi = new CGI;

my $donate = q \
<p style="font-size: 0.75em"><b>If you find this app useful, buy me a beer!<br />

<script type="text/javascript" src="coinwidget/coin.js"></script>
<script type="text/javascript" src="coinwidget/config.js"></script>

</p>
\;
  

print header();

print q \
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta name="description" content="A card randomizer utility for the games Tanto Cuore, Tanto Cuore: Expanding the House, Tanto Cuore: Romantic Vacation, Tanto Cuore: Oktoberfest, and Tanto Cuore: Winter Romance." />

  <link rel="shortcut icon" href="./images/favicon.ico" />
  <link rel="stylesheet" type="text/css" href="./css/tc.css" />
  <title>Tanto Cuore &#9829; Town Randomizer</title>

<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="./js/tooltip.js"></script> 

  </head>

<body style="background-color:#ffccee;background-image:url('images/hearts.gif');">

<div align="center">
\;

print start_form();

while (my($screen_name, $function) = each %States) {
  $function->($screen_name eq $Current_Screen);
}

print end_form();
$main::dbh->disconnect;

print q \
</div>

</body>
</html>
\;


sub front_page {
  my $active = shift;
  return unless $active;

  my @list;
  my @fields;
   
  my $SQL = <<EOT;
	  SELECT
   ID,
   name,
   gameset,
   title
	  FROM cardlist order by gameset, name
EOT
  
  my $cursor = $main::dbh->prepare($SQL);

  $cursor->execute;

  undef(@fields);

  my @selectedbans = param('banned');
  my %selectedbans;
  foreach my $elem (@selectedbans) {
#    $selectedbans{$elem} = "selected";
  }

  
  while ( @fields = $cursor->fetchrow ) {
     
    my $gameset;
  SWITCH: {
      if ($fields[2] == 1) {
	$gameset = "Tanto Cuore";
	last SWITCH;
      }
      if ($fields[2] == 2) {
	$gameset = "Expanding the House";
	last SWITCH;
      }
      if ($fields[2] == 3) {
	$gameset = "Romantic Vacation";
	last SWITCH;
      }
       if ($fields[2] == 4) {
	$gameset = "Oktoberfest";
	last SWITCH;
      }
       if ($fields[2] == 5) {
	$gameset = "Winter Romance";
	last SWITCH;
      }
      if ($fields[2] == 101) {
	$gameset = "Intl. Tabletop Day 2016 (Promo)";
	last SWITCH;
      }
      my $nothing=0;
    }
    push @list, "<option class=\"banlist$fields[2]\" value=\"$fields[0]\" $selectedbans{$fields[0]}>$gameset - $fields[1] ($fields[3])</option>\n";
  }

  
  $cursor->finish;

  
  my @selectedsets = param('sets');
  my %selectedsets;
  foreach my $elem (@selectedsets) {
#    $selectedsets{$elem} = "SELECTED";
  }


print q \
<h2 style="font-family:Title;font-size:32px;color:#562271;font-weight:normal" align="center">Tanto Cuore <span style="color:#ff6699">&#9829;</span> Town Randomizer</h2>

  
<div style="display: inline-block;">

<div class="boxheader" style="background-color: #cc99ff; color: #000066;">

<b>Include cards from set(s):</b>

</div>

<div class="boxcontent">

<small>Maid chief pairs will be randomly selected from all chosen sets</small>

<table border="0" cellpadding="0" cellspacing="4">
<tr><td><select title="Click to select set(s)" size="6" id="sets" class="sets" name="sets" multiple="multiple">
  <option value="1" \.$selectedsets{1}.q\>Tanto Cuore</option>
  <option value="2" \.$selectedsets{2}.q\>Expanding the House</option>
  <option value="3" \.$selectedsets{3}.q\>Romantic Vacation</option>
  <option value="4" \.$selectedsets{4}.q\>Oktoberfest</option>
  <option value="5" \.$selectedsets{5}.q\>Winter Romance</option>
  <option value="101" \.$selectedsets{101}.q\>Intl. Tabletop Day 2016 (Promo)</option>
  </select></td>

<td align="center" valign="middle">&nbsp;&nbsp;
\;
print to_page("Randomize");

print q \
</td>
</tr>
</table>

</div>
</div>
   
<br /><br />

<div style="display: inline-block; border-radius: 100px;  background-color: #ff99cc; padding-left: 20px; padding-right: 20px; padding-top: 5px; padding-bottom:5px; margin-bottom:15px;">

<div id="optionnote" style="display:none"><b><i>Select one or more sets to view randomizer options</i></b></div>

<div class="hiddenoptions">
<b><i>You may also include the following selection criteria</i></b>
  <br /><small>All option sections may be combined</small>
</div>
</div>

  <br />
    
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
  <tr><td valign="top"><input type="checkbox" name="private" id="private" value="1" />&nbsp;</td><td valign="top" align="left"><label for="private">Exclude all maids that affect or require Private Maids</label><br /><small><i>Select this option if using Tanto Cuore and/or Expanding the House <b>without</b> Private Maids</i></small></td></tr>
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
  <tr><td valign="top"><input type="checkbox" name="events" id="events" value="1" />&nbsp;</td><td valign="top" align="left"><label for="events">Exclude all maids that affect or require Event cards</label><br /><small><i>Select this option if using Tanto Cuore and/or Oktoberfest <b>without</b> Event cards</i></small></td></tr>
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
  <tr><td valign="top"><input type="checkbox" name="buildings" id="buildings" value="1" />&nbsp;</td><td valign="top" align="left"><label for="buildings">Exclude all maids that affect or require Building cards</label><br /><small><i>Select this option if using Expanding the House <b>without</b> Building cards</i></small></td></tr>
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
  <tr><td valign="top"><input type="radio" name="reminiscences" class="reminiscences" id="reminiscences1" value="1" />&nbsp;</td><td valign="top" align="left"><label for="reminiscences1">Exclude all maids that affect or require Reminiscence cards</label><br /><small><i>Select this option if using Romantic Vacation <b>without</b> Reminiscence cards</i></small></td></tr>
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
  <tr><td valign="top"><input type="radio" name="beer" class="beer" id="beer2" value="2" />&nbsp;</td><td valign="top" align="left"><label for="beer2">Exclude all maids that affect or require Beer cards</label><br /><small><i>Select this option if using Oktoberfest <b>without</b> the beer mechanic (Beer cards and the Beer Fest building)</i></small></td></tr>
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
</div>
</div>
  
<br />

<div class="boxheader" style="background-color: #cc6699; color: #ffffff;"><b>Maid cost requirements</b></div>


<div class="boxcontent">
Require at least one general maid of each of the following employ costs:
  <br /><select size="6" name="cost" multiple="multiple">
  <option value="2" class="love">2 Love</option>
  <option value="3" class="love">3 Love</option>
  <option value="4" class="love">4 Love</option>
  <option value="5" class="love">5 Love</option>
  <option value="6" id="love6">6 Love</option>
  <option value="7" class="love">7 Love</option>
  </select>

</div>    

<br />    

<div class="boxheader" style="background-color: #333333; color: #ffffff;"><b>Attack cards</b></div>

<div class="boxcontent">
<table>
  <tr><td valign="middle"><input type="radio" name="attack" id="attack0" value="0" checked="checked" />&nbsp;</td><td valign="bottom" align="left"><label for="attack0">No preference on attack cards</label></td></tr> 
  <tr><td valign="top"><input type="radio" name="attack" id="attack1" value="1" />&nbsp;</td><td valign="bottom" align="left"><label for="attack1"><b>No attack cards.</b> Exclude <u>all</u> cards of any type that can affect other players' VP or deck/hand<br /><small>Please be aware that as <b>Event</b> cards are strictly attack cards this option assumes you are <i>not</i> using them<br />and excludes any maids that affect <b>Events</b> even if the maids themselves are not inherently attack cards.</small></label></td></tr>
  <tr><td valign="top"><input type="radio" name="attack" id="attack2" value="2" /></td><td valign="middle" align="left"><span id="attack2text"><label for="attack2"><b>ONLY attack cards.</b> Include <u>only</u> general maids that can affect other players' VP or deck/hand</label></span><br /><small><i>Note: This option is only available if there are at least 10 qualifying cards across the set(s) chosen</i></small></td></tr>
</table> 
</div>


<br />
  
<div class="boxheader" style="background-color: #990000; color: #ffffff;"><b>Banned cards</b></div>


<div class="boxcontent">
Select maids to <i>not</i> include in results:<br /><select size="5" name="banned" id="banned" class="banned" multiple="multiple">
<option value="0" id="pleaseselect" disabled="disabled" style="display:none">Please select a game set</option>
\;


  foreach my $listitem (@list) {
    my $item = $listitem;
    $item =~ s/banlist.?/banlistnoscript/;
    print $item;
  }


  print "</select></div></div>\n";
   
  print "<p class=\"hiddenoptions\">" . to_page("Randomize") . "</p>\n";
  print "<p class=\"hiddenoptions\"><input type=\"reset\" value=\"Clear All Selections\" /></p>\n";

  print "<select id=\"banlist\" style=\"display: none\">\n";
  foreach my $listitem (@list) {
    print $listitem;
  }
  print "</select>\n";


print q \
<script type="text/javascript">
//<![CDATA[
document.getElementById('pleaseselect').style.display = 'block';
$(".banlistnoscript").remove();
//]]>
</script>




<p>&nbsp;</p>

\.$donate.q \
<p>&nbsp;</p>
<p><small>Find a bug?  Email <a href="mailto:buford@nekomusume.net">buford@nekomusume.net</a></small></p>

<p style="font-size: 0.55em">This game utility is a fan work not affiliated with Arclight, Inc. or Japanime Games.<br /><a href="http://www.tantocuore.com/">Tanto Cuore Official English Website</a> &#8226; <a href="http://www.arclight.co.jp/ag/tc/">Tanto Cuore Official Japanese Website</a><br /><a href="https://www.facebook.com/JapanimeGames/">Japanime Games Facebook Page</a></p>


<!-- <p>
      <a href="http://validator.w3.org/check?uri=referer"><img
          src="./images/xhtml1.0.png"
          alt="Valid XHTML 1.0" height="15" width="80" /></a>
</p> -->

<script type="text/javascript" src="./js/functions.js"></script>
\;

}


sub randomize {
  my $active = shift;
  return unless $active;

  my $newbutton=1;

  if (!param('sets')) {
    print "<p class=\"error\"><b>Error:</b> No game sets selected.  You must choose at least one game set.</b></p>\n";
  } else {


    my @sets = param('sets');
    my %sets;
    my $setlistSQL;
    my @chiefs;
    foreach my $elem (@sets) {
      
      param(-name=>'sets',
	    -value=>"$elem");

      $setlistSQL .= " or gameset = \"$elem\"";
      $sets{$elem} = 1;
      if ($elem ne "101") {
	push @chiefs, $elem;
      }
      my $hidden = hidden(-name=>'sets');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }
    $setlistSQL =~ s/^ or//;


    my @banned = param('banned');

    my %banlist;
    
    my $banlistSQL;
    foreach my $elem (@banned) {
      
      param(-name=>'banned',
	    -value=>"$elem");
      $banlist{$elem} = 1;
      $banlistSQL .= " and ID != \"$elem\"";
      my $hidden = hidden(-name=>'banned');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }
    $banlistSQL =~ s/^ and//;

    my $attackSQL;
    if (param('attack')) {
      param(-name=>'attack',
	    -value=>param('attack'));
    SWITCH: {
	if (param('attack') eq "1") {
	  $attackSQL = " and (attack != \"y\") and (events != \"y\")";
	  last SWITCH;
	}
	if (param('attack') eq "2") {
	  $attackSQL = " and (attack = \"y\")";
	  last SWITCH;
	}
	my $nothing=0;
      }
      my $hidden = hidden(-name=>'attack');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }
    
    
    
    my $eventsSQL;
    if (param('events') or (!exists $sets{1} and exists $sets{101})) {
      param(-name=>'events',
	    -value=>param('events'));
      $eventsSQL = " and (events != \"y\")";
      my $hidden = hidden(-name=>'events');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }



    my $beerSQL;
    if (param('beer') == "2") {
      param(-name=>'beer',
	    -value=>param('beer'));
      $beerSQL = " and (beer != \"y\")";
    }
    if (param('beer')) {
      my $hidden = hidden(-name=>'beer');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }
    

    my $buildingsSQL;
    if (param('buildings')) {
      param(-name=>'buildings',
	    -value=>param('buildings'));
      $buildingsSQL = " and (buildings != \"y\")";
      my $hidden = hidden(-name=>'buildings');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }


    my $privateSQL;
    if (param('private')) {
      param(-name=>'private',
	    -value=>param('private'));
      $privateSQL = " and (private != \"y\")";
      my $hidden = hidden(-name=>'private');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }


    my $reminiscencesSQL;
    if (param('reminiscences')) {
      if (param('reminiscences') eq "1") {
	$reminiscencesSQL = " and (reminiscences != \"y\")";
      }
      param(-name=>'reminiscences',
	    -value=>param('reminiscences'));
      my $hidden = hidden(-name=>'reminiscences');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }


    my %costlist;
    
    
    my @fields;
    my @list;
    my %list;
    my $SQL = <<EOT;
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
   private
	  FROM cardlist WHERE
EOT

    $SQL .= "(".$setlistSQL.")";
    if ($banlistSQL) {
      $SQL .= " and (".$banlistSQL.")";
    }
    if ($attackSQL) {
      $SQL .= $attackSQL;
    }
    if ($eventsSQL) {
      $SQL .= $eventsSQL;
    }
    if ($buildingsSQL) {
      $SQL .= $buildingsSQL;
    }
    if ($privateSQL) {
      $SQL .= $privateSQL;
    }
    if ($reminiscencesSQL) {
      $SQL .= $reminiscencesSQL;
    }
    if ($beerSQL) {
      $SQL .= $beerSQL;
    }
    
    my $cursor = $main::dbh->prepare($SQL);
    
    $cursor->execute;
    
    undef(@fields);
    undef(@list);
    undef(%list);

    while ( @fields = $cursor->fetchrow ) {

      $costlist{$fields[0]} = $fields[5];

      
      my $prgameset;
      my $gameset;
      my $color;
    SWITCH: {
	if ($fields[2] == 1) {
	  $prgameset = "";
	  $gameset = "";
	  $color = "#ffccee";
	}
	if ($fields[2] == 2) {
	  $prgameset = "";
	  $gameset = "-II";
	  $color = "#ffddbb";
	}
	if ($fields[2] == 3) {
	  $prgameset = "";
	  $gameset = "-III";
	  $color = "#cceeff";
	}
	if ($fields[2] == 4) {
	  $prgameset = "";
	  $gameset = "-IV";
	  $color = "#DDAA88";
	}
	if ($fields[2] == 5) {
	  $prgameset = "";
	  $gameset = "-V";
	  $color = "#339999";
	}
	if ($fields[2] == 101) {
	  $prgameset = "PR";
	  $gameset = "";
	  $color = "#FFFFAA";
	}
	my $nothing=0;
      }


      

      my $italics;
      my $italics_e;
      my $bold;
      my $bold_e;
      my $fontcolor;
      my $fontcolor_e;
       
      if ($fields[6] eq "y") {
	$italics = "<i>";
	$italics_e = "</i>";
      }

      if ($fields[7] eq "y") {
	$bold = "<b>";
	$bold_e = "</b>";
      }

      if ($fields[8] eq "y") {
	$fontcolor = "<font color=\"#990000\">";
	$fontcolor_e = "</font>";
      }

      my $cardnumber = sprintf("%02d", $fields[4]);

      $fields[12] =~ s/<br \/>/<br \/>\n/g;
      $list{$fields[0]} = "<tr bgcolor=\"$color\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/$prgameset$cardnumber$gameset.jpg' width='125' height='179'></td><td><b><u>$fields[1]</u></b><br /><i>$fields[3]</i><br /><hr />$fields[12]</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>$prgameset$cardnumber$gameset</td><td>$fontcolor$bold$italics$fields[1] ($fields[3])$italics_e$bold_e$fontcolor_e</td><td align=\"center\">$fields[5]</td></tr>\n";      
    }
  
    $cursor->finish;



    my $barmaiderror;
    if ((param('beer') == 1) and (!$list{55} and !$list{56})) {
      $barmaiderror = 1;
    }



    
    my $crescenterror;
    if (param('crescent')) {
      param(-name=>'crescent',
	    -value=>param('crescent'));
    SWITCH: {
	if (param('crescent') eq "1") {
	CRESCENT: {
	    if ($list{14} and !($list{15} or $list{16})) {
	      $crescenterror = 1;
	      last CRESCENT;
	    }
	    if ($list{15} and !($list{14} or $list{16})) {
	      $crescenterror = 1;
	      last CRESCENT;
	    }
	    if ($list{16} and !($list{14} or $list{15})) {
	      $crescenterror = 1;
	      last CRESCENT;
	    }
	    my $nothing = 0;
	  }
	  last SWITCH;
	}
	if ((param('crescent') eq "2") and ($list{14} or $list{15} or $list{16}) and !($list{14} and $list{15} and $list{16})) {
	  $crescenterror = 1;
	  last SWITCH;
	}
	my $nothing = 0;
      }
	
      my $hidden = hidden(-name=>'crescent');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }



    my @costlist = param('cost');
    my %costignore;
    foreach my $elem (@costlist) {
    SWITCH: {
	if ($elem eq "2") {
	  $costignore{2} = 1;
	  last SWITCH;
	}
	if ($elem eq "3") {
	  $costignore{3} = 1;
	  last SWITCH;
	}
	if ($elem eq "5") {
	  $costignore{5} = 1;
	  last SWITCH;
	}
	my $nothing = 0;
      }
	
      param(-name=>'cost',
	    -value=>"$elem");
      my $hidden = hidden(-name=>'cost');
      $hidden =~ s/>$/ \/>/;
      print $hidden;
    }

    push @costlist, "5" if ((param('reminiscences') eq "2") and !exists $costignore{5});
    
    my $chiefsindex = rand @chiefs;
    my $chiefs = $chiefs[$chiefsindex];
    my $chiefsoutput;
  SWITCH: {
      if ($chiefs == 1) {
	$chiefsoutput = "<tr bgcolor=\"#ffccee\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01.jpg' width='125' height='179'></td><td><b><u>Marianne Soleil</u></b><br /><i>Maid Chief</i><br /><hr />VP: 6</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>01</td><td><b>Marianne Soleil (Maid Chief)</b></td><td align=\"center\">9</td></tr>\n";
	$chiefsoutput .= "<tr bgcolor=\"#ffccee\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02.jpg' width='125' height='179'></td><td><b><u>Colette Framboise</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br />Chambermaid &#8658; [Serving -2]<br /><b>------ At the end of the game ------</b><br />If you have more Colettes employed than any other player, you gain a bonus 5 VP.  (You gain 5 VP total, not per Colette)</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>02</td><td><b><i>Colette Framboise (Chambermaid Chief)</i></b></td><td align=\"center\">3</td></tr>\n";
	push @costlist, "2" if ((param('reminiscences') eq "2") and !exists $costignore{2} and (param('attack') ne "1"));
	last SWITCH;
      }
      if ($chiefs == 2) {
	$chiefsoutput = "<tr bgcolor=\"#ffddbb\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-II.jpg' width='125' height='179'></td><td><b><u>Claudine de la Rochelle</u></b><br /><i>Maid Chief</i><br /><hr />VP: 5</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>01-II</td><td><b>Claudine de la Rochelle (Maid Chief)</b></td><td align=\"center\">8</td></tr>\n";
	$chiefsoutput .= "<tr bgcolor=\"#ffddbb\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-II.jpg' width='125' height='179'></td><td><b><u>Aline du Roi</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br />Chambermaid &#8658; [Serving -2]</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>02-II</td><td><b><i>Aline du Roi (Chambermaid Chief)</i></b></td><td align=\"center\">2</td></tr>\n";
	push @costlist, "3" if ((param('reminiscences') eq "2") and !exists $costignore{3});
	last SWITCH;
      }
      if ($chiefs == 3) {
	$chiefsoutput = "<tr bgcolor=\"#cceeff\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-III.jpg' width='125' height='179'></td><td><b><u>Sophia Marfil</u></b><br /><i>Maid Chief</i><br /><hr />VP: 5</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>01-III</td><td><b>Sophia Marfil (Maid Chief)</b></td><td align=\"center\">8</td></tr>\n";
	$chiefsoutput .= "<tr bgcolor=\"#cceeff\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-III.jpg' width='125' height='179'></td><td><b><u>Beatrice Escudo</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: ?<br />Chambermaid &#8658; [Serving -2]<br /><b>------ Chambermaid bonus ------</b><br />Each Beatrice: 2 VP</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>02-III</td><td><b><i>Beatrice Escudo (Chambermaid Chief)</i></b></td><td align=\"center\">2</td></tr>\n";
	push @costlist, "3" if ((param('reminiscences') eq "2") and !exists $costignore{3});
	last SWITCH;
      }
      if ($chiefs == 4) {
	$chiefsoutput = "<tr bgcolor=\"#DDAA88\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-IV.jpg' width='125' height='179'></td><td><b><u>Anja Brunner</u></b><br /><i>Maid Chief</i><br /><hr />VP: 6<br /><hr /><b>------ At the end of the game ------</b><br />If you have more than 3 Nicole in your deck, Anja gains an extra 1 VP.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>01-IV</td><td><b>Anja Brunner (Maid Chief)</b></td><td align=\"center\">10</td></tr>\n";
	$chiefsoutput .= "<tr bgcolor=\"#DDAA88\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-IV.jpg' width='125' height='179'></td><td><b><u>Matilde Wiese</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br />Chambermaid &#8658; [Serving -2]<br /><b>------ During your Starting Phase ------</b><br />You may put a chambermaided Matilde into your Discard pile.  If you do, choose a card from your hand and put it back to the Town.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>02-IV</td><td><b><i>Matilde Wiese (Chambermaid Chief)</i></b></td><td align=\"center\">2</td></tr>\n";
	push @costlist, "2" if ((param('reminiscences') eq "2") and !exists $costignore{2} and (param('attack') ne "1"));
	last SWITCH;
      }
      if ($chiefs == 5) {
	$chiefsoutput = "<tr bgcolor=\"#339999\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/01-V.jpg' width='125' height='179'></td><td><b><u>Leopold Niebling</u></b><br /><i>Butler Chief</i><br /><hr />VP: 6<hr /><b>------ At the end of the game ------</b><br />-1 VP for each Couple you have in your Private Quarters.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>01-V</td><td><b>Leopold Niebling (Butler Chief)</b></td><td align=\"center\">10</td></tr>\n";
	$chiefsoutput .= "<tr bgcolor=\"#339999\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/02-V.jpg' width='125' height='179'></td><td><b><u>Beverly Snowfeldt</u></b><br /><i>Chambermaid Chief</i><br /><hr />VP: 1<br /><br />This card can not be used in an Approach.<br /><br />Chambermaid &#8658; [Serving -2]<br /><b>------ Chambermaid bonus ------</b><br />Gain 2 VP if you have one or more Leopold cards.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>02-V</td><td><b><i>Beverly Snowfeldt (Chambermaid Chief)</i></b></td><td align=\"center\">2</td></tr>\n";
	push @costlist, "2" if ((param('reminiscences') eq "2") and !exists $costignore{2});
	last SWITCH;
      }
      my $nothing = 0;
    }


    my $apprenticeerror;
    if ((param('apprentice') == 1) and (!$list{66}) and $chiefs == "4") {
      $apprenticeerror = 1;
    }
    my $hidden = hidden(-name=>'apprentice');
    $hidden =~ s/>$/ \/>/;
    print $hidden;




    my $costerror;
    if (param('cost') or (param('reminiscences') eq "2")) {
      my %counter;
      foreach my $elem (values %costlist) {
	foreach my $elem2 (@costlist) {
	  if ($elem eq $elem2) { if (!exists $counter{$elem2}) { $counter{$elem2}=1; } else { $counter{$elem2}++; } }
	}
      }


      foreach my $elem (@costlist) {
	if (!exists $counter{$elem}) { $costerror = 1; }
      }

    }


    
  SWITCH: {
      if (keys %list < 10) {
	print "<p class=\"error\"><b>Error:</b> Less than 10 maids available to randomize.</p>\n";
	last SWITCH;
      }
      if ($costerror) {
	print "<p class=\"error\"><b>Error:</b> No maids of one or more required cost(s) in pool of available maids.</p>\n";
	last SWITCH;
      }
      if ($crescenterror) {
	print "<p class=\"error\"><b>Error:</b> Not enough Crescent sisters in pool of available maids to meet selected minimum.</p>\n";
	last SWITCH;
      }
      if ($barmaiderror) {
	print "<p class=\"error\"><b>Error:</b> No Bar Maids in pool of available maids. (Beer cards are unusable)</p>\n";
	last SWITCH;
      }
      if ($apprenticeerror) {
	print "<p class=\"error\"><b>Error:</b> Nicole Schmieg is not available in the pool of available maids but is required by the option selections.</p>\n";
	last SWITCH;
      }
      
      print "<table cellpadding=\"10\" bgcolor=\"#ffffff\">\n";
      print "<tr><td valign=\"top\"><table cellpadding=\"3\">\n";
      print "<tr bgcolor=\"#036a76\"><th><font color=\"#ffffff\">Card&nbsp;#</font></th><th><font color=\"#ffffff\">Maid Chiefs</font></th><th><font color=\"#ffffff\">Cost</font></th></tr>\n";


     
      print $chiefsoutput;

      print "<tr bgcolor=\"#096fb8\"><th><font color=\"#ffffff\">Card&nbsp;#</font></th><th><font color=\"#ffffff\">General Maids</font></th><th><font color=\"#ffffff\">Cost</font></th></tr>\n";
      

      my @IDnumbers = keys %list;
      my $counter = 1;
      my @listkey;
      
      my %cache;


      while ($counter <= 10) {

	my $num;

	$num = 66 if ($chiefs == "4" and param('apprentice') eq "1" and !(exists $cache{66}) and !(exists $banlist{66}) and $counter != 11);


	if ($num != 66) {
	  if (@costlist) {
	    my @costcache;
	    my $costtosearch = shift @costlist;
	    foreach my $elem (keys %costlist) {
	      if ($costlist{$elem} eq $costtosearch) {
		push @costcache, $elem;
	      }
	    }
	    $num = $costcache[rand @costcache];
	    
	    
	  } else {
	    $num = $IDnumbers[rand @IDnumbers];
	    
	  }
	}
	

	redo if ((param('crescent') eq "1") and ($counter == 10) and (!(exists $cache{14}) or !(exists $cache{15}) or !(exists $cache{16})) and ($num == 14 or $num == 15 or $num == 16));

	redo if ((param('crescent') eq "2") and ($counter > 8) and (!(exists $cache{14}) or !(exists $cache{15}) or !(exists $cache{16})) and (($num == 14) or ($num == 15) or ($num == 16)));


	redo if exists $cache{$num}; # redo the loop if the number already exists
	$cache{$num} = 1; 

	$listkey[$counter] = $num;
	$counter++;


	if ((param('beer') eq "1") and ($counter != 11) and (!(exists $cache{55}) and !(exists $cache{56}))) {
	  my @barmaidIDs = (55,56);
	  my $newnum = $barmaidIDs[rand @barmaidIDs];
	  if (!(exists $cache{$newnum}) and !(exists $banlist{$newnum})) {
	    $cache{$newnum} = 1;
	    $listkey[$counter] = $newnum;
	    $counter++;
	  }
	}

	
      CRESCENT: {
	  if ((param('crescent') eq "1") and ($num == 14) and ($counter != 11)) {
	    my @crescentIDs = (15,16);
	    my $newnum = $crescentIDs[rand @crescentIDs];
	    if (!(exists $cache{$newnum})) {
	      redo CRESCENT if exists $banlist{$newnum};
	      $cache{$newnum} = 1;
	      $listkey[$counter] = $newnum;
	      $counter++;
	    }
	    last CRESCENT;
	  }
	  if ((param('crescent') eq "1") and ($num == 15) and ($counter != 11)) {
	    my @crescentIDs = (14,16);
	    my $newnum = $crescentIDs[rand @crescentIDs];
	    if (!(exists $cache{$newnum})) {
	      redo CRESCENT if exists $banlist{$newnum};
	      $cache{$newnum} = 1;
	      $listkey[$counter] = $newnum;
	      $counter++;
	    }
	    last CRESCENT;
	  }
	  if ((param('crescent') eq "1") and ($num == 16) and ($counter != 11)) {
	    my @crescentIDs = (14,15);
	    my $newnum = $crescentIDs[rand @crescentIDs];
	    if (!(exists $cache{$newnum})) {
	      redo CRESCENT if exists $banlist{$newnum};
	      $cache{$newnum} = 1;
	      $listkey[$counter] = $newnum;
	      $counter++;
	    }
	    last CRESCENT;
	  }
	  if ((param('crescent') eq "2") and ($num == 14) and ($counter < 10)) {
	    if (!(exists $cache{$15})) {
	      $cache{15} = 1;
	      $listkey[$counter] = 15;
	      $counter++;
	    }
	    if (!(exists $cache{$16})) {
	      $cache{16} = 1;
	      $listkey[$counter] = 16;
	      $counter++;
	    }
	    last CRESCENT;
	  }
	  if ((param('crescent') eq "2") and ($num == 15) and ($counter < 10)) {
	    if (!(exists $cache{$14})) {
	      $cache{14} = 1;
	      $listkey[$counter] = 14;
	      $counter++;
	    }
	    if (!(exists $cache{$16})) {
	      $cache{16} = 1;
	      $listkey[$counter] = 16;
	      $counter++;
	    }
	    last CRESCENT;
	  }
	  if ((param('crescent') eq "2") and ($num == 16) and ($counter < 10)) {
	    if (!(exists $cache{$14})) {
	      $cache{14} = 1;
	      $listkey[$counter] = 14;
	      $counter++;
	    }
	    if (!(exists $cache{$15})) {
	      $cache{15} = 1;
	      $listkey[$counter] = 15;
	      $counter++;
	    }
	    last CRESCENT;
	  }
	  my $nothing = 0;
	}
      }

      my @listkeysorted = sort { $a <=> $b } @listkey;
      
      foreach my $listitem (@listkeysorted) {
	print $list{$listitem};
      }
      

      my @removebuffer;
      my @removerembuffer;
      my @removeeventsbuffer;
      if (exists $sets{1}) {
	if (param('events') or (param('attack') eq "1")) {
	  push(@removebuffer, ("<tr bgcolor=\"#ffccee\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20.jpg' width='125' height='179'></td><td><b><u>Nord Twilight</u></b><br /><i>Black Maid</i><br /><hr />VP: -4<br /><b>------ During your Starting Phase ------</b><br />You may discard all but one card from your hand.  If you do, send two illnesses from the town onto one maid in any Private Quarters of your choice.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>20</td><td><b><i><font color=\"#990000\">Nord Twilight (Black Maid)</font></i></b></td><td align=\"center\">4</td></tr>\n"));
	  push(@removebuffer, ("<tr bgcolor=\"#ffccee\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/21.jpg' width='125' height='179'></td><td><b><u>Sora Nakachi</u></b><br /><i>Private Maid</i><br /><hr />VP: 2<br /><b>------ During your Starting Phase ------</b><br />You may move one Event card from a Private Quarter of your choice to an equivalent place in another player's Private Quarters.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>21</td><td><b><i><font color=\"#990000\">Sora Nakachi (Private Maid)</font></i></b></td><td align=\"center\">7</td></tr>\n"));
	}
	if (param('attack') eq "1") {
	  push(@removebuffer, ("<tr bgcolor=\"#ffccee\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/19.jpg' width='125' height='179'></td><td><b><u>Amber Twilight</u></b><br /><i>Black Maid</i><br /><hr />VP: -3<br /><b>------ At the start of each other player's Discard Phase ------</b><br />The active player must discard the top card of their deck.  If the discarded card was not a Maid card, the number of cards they draw for their hand is decreased by 1.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>19</td><td><b><i><font color=\"#990000\">Amber Twilight (Black Maid)</font></i></b></td><td align=\"center\">5</td></tr>\n"));
	  push(@removebuffer, ("<tr bgcolor=\"#ffccee\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/25.jpg' width='125' height='179'></td><td><b><u>Eugenie Fontaine</u></b><br /><i>Private Maid</i><br /><hr /><b>------ During your Starting Phase ------</b><br />You may look at 1 random card in another player's hand.  After, you may allow that player to look at 1 random card from your hand.  If you do, exchange those two cards.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>25</td><td><i><font color=\"#990000\">Eugenie Fontaine (Private Maid)</font></i></td><td align=\"center\">5</td></tr>\n"));
	}
      }
      if (exists $sets{2}) {
	if (param('buildings') eq "1") {
	  push(@removebuffer, ("<tr bgcolor=\"#ffddbb\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/27-II.jpg' width='125' height='179'></td><td><b><u>Silk Amanohara</u></b><br /><i>Exorcist Maid</i><br /><hr /><b>------ During your Starting Phase ------</b><br />If you have 3 or more buildings in your Private Quarters, you may draw a card.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>27-II</td><td><i>Silk Amanohara (Exorcist Maid)</i></td><td align=\"center\">4</td></tr>\n"));
	}
	if (param('attack') eq "1") {
	  push(@removebuffer, ("<tr bgcolor=\"#ffddbb\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20-II.jpg' width='125' height='179'></td><td><b><u>Mika Yakushido</u></b><br /><i>Black Maid</i><br /><hr />VP: -2<br />This maid may be placed in any player's Private Quarters.<br /><b>------ During your Starting Phase ------</b></b><br />You must discard a '1 Love' from your hand.  If you can't, reveal your hand, and put Mika back face down at the bottom of the Private Maid pile.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>20-II</td><td><b><i><font color=\"#990000\">Mika Yakushido (Black Maid)</font></i></b></td><td align=\"center\">6</td></tr>\n"));
	}
      }



      if ((exists $sets{3} and param('reminiscences') eq "1") or (!exists $sets{3})) {
	push(@removebuffer, ("<tr bgcolor=\"#ffffaa\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR14.jpg' width='125' height='179'></td><td><b><u>Liliana Giornata</u></b><br /><i>Private Maid</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr />VP: 2<br /><b>------ During your Starting Phase ------</b><br />If you have the Reminiscence card \'Astronomic Observation\' in your Private Quarters, you gain [Love +1] and [Employment +1]</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>PR14</td><td><b><i>Liliana Giornata (Private Maid)</i></b></td><td align=\"center\">5</td></tr>\n"));
      }
      if (exists $sets{3} and ((param('attack') eq "1") and (param('reminiscences') ne "1"))) {
	push(@removerembuffer, ("<tr bgcolor=\"#cceeff\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/30-III.jpg' width='125' height='179'></td><td><b><u>Scary Night</u></b><br /><i>Reminiscence</i><br /><b><i>Note: There are 3 of these cards in the set</i></b><br /><hr />VP: 3<br /><b>1 card with an employ cost 3<br />1 card with an employ cost 2</b><br />Every other player discards down to 3 cards in their hand.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>30-III</td><td colspan=\"2\"><font color=\"#990000\"><b>Scary Night</b></font> (3 cards)</td></tr>\n"));
      }
    

      
      if ((exists $sets{4} and param('beer') eq "2") or !exists $sets{4}) {
	push(@removebuffer, ("<tr bgcolor=\"#ffffaa\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR19.jpg' width='125' height='179'></td><td><b><u>Astrid Wende</u></b><br /><i>Private Maid</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr />VP: 1<br /><b>------ During your Starting Phase ------</b><br />You may discard the top card of your deck.  If your discarded card was a Love card, you may discard 2 cards with a cost 4 or more.  If you do, gain a beer card.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>PR19</td><td><b><i>Astrid Wende (Private Maid)</i></b></td><td align=\"center\">6</td></tr>\n"));
	push(@removebuffer, ("<tr bgcolor=\"#ffffaa\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/PR34.jpg' width='125' height='179'></td><td><b><u>Ursula Fassbender</u></b><br /><i>Private Maid</i><br /><b><i>PROMO CARD - Not included in base set</i></b><hr />VP: 1<br /><b>------ At the end of the game ------</b><br />If you have 4 or more Beer cards in your Private Quarters, gain +3 VP.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>PR34</td><td><b><i>Ursula Fassbender (Private Maid)</i></b></td><td align=\"center\">4</td></tr>\n"));
      }
      if (exists $sets{4}) {
	if (
	    (param('beer') == "2" and !(exists $sets{2})) or
	     (exists $sets{2} and param('buildings') and param('beer') == "2")
	    and (!(param('events') or param('attack') == 1))) {
	  push(@removeeventsbuffer, ("<tr bgcolor=\"#DDAA88\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/20-IV.jpg' width='125' height='179'></td><td><b><u>Heavy Storm</u></b><br /><i>Event</i><br /><b><i>Note: There are 8 of these in the set</i></b><br /><hr />This is placed onto a Building in any player's Private Quarters.  All cards placed underneath this card are treated as though they don't exist.<br /><b>------ At the beginning of your turn ------</b><br />You may Discard a '3 Love' Card from your hand.  If you do, put this card back to the Town.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>20-IV</td><td><font color=\"#990000\">Heavy Storm</font></td><td align=\"center\">5</td></tr>\n"));
	}
	if ((param('beer') == "2") and (!(param('events') or param('attack') == 1))) {
	  push(@removeeventsbuffer, ("<tr bgcolor=\"#DDAA88\" title=\"<table border='0' cellpadding='8' cellspacing='0'><tr valign='top'><td><img src='./cards/21-IV.jpg' width='125' height='179'></td><td><b><u>Let me drink!</u></b><br /><i>Event</i><br /><b><i>Note: There are 8 of these in the set</i></b><br /><hr />When you gain this card, put this card onto your Private Quarters.<br /><b>------ At the beginning of your turn ------</b><br />Discard a Love card from your hand and remove this card from the game.  If you do, take a Beer card from any player's Private Quarters and add it to your Private Quarters.</td></tr></table>\" rel=\"tooltip\" class=\"tooltip\"><td>21-IV</td><td><font color=\"#990000\">Let me drink!</font></td><td align=\"center\">5</td></tr>\n"));
	}
      }



      if ((@removebuffer and !param('private')) or @removerembuffer or @removeeventsbuffer) {
	print "<tr bgcolor=\"#000000\"><th colspan=\"3\"><font color=\"#ffffff\">Remove the following from game:</font></th></tr>";
	if (@removebuffer and !param('private')) {
	  print "<tr bgcolor=\"#1f1a23\"><th><font color=\"#ffffff\">Card&nbsp;#</font></th><th><font color=\"#ffffff\">Private Maids</font></th><th><font color=\"#ffffff\">Cost</font></th></tr>\n";
	  foreach my $elem (@removebuffer) {
	    print $elem;
	  }
	}

	if (@removerembuffer) {
	  print "<tr bgcolor=\"#fbb450\"><th><font color=\"#ffffff\">Card&nbsp;#</font></th><th colspan=\"2\"><font color=\"#ffffff\">Reminiscences</font></th></tr>\n";
	  foreach my $elem (@removerembuffer) {
	    print $elem;
	  }
	}


	
	if (@removeeventsbuffer) {
	  print "<tr bgcolor=\"#8652A1\"><th><font color=\"#ffffff\">Card&nbsp;#</font></th><th><font color=\"#ffffff\">Events</font></th><th><font color=\"#ffffff\">Cost</font></th></tr>\n";
	  foreach my $elem (@removeeventsbuffer) {
	    print $elem;
	  }
	}

	

      }
      print "</table></td>\n";
        


      print "<td align=\"center\" valign=\"top\" width=\"310\">\n";

      print "<small><b>Touch or hover over each individual maid's name for information on her card's effects.</b><br /><br /></small>\n";

      print "<table>\n";


      print "<tr><th colspan=\"2\">Color Legend:</th></tr>\n";
      print "<tr><td width=\"25\" bgcolor=\"#ffccee\">&nbsp;</td><td>Tanto Cuore</td></tr>\n";
      print "<tr><td width=\"25\" bgcolor=\"#ffddbb\">&nbsp;</td><td>Expanding the House</td></tr>\n";
      print "<tr><td width=\"25\" bgcolor=\"#cceeff\">&nbsp;</td><td>Romantic Vacation</td></tr>\n";
      print "<tr><td width=\"25\" bgcolor=\"#DDAA88\">&nbsp;</td><td>Oktoberfest</td></tr>\n";
      print "<tr><td width=\"25\" bgcolor=\"#339999\">&nbsp;</td><td>Winter Romance</td></tr>\n";
      print "<tr><td width=\"25\" bgcolor=\"#FFFFAA\">&nbsp;</td><td>Promo Card</td></tr>\n";
      print "</table>\n";
      print "<br /><table><tr><th colspan=\"2\">Text Legend:</th></tr><tr><td>Red:</td><td><font color=\"#990000\">Card can negatively affect other players</font></td></tr><tr><td>Bold:</td><td><b>Card has a VP indicator</b></td></tr><tr><td>Italics:</td><td><i>Chambermaid</i></td></tr></table>\n";


      print "<br /><p>" . to_page("Randomize Again With Same Options") . "</p>\n";

      print "<p>" . to_page("New Randomization Criteria") . "</p>\n";
      $newbutton = 0;
      print "</td></tr></table>\n";
    


    }
      
      
  }
  if ($newbutton) { print "<p>" . to_page("New Randomization Criteria") . "</p>\n"; }
      
  
  print $donate;
  
}


sub to_page { submit(-NAME => ".State", -CLASS => "topage", -VALUE => shift) }


# fisher_yates_shuffle( \@array ) : generates a random permutation of
# @array in place, Perl Cookbook page 121
sub fisher_yates_shuffle {
  my $array = shift;
  my $i;
  for ($i = @$array; --$i; ) {
    my $j = int rand ($i+1);
    next if $i == $j;
    @$array[$i,$j] = @$array[$j,$i];
  }
}
