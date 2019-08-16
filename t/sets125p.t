## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(1 2 5 101);

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
        [qw(20 21 PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(private=1 events=1)],
        [qw()],
    ],
    [
        [qw(buildings=1)],
        [qw(27-II PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(private=1 buildings=1)],
        [qw(20-V)],
    ],
    [
        [qw(events=1 buildings=1)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(couples=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 private=1)],
        [qw()],
    ],
    [
        [qw(couples=1 events=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1 buildings=1)],
        [qw(27-II PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 private=1 buildings=1)],
        [qw(20-V)],
    ],
    [
        [qw(couples=1 events=1 buildings=1)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(attack=1)],
        [qw(20 21 19 25 20-II PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=1 events=1)],
        [qw(20 21 19 25 20-II PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1 buildings=1)],
        [qw(20 21 19 25 27-II 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 private=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(attack=1 events=1 buildings=1)],
        [qw(20 21 19 25 27-II 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1)],
        [qw(20 21 19 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 events=1)],
        [qw(20 21 19 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 buildings=1)],
        [qw(20 21 19 25 27-II 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 events=1 buildings=1)],
        [qw(20 21 19 25 27-II 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(attack=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 private=1)],
        [qw()],
    ],
    [
        [qw(attack=2 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 private=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 private=1 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 private=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 private=1 events=1 buildings=1)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
