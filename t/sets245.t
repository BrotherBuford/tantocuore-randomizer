## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(2 4 5);

my @testcases = (
    [
        [qw(beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(private=1 beer=1)],
        [qw()],
    ],
    [
        [qw(events=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 beer=1)],
        [qw(20-IV 20-V 27-II PR14)],
    ],
    [
        [qw(buildings=1 private=1 beer=1)],
        [qw(20-IV 20-V)],
    ],
    [
        [qw(buildings=1 events=1 beer=1)],
        [qw(27-II PR14)],
    ],
    [
        [qw(buildings=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 private=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 events=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 buildings=1 beer=1)],
        [qw(20-IV 20-V 27-II PR14)],
    ],
    [
        [qw(couples=1 buildings=1 private=1 beer=1)],
        [qw(20-IV 20-V)],
    ],
    [
        [qw(couples=1 buildings=1 events=1 beer=1)],
        [qw(27-II PR14)],
    ],
    [
        [qw(couples=1 buildings=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 beer=1)],
        [qw(20-II PR14 PR43)],
    ],
    [
        [qw(attack=1 private=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 events=1 beer=1)],
        [qw(20-II PR14 PR43)],
    ],
    [
        [qw(attack=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 buildings=1 beer=1)],
        [qw(20-II 27-II PR14)],
    ],
    [
        [qw(attack=1 buildings=1 private=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 buildings=1 events=1 beer=1)],
        [qw(20-II 27-II PR14)],
    ],
    [
        [qw(attack=1 buildings=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 beer=1)],
        [qw(20-II PR14)],
    ],
    [
        [qw(attack=1 couples=1 private=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 events=1 beer=1)],
        [qw(20-II PR14)],
    ],
    [
        [qw(attack=1 couples=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 beer=1)],
        [qw(20-II 27-II PR14)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 private=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 events=1 beer=1)],
        [qw(20-II 27-II PR14)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 private=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(attack=2 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 private=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 private=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 private=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 private=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 private=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 private=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 private=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 private=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(beer=2)],
        [qw(21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 beer=2)],
        [qw(21-IV)],
    ],
    [
        [qw(events=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(buildings=1 private=1 beer=2)],
        [qw(20-IV 20-V 21-IV)],
    ],
    [
        [qw(buildings=1 events=1 beer=2)],
        [qw(27-II PR14 PR19 PR34)],
    ],
    [
        [qw(buildings=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(couples=1 beer=2)],
        [qw(21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 private=1 beer=2)],
        [qw(21-IV)],
    ],
    [
        [qw(couples=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(couples=1 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1 private=1 beer=2)],
        [qw(20-IV 20-V 21-IV)],
    ],
    [
        [qw(couples=1 buildings=1 events=1 beer=2)],
        [qw(27-II PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 beer=2)],
        [qw(20-II PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 private=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 events=1 beer=2)],
        [qw(20-II PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 buildings=1 beer=2)],
        [qw(20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 buildings=1 private=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 buildings=1 events=1 beer=2)],
        [qw(20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 buildings=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 beer=2)],
        [qw(20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 events=1 beer=2)],
        [qw(20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 beer=2)],
        [qw(20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 private=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 events=1 beer=2)],
        [qw(20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=2 beer=2)],
        [qw(21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 private=1 beer=2)],
        [qw(21-IV)],
    ],
    [
        [qw(attack=2 events=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=2 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=2 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 buildings=1 private=1 beer=2)],
        [qw(20-IV 20-V 21-IV)],
    ],
    [
        [qw(attack=2 buildings=1 events=1 beer=2)],
        [qw(27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 buildings=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 beer=2)],
        [qw(21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 private=1 beer=2)],
        [qw(21-IV)],
    ],
    [
        [qw(attack=2 couples=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 private=1 events=1 beer=2)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 private=1 beer=2)],
        [qw(20-IV 20-V 21-IV)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 events=1 beer=2)],
        [qw(27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 private=1 events=1 beer=2)],
        [qw()],
    ],
);

run_tests( \@sets, \@testcases );
