package Local::TantoCuore::Test;

use warnings;
use strict;
use version; our $VERSION = qv(1.00);
use Capture::Tiny qw(capture);
use Test::More 0.88;
use File::Temp qw(tempdir);
use English qw( -no_match_vars );
use Carp qw(croak);
use List::MoreUtils qw(any);

use Exporter qw(import);

our @EXPORT_OK   = qw(run_tests);
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

# As the output is meant to be random, not all cases can be tested easily.
# Tests are only to detect the cards to be removed from game or to be allowed/disallowed.

sub _post_submit {
    my ($params) = @ARG;

    local $ENV{REQUEST_METHOD} = 'POST';
    local $ENV{CONTENT_LENGTH} = length $params;

    my $dir    = tempdir( CLEANUP => 1 );
    my $infile = "$dir/in.txt";

    open my $fh, '>', $infile || croak "Could not open '$infile' $ERRNO";
    print {$fh} $params || croak "Could not write '$infile' $ERRNO";
    close $fh || croak "Could not close '$infile' $ERRNO";

    my ( $out, $err, $exit ) = capture { system "./index.pl < $infile" };

    return ( $out, $err, $exit );
}

sub _page_content_tests {
    my ( $out, $resultlist ) = @ARG;

    my %result_tests = (
        'Error'   => [ qr{Error:}xms,          'error message' ],
        'BarMaid' => [ qr{Bar\s+Maid}xms,      'Bar Maid' ],
        '19'      => [ qr{<td>19</td>}xms,     'card 19' ],
        '20'      => [ qr{<td>20</td>}xms,     'card 20' ],
        '21'      => [ qr{<td>21</td>}xms,     'card 21' ],
        '25'      => [ qr{<td>25</td>}xms,     'card 25' ],
        '20-II'   => [ qr{<td>20-II</td>}xms,  'card 20-II' ],
        '27-II'   => [ qr{<td>27-II</td>}xms,  'card 27-II' ],
        '30-III'  => [ qr{<td>30-III</td>}xms, 'card 30-III' ],
        '20-IV'   => [ qr{<td>20-IV</td>}xms,  'card 20-IV' ],
        '21-IV'   => [ qr{<td>21-IV</td>}xms,  'card 21-IV' ],
        '20-V'    => [ qr{<td>20-V</td>}xms,   'card 20-V' ],
        'PR14'    => [ qr{<td>PR14</td>}xms,   'card PR14' ],
        'PR19'    => [ qr{<td>PR19</td>}xms,   'card PR19' ],
        'PR34'    => [ qr{<td>PR34</td>}xms,   'card PR34' ],
        'PR43'    => [ qr{<td>PR43</td>}xms,   'card PR43' ],
    );

    my $removelist = q{};
    my $addlist    = q{};
    for my $elem ( sort keys %result_tests ) {
        if ( any { $ARG eq $elem } @{$resultlist} ) {
            if (!(  like $out,
                    $result_tests{"$elem"}[0],
                    $result_tests{"$elem"}[1] . ' required'
                )
                )
            {
                $removelist .= $elem . q{ };
            }
        }
        elsif ( $elem ne ('BarMaid') ) {
            if (!(  unlike $out,
                    $result_tests{"$elem"}[0],
                    $result_tests{"$elem"}[1] . ' disallowed'
                )
                )
            {
                $addlist .= $elem . q{ };
            }
        }
    }
    if ( $addlist ne q{} ) {
        print "Add list: $addlist\n";
    }
    if ( $removelist ne q{} ) {
        print "Remove list: $removelist\n";
    }
    return 0;
}

sub _standard_tests {
    my ( $err, $exit ) = @ARG;

    is $err,  q{}, 'stderr is empty';
    is $exit, 0,   'exit code is 0';
    return 0;
}

sub _get_test_result {
    my ( $sets, $params, $cardlist ) = @ARG;

    for my $elem ( @{$sets} ) {
        push @{$params} => "sets=$elem";
    }
    push @{$params} => '.Page=Randomize';

    my $formed_parameters = q{};
    for my $elem ( @{$params} ) {
        if ( defined $elem ) {
            $formed_parameters .= q{&} . $elem;
        }
    }
    $formed_parameters =~ s{\A&}{}mxs;

    my ( $out, $err, $exit ) = _post_submit($formed_parameters);

    _standard_tests( $err, $exit );
    _page_content_tests( $out, \@{$cardlist} );

    return 0;
}

sub run_tests {
    my ( $sets, $testcases ) = @ARG;

    plan tests => scalar @{$testcases};

    my %set_names = (
        '1'   => 'Tanto Cuore',
        '2'   => 'Expanding the House',
        '3'   => 'Romantic Vacation',
        '4'   => 'Oktoberfest',
        '5'   => 'Winter Romance',
        '101' => 'Intl. Tabletop Day 2016 (Promo)',
    );

    my %option_names = (
        q{private=1}       => 'no private maids',
        q{events=1}        => 'no events',
        q{buildings=1}     => 'no buildings',
        q{reminiscences=2} => 'ensure reminiscence cost spread',
        q{reminiscences=1} => 'no reminiscences',
        q{beer=1}          => 'using beer mechanic',
        q{beer=2}          => 'not using beer mechanic',
        q{couples=1}       => 'not using couples mechanic',
        q{attack=1}        => 'no attack cards',
        q{attack=2}        => 'only attack cards',
    );

    my $setnames = q{};
    for my $elem ( @{$sets} ) {
        $setnames .= $set_names{"$elem"} . q{, };
    }
    $setnames =~ s{,\s+\z}{}xms;

    for my $elem ( @{$testcases} ) {
        my $options   = q{};
        my $paramlist = q{};
        for my $param ( @{ ${$elem}[0] } ) {
            if ( defined $param ) {
                $options   .= $option_names{"$param"} . q{, };
                $paramlist .= $param . q{ };
            }
        }
        $options =~ s{,\s+\z}{}xms;
        if ( $options eq q{} ) {
            $options = q{no options};
        }
        subtest "$setnames - $options : $paramlist" => sub {
            _get_test_result( $sets, ${$elem}[0], ${$elem}[1] );
        };
    }

    done_testing();

    return 0;
}

1;
