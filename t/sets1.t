## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(1);

my @testcases = (
    [
        [qw()],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(private=1)],
        [qw()],
    ],
    [
        [qw(events=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1)],
        [qw(19 20 21 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 attack=1)],
        [qw(19 20 21 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 attack=1)],
        [qw()],
    ],
    [
        [qw(attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
