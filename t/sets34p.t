## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(3 4 101);

my @testcases = (
    [
        [qw(beer=1)],
        [qw()],
    ],
    [
        [qw(beer=1 events=1)],
        [qw()],
    ],
    [
        [qw(beer=1 buildings=1)],
        [qw(20-IV)],
    ],
    [
        [qw(beer=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(beer=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(beer=1 events=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(beer=1 buildings=1 reminiscences=2)],
        [qw(20-IV)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(beer=1 reminiscences=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=1 events=1 reminiscences=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=1 buildings=1 reminiscences=1)],
        [qw(PR14 20-IV)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 reminiscences=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=2)],
        [qw(PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(beer=2 buildings=1)],
        [qw(PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 buildings=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(beer=2 reminiscences=2)],
        [qw(PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(beer=2 buildings=1 reminiscences=2)],
        [qw(PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(beer=2 reminiscences=1)],
        [qw(PR14 PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 buildings=1 reminiscences=1)],
        [qw(PR14 PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(beer=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 events=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 buildings=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 events=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 buildings=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(beer=1 reminiscences=1 attack=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=1 events=1 reminiscences=1 attack=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=1 buildings=1 reminiscences=1 attack=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 reminiscences=1 attack=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=2 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 events=1 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 buildings=1 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 reminiscences=2 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 events=1 reminiscences=2 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 buildings=1 reminiscences=2 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 reminiscences=2 attack=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(beer=2 reminiscences=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 events=1 reminiscences=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 buildings=1 reminiscences=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 reminiscences=1 attack=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(beer=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 events=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 events=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 events=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
