## no critic (Modules::RequireExplicitPackage, Modules::RequireVersionVar, Modules::RequireEndWithOne)
use warnings;
use strict;
use File::Basename qw(dirname);

use lib dirname(__FILE__) . '/../lib';
use Local::TantoCuore::Test qw(:all);

my @sets      = qw(1 2 4);

my @testcases = (
    [
        [qw(beer=1)],
        [qw(PR14)],
    ],
    [
        [qw(beer=1 private=1)],
        [qw()],
    ],
    [
        [qw(beer=1 events=1)],
        [qw(20 21 PR14)],
    ],
    [
        [qw(beer=1 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(beer=1 buildings=1)],
        [qw(27-II PR14 20-IV)],
    ],
    [
        [qw(beer=1 private=1 buildings=1)],
        [qw(20-IV)],
    ],
    [
        [qw(beer=1 events=1 buildings=1)],
        [qw(20 21 27-II PR14)],
    ],
    [
        [qw(beer=1 private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(beer=2)],
        [qw(PR14 PR19 PR34 21-IV)],
    ],
    [
        [qw(beer=2 private=1)],
        [qw(21-IV)],
    ],
    [
        [qw(beer=2 events=1)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 events=1)],
        [qw()],
    ],
    [
        [qw(beer=2 buildings=1)],
        [qw(27-II PR14 PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 private=1 buildings=1)],
        [qw(20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 buildings=1)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 events=1 buildings=1)],
        [qw()],
    ],
    [
        [qw(beer=1 attack=1)],
        [qw(20 21 19 25 20-II PR14)],
    ],
    [
        [qw(beer=1 private=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=1 events=1 attack=1)],
        [qw(20 21 19 25 20-II PR14)],
    ],
    [
        [qw(beer=1 private=1 events=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=1 buildings=1 attack=1)],
        [qw(20 21 19 25 20-II 27-II PR14)],
    ],
    [
        [qw(beer=1 private=1 buildings=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=1 events=1 buildings=1 attack=1)],
        [qw(20 21 19 25 20-II 27-II PR14)],
    ],
    [
        [qw(beer=1 private=1 events=1 buildings=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=2 attack=1)],
        [qw(20 21 19 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=2 events=1 attack=1)],
        [qw(20 21 19 25 20-II PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 events=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=2 buildings=1 attack=1)],
        [qw(20 21 19 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 buildings=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=2 events=1 buildings=1 attack=1)],
        [qw(20 21 19 25 20-II 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 events=1 buildings=1 attack=1)],
        [qw()],
    ],
    [
        [qw(beer=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 private=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 private=1 events=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 private=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=1 private=1 events=1 buildings=1 attack=2)],
        [qw(Error)],
    ],
    [
        [qw(beer=2 attack=2)],
        [qw(PR14 PR19 PR34 21-IV)],
    ],
    [
        [qw(beer=2 private=1 attack=2)],
        [qw(21-IV)],
    ],
    [
        [qw(beer=2 events=1 attack=2)],
        [qw(20 21 PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 events=1 attack=2)],
        [qw()],
    ],
    [
        [qw(beer=2 buildings=1 attack=2)],
        [qw(27-II PR14 PR19 PR34 20-IV 21-IV)],
    ],
    [
        [qw(beer=2 private=1 buildings=1 attack=2)],
        [qw(20-IV 21-IV)],
    ],
    [
        [qw(beer=2 events=1 buildings=1 attack=2)],
        [qw(20 21 27-II PR14 PR19 PR34)],
    ],
    [
        [qw(beer=2 private=1 events=1 buildings=1 attack=2)],
        [qw()],
    ],
);

run_tests( \@sets, \@testcases );

