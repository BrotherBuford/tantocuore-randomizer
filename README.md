<h2 align="center">Tanto Cuore &#9829; Town Randomizer</h2>

<p align="center"><img alt="GitHub" src="https://img.shields.io/github/license/BrotherBuford/tantocuore-randomizer">&nbsp;<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/brotherbuford/tantocuore-randomizer">&nbsp;<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/brotherbuford/tantocuore-randomizer">&nbsp;<img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/BrotherBuford/tantocuore-randomizer">
<br /><img alt="Maintenance" src="https://img.shields.io/maintenance/yes/2020">&nbsp;<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/BrotherBuford/tantocuore-randomizer">
<br /><img alt="Travis (.org) branch" src="https://img.shields.io/travis/brotherbuford/tantocuore-randomizer/master?label=tests"></p>

<p>A Perl CGI application for randomizing the initial setup for
the card game Tanto Cuore and its expansions.</p>

<p>This is a repository for the codebase used for the site at <a href="https://nekomusume.net/tc">nekomusume.net/tc</a></p>

<p>SQLite is used to store card information.</p>

<p>Automated testing is done on each branch with Travis-CI using Perl versions 5.30, 5.28, 5.26, 5.24, and 5.22.  Many but not <i>all</i> conditions are tested; conditions involving specific card removals, Bar Maid inclusion (if required), and attack/non-attack card conditions are part of the tests.</p>

<p><i>This uses CGI.pm and not a newer framework due to being a very old project that receives occasional updates and improvements.  The history of this repository only goes back to when version control was changed to git; much of the earlier revision history was in a long-lost CVS repository.</i></p>
