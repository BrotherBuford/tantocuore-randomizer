#!/usr/bin/perl

package Coinwidget;

use warnings;
use strict;
use version; our $VERSION = qv(1.00);
use HTML::Tiny;

sub donate {

    my $h = HTML::Tiny->new;

    my $output = $h->div(
        { style => 'display: inline-block;', },
        [   $h->div(
                {   class => 'boxheader',
                    style => 'background-color: #e17000; color: #ffffff;',
                },
                [   $h->b(
                        '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your donations help keep this site alive!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
                    ),
                ]
            ),

            $h->div(
                {   class => 'boxcontent',
                    style => 'background-color: #ffffff; color: #000000;',
                },
                [   $h->table(
                        {   border      => '0',
                            cellpadding => '0',
                            cellspacing => '4',
                        },
                        [   $h->tr(
                                [   $h->td(
                                        [   $h->script(
                                                {   type => 'text/javascript',
                                                    src =>
                                                        'coinwidget/coin.js',
                                                }
                                            ),
                                            $h->script(
                                                {   type => 'text/javascript',
                                                    src =>
                                                        'coinwidget/config.js',
                                                }
                                            ),
                                        ]
                                    ),
                                ]
                            )
                        ]
                    ),
                ]
            ),
        ]
    );

    return $output;
}

1;
