Tanto Cuore Town Randomizer
===========================

This is a Perl CGI application for randomizing the initial setup for
the card game Tanto Cuore.

The script uses a single table in a MySQL database to store all of the
card information.  If you want to use the code as-is you will need to
set your hosts file to point mysql.nekomusume.net to your own MySQL
server.  The database structure and contents is in sql/cardlist.sql.

Several library directories are set at the beginning of the index.pl
script that are only necessary for my hosting setup.

MySQL configuration options are contained in the file config.pl
A sample file is included.
