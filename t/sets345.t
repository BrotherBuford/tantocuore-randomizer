## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(3 4 5);

my @testcases = (
    [
        [qw(beer=1)],
        [qw()],
    ],
    [
        [qw(events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 beer=1)],
        [qw(20-IV 20-V)],
    ],
    [
        [qw(events=1 buildings=1 beer=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2 beer=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2 buildings=1 beer=1)],
        [qw(20-IV 20-V)],
    ],
    [
        [qw(reminiscences=2 events=1 buildings=1 beer=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(reminiscences=1 events=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(reminiscences=1 buildings=1 beer=1)],
        [qw(20-IV 20-V PR14)],
    ],
    [
        [qw(reminiscences=1 events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 buildings=1 beer=1)],
        [qw(20-IV 20-V)],
    ],
    [
        [qw(couples=1 events=1 buildings=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=2 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1 beer=1)],
        [qw(20-IV 20-V)],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1 buildings=1 beer=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1 beer=1)],
        [qw(20-IV 20-V PR14)],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 beer=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 events=1 beer=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 events=1 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 reminiscences=2 beer=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1 beer=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 reminiscences=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1 beer=1)],
        [qw(PR14 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 events=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 events=1 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1 buildings=1 beer=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1 beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1 buildings=1 beer=1)],
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
        [qw(attack=2 reminiscences=2 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1 buildings=1 beer=1)],
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
        [qw(attack=2 couples=1 reminiscences=2 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 events=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1 buildings=1 beer=1)],
        [qw(Error)],
    ],
    [
        [qw(beer=2)],
        [qw(21-IV PR19 PR34)],
    ],
    [
        [qw(events=1 beer=2)],
        [qw(PR19 PR34 PR43)],
    ],
    [
        [qw(buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR19 PR34)],
    ],
    [
        [qw(events=1 buildings=1 beer=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 beer=2)],
        [qw(21-IV PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 events=1 beer=2)],
        [qw(PR19 PR34 PR43)],
    ],
    [
        [qw(reminiscences=2 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 events=1 buildings=1 beer=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 beer=2)],
        [qw(21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(reminiscences=1 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR19 PR34)],
    ],
    [
        [qw(couples=1 events=1 beer=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR19 PR34)],
    ],
    [
        [qw(couples=1 events=1 buildings=1 beer=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 beer=2)],
        [qw(20-IV 20-V 21-IV PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1 beer=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1 buildings=1 beer=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1 beer=2)],
        [qw(20-IV 20-V 21-IV PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 beer=2)],
        [qw(30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 events=1 beer=2)],
        [qw(30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 events=1 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=2 beer=2)],
        [qw(30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1 beer=2)],
        [qw(30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 events=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 events=1 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1 buildings=1 beer=2)],
        [qw(30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1 beer=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1 buildings=1 beer=2)],
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
        [qw(attack=2 reminiscences=2 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1 buildings=1 beer=2)],
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
    [
        [qw(attack=2 couples=1 reminiscences=2 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 events=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 events=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1 buildings=1 beer=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
