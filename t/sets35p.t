## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(3 5 101);

my @testcases = (
    [
        [qw()],
        [qw(PR19 PR34)],
    ],
    [
        [qw(events=1)],
        [qw(PR19 PR34 PR43)],
    ],
    [
        [qw(buildings=1)],
        [qw(PR19 PR34 20-V)],
    ],
    [
        [qw(events=1 buildings=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 events=1)],
        [qw(PR19 PR34 PR43)],
    ],
    [
        [qw(reminiscences=2 buildings=1)],
        [qw(PR19 PR34 20-V)],
    ],
    [
        [qw(reminiscences=2 events=1 buildings=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 events=1)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(reminiscences=1 buildings=1)],
        [qw(PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(reminiscences=1 events=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1)],
        [qw(PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 events=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1)],
        [qw(PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 events=1 buildings=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2)],
        [qw(PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1)],
        [qw(PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1 buildings=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1)],
        [qw(PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1)],
        [qw(PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1)],
        [qw(PR19 PR34 30-III PR43)],
    ],
    [
        [qw(attack=1 events=1)],
        [qw(PR19 PR34 30-III PR43)],
    ],
    [
        [qw(attack=1 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 events=1 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 reminiscences=2)],
        [qw(PR19 PR34 30-III PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1)],
        [qw(PR19 PR34 30-III PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 reminiscences=1)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1)],
        [qw(PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 events=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 events=1 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1 buildings=1)],
        [qw(PR19 PR34 30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1 buildings=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 events=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1 buildings=1)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );

