## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(1 2 3 5);

my @testcases = (
    [
        [qw()],
        [qw(PR19 PR34)],
    ],
    [
        [qw(private=1)],
        [qw()],
    ],
    [
        [qw(events=1)],
        [qw(20 21 PR19 PR34 PR43)],
    ],
    [
        [qw(private=1 events=1)],
        [qw()],
    ],
    [
        [qw(buildings=1)],
        [qw(27-II 20-V PR19 PR34)],
    ],
    [
        [qw(buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(buildings=1 events=1)],
        [qw(20 21 27-II PR19 PR34)],
    ],
    [
        [qw(buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 private=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2 events=1)],
        [qw(20 21 PR19 PR34 PR43)],
    ],
    [
        [qw(reminiscences=2 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2 buildings=1)],
        [qw(27-II 20-V PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(reminiscences=2 buildings=1 events=1)],
        [qw(20 21 27-II PR19 PR34)],
    ],
    [
        [qw(reminiscences=2 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 private=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=1 events=1)],
        [qw(20 21 PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(reminiscences=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=1 buildings=1)],
        [qw(27-II 20-V PR14 PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(reminiscences=1 buildings=1 events=1)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(reminiscences=1 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 events=1)],
        [qw(20 21 PR19 PR34)],
    ],
    [
        [qw(couples=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1 buildings=1)],
        [qw(27-II 20-V PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(couples=1 buildings=1 events=1)],
        [qw(20 21 27-II PR19 PR34)],
    ],
    [
        [qw(couples=1 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 private=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=2 events=1)],
        [qw(20 21 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1)],
        [qw(27-II 20-V PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1 events=1)],
        [qw(20 21 27-II PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=2 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 private=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=1 events=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1)],
        [qw(27-II 20-V PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1 events=1)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(couples=1 reminiscences=1 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 private=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 events=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 private=1 events=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 buildings=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 buildings=1 private=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 buildings=1 events=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 buildings=1 private=1 events=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 reminiscences=2)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 private=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 events=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 private=1 events=1)],
        [qw(30-III PR43)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1 private=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1 events=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=2 buildings=1 private=1 events=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 reminiscences=1)],
        [qw(19 20 21 25 20-II PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=1 reminiscences=1 events=1)],
        [qw(19 20 21 25 20-II PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=1 reminiscences=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1)],
        [qw(19 20 21 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1 events=1)],
        [qw(19 20 21 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 reminiscences=1 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 events=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 private=1 events=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 private=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 events=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 buildings=1 private=1 events=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 private=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 events=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 private=1 events=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1 private=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1 events=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=2 buildings=1 private=1 events=1)],
        [qw(30-III)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1)],
        [qw(19 20 21 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 events=1)],
        [qw(19 20 21 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1)],
        [qw(19 20 21 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1 events=1)],
        [qw(19 20 21 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=1 couples=1 reminiscences=1 buildings=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(attack=2 private=1)],
        [qw()],
    ],
    [
        [qw(attack=2 events=1)],
        [qw(20 21 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=2 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2 buildings=1)],
        [qw(20-V 27-II PR19 PR34)],
    ],
    [
        [qw(attack=2 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(attack=2 buildings=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 buildings=1 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(attack=2 reminiscences=2 private=1)],
        [qw()],
    ],
    [
        [qw(attack=2 reminiscences=2 events=1)],
        [qw(20 21 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=2 reminiscences=2 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1)],
        [qw(20-V 27-II PR19 PR34)],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=2 buildings=1 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 reminiscences=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=2 reminiscences=1 events=1)],
        [qw(20 21 PR14 PR19 PR34 PR43)],
    ],
    [
        [qw(attack=2 reminiscences=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1)],
        [qw(20-V 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 reminiscences=1 buildings=1 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 events=1)],
        [qw(20 21 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 buildings=1)],
        [qw(20-V 27-II PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 buildings=1 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2)],
        [qw(PR19 PR34)],
    ],
#    [
#        [qw(attack=2 couples=1 reminiscences=2 private=1)],
#        [qw()],
#    ],
#    [
#        [qw(attack=2 couples=1 reminiscences=2 events=1)],
#        [qw(Error)],
#    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1)],
        [qw(20-V 27-II PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=2 buildings=1 private=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 private=1)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 events=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1)],
        [qw(27-II PR14 PR19 PR34 20-V)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1 private=1)],
        [qw(20-V)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1 events=1)],
        [qw(Error)],
    ],
    [
        [qw(attack=2 couples=1 reminiscences=1 buildings=1 private=1 events=1)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );
