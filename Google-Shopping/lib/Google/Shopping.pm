package Google::Shopping;

use strict;
use 5.008_001; # for utf8::is_utf8()
our $VERSION = '0.01';

use LWP::UserAgent;
use URI::Escape qw(uri_escape_utf8 uri_escape);
use Carp qw(croak);


sub get {
 my $text="Package Coming Soon!";
 return $text;
}


1;

__END__


=head1 NAME

Google::Shopping - a interface to  Google::Shopping!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Google::Shopping - is a interface to Google Shopping Search API.

    use Google::Shopping;

    my $foo = Google::Shopping->new();
    ...


=head1 AUTHOR

Ovidiu Nita Tatar, C<< <ovn.tatar at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to: https://github.com/ovntatar/GoogleShopping/issues

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Google::Shopping


You can also look for information at: https://github.com/ovntatar/GoogleShopping


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Ovidiu Nita Tatar.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.



