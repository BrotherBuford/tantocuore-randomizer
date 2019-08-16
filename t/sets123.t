## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(1 2 3);

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
        [qw(20 21 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1)],
        [qw()],
    ],
    [
        [qw(buildings=1)],
        [qw(27-II PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(events=1 buildings=1)],
        [qw(20 21 27-II PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(reminiscences=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(private=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(events=1 reminiscences=2)],
        [qw(20 21 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(buildings=1 reminiscences=2)],
        [qw(27-II PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(events=1 buildings=1 reminiscences=2)],
        [qw(20 21 27-II PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 reminiscences=2)],
        [qw()],
    ],
    [
        [qw(reminiscences=1)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 reminiscences=1)],
        [qw()],
    ],
    [
        [qw(events=1 reminiscences=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 reminiscences=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 reminiscences=1)],
        [qw(27-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 reminiscences=1)],
        [qw()],
    ],
    [
        [qw(events=1 buildings=1 reminiscences=1)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 reminiscences=1)],
        [qw()],
    ],
    [
        [qw(attack=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(events=1 attack=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(buildings=1 attack=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(events=1 buildings=1 attack=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(reminiscences=2 attack=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(events=1 reminiscences=2 attack=1)],
        [qw(19 20 21 25 20-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(buildings=1 reminiscences=2 attack=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(events=1 buildings=1 reminiscences=2 attack=1)],
        [qw(19 20 21 25 20-II 27-II 30-III PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 reminiscences=2 attack=1)],
        [qw(30-III)],
    ],
    [
        [qw(reminiscences=1 attack=1)],
        [qw(19 20 21 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 reminiscences=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 reminiscences=1 attack=1)],
        [qw(19 20 21 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 reminiscences=1 attack=1)],
        [qw()],
    ],
    [
        [qw(buildings=1 reminiscences=1 attack=1)],
        [qw(19 20 21 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 buildings=1 reminiscences=1 attack=1)],
        [qw()],
    ],
    [
        [qw(events=1 buildings=1 reminiscences=1 attack=1)],
        [qw(19 20 21 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 events=1 buildings=1 reminiscences=1 attack=1)],
        [qw()],
    ],
    [
        [qw(attack=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(private=1 attack=2)],
        [qw()],
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
        [qw(reminiscences=2 attack=2)],
        [qw(PR19 PR34)],
    ],
    [
        [qw(private=1 reminiscences=2 attack=2)],
        [qw()],
    ],
    [
        [qw(events=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 buildings=1 reminiscences=2 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(reminiscences=1 attack=2)],
        [qw(PR14 PR19 PR34)],
    ],
    [
        [qw(private=1 reminiscences=1 attack=2)],
        [qw()],
    ],
    [
        [qw(events=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(events=1 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(private=1 events=1 buildings=1 reminiscences=1 attack=2)],
        [qw(Error)],
    ],
);

run_tests( \@sets, \@testcases );




