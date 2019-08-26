## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(1 5 101);

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
        [qw(PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(private=1 buildings=1)],
        [qw(20-V)],
    ],
    [
        [qw(events=1 buildings=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(couples=1)],
        [qw(PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(private=1 couples=1)],
        [qw(20-V)],
    ],
    [
        [qw(events=1 couples=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 couples=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 couples=1)],
        [qw(PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(private=1 buildings=1 couples=1)],
        [qw(20-V)],
    ],
    [
        [qw(events=1 buildings=1 couples=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 couples=1)],
        [qw()],
    ],
    [
        [qw(attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(private=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(private=1 events=1 attack=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 buildings=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 attack=1)],
        [qw()],
    ],
    [
        [qw(couples=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 couples=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 couples=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 couples=1 attack=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 couples=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 couples=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 buildings=1 couples=1 attack=1)],
        [qw(20 21 19 25 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 couples=1 attack=1)],
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
    [
        [qw(buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(buildings=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 buildings=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 buildings=1 couples=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 buildings=1 couples=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );

