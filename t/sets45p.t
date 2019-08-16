## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(4 5 101);

my @testcases = (
    [
        [qw(beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(events=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(buildings=1 beer=1)],
        [qw(20-IV 20-V PR14)],
    ],
    [
        [qw(events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 events=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 buildings=1 beer=1)],
        [qw(20-IV 20-V PR14)],
    ],
    [
        [qw(couples=1 events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(attack=1 events=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(attack=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 events=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=2 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(beer=2)],
        [qw(21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
