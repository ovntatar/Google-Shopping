package Google::Shopping;

use 5.006;
use strict;
use warnings;

=head1 NAME

Google::Shopping - Perl implementation of Search API for Google Shopping!

=head1 VERSION

Version 0.04

=cut

use Moose;
use MooseX::Params::Validate;
use Moose::Util::TypeConstraints;
use namespace::clean;

use Carp;
use Data::Dumper;


use JSON;
use XML::Simple;
use Readonly;
use HTTP::Request;
use LWP::UserAgent;


our $VERSION = '0.04';

Readonly my $API_VERSION => 'v1';
Readonly my $BASE_URL    => "https://www.googleapis.com/shopping/search/$API_VERSION/public";

type 'OutputFormat' => where { /\bjson\b|\batom\b/i  };
type 'TrueFalse'    => where { /\btrue\b|\bfalse\b/i };
has  'api_key'      => (is => 'ro', isa => 'Str', required => 1);
has  'country'      => (is => 'ro', isa => 'Str');
has  'products'		=> (is => 'ro', isa => 'Str', default => 'products', required => 1);
has  'cref'         => (is => 'ro', isa => 'Str');
has  'alt'          => (is => 'ro', isa => 'OutputFormat', default => 'json');
has  'rankBy'       => (is => 'rw', isa => 'Str');
has  'crowdBy'      => (is => 'rw', isa => 'Str');
has  'spelling_enable'     => (is => 'rw', isa => 'TrueFalse', default => 'true');
has  'facets_enable'       => (is => 'rw', isa => 'TrueFalse', default => 'true');
has  'facets_include'      => (is => 'rw', isa => 'Str');
has  'brand'        => (is => 'rw', isa => 'Str');
has	 'language' 	=> (is => 'ro', isa => 'Str', default => 'en');
has  'browser'      => (is => 'rw', isa => 'LWP::UserAgent', default => sub { return LWP::UserAgent->new(); });


around BUILDARGS => sub
{
    my $orig  = shift;
    my $class = shift;

    if (@_ == 1 && ! ref $_[0]) {
        return $class->$orig(api_key => $_[0]);
    } elsif (@_ == 2 && ! ref $_[0]) {
        return $class->$orig(api_key => $_[0], country => $_[1]);
    } else {
        return $class->$orig(@_);
    }
};

=head1 SUBROUTINES/METHODS

=head2 BUILD

Check if country and api parameter available!

=cut


sub BUILD
{
  my $self = shift;
  croak("ERROR: country and api_key must be specified.\n") unless ($self->country || $self->api_key);
}

=head2 search

Generate URL with parameters values and send HTTP Request!

=cut



sub search
{
    my $self    = shift;
    my ($query) = pos_validated_list(\@_, { isa => 'Str', required => 1 }, MX_PARAMS_VALIDATE_NO_CACHE => 1);

    my ($browser, $url, $request, $response, $content);
    $browser   = $self->browser;
    $url       = sprintf("%s/%s", $BASE_URL, $self->products);
    $url      .= sprintf("?key=%s", $self->api_key);
    $url 	  .= sprintf("&country=%s", $self->country);
    
   
    $url .= sprintf("&alt=%s",    $self->alt)    if $self->alt;
    $url .= sprintf("&rankBy=%s", $self->rankBy)    if $self->rankBy;
    $url .= sprintf("&brand=%s", $self->brand)    if $self->brand;
    $url .= sprintf("&crowdBy=%s", $self->crowdBy)    if $self->crowdBy;
    $url .= sprintf("&spelling.enabled=%s", $self->spelling_enable)    if $self->spelling_enable;
    $url .= sprintf("&facets.enabled=%s", $self->facets_enable)    if $self->facets_enable;
    $url .= sprintf("&facets.include=%s", $self->facets_include)    if $self->facets_include;
    $url .= sprintf("&q=%s",      $query);
    $url .= sprintf("&language=%s",      $self->language);


    $request  = HTTP::Request->new(GET => $url);
    $response = $browser->request($request);
    	
    croak("ERROR: Couldn't fetch data [$url]:[".$response->status_line."]\n") unless $response->is_success;
    $content  = $response->content;
    croak("ERROR: No data found.\n") unless defined $content;
    if (defined $self->alt && ($self->alt =~ /atom/i)) {
        $content = XMLin($content);
    }
    
    return $content;
}


__PACKAGE__->meta->make_immutable;
no Moose; 
no Moose::Util::TypeConstraints;

=head1 SYNOPSIS

Google::Shopping - usage!

	use strict; 
	use warnings;
	
	use Google::Shopping;
	use Data::Dumper;
	use XML::Simple;
	use JSON; 
	 
	my $api_key = '<GOOGLE_API_KEY>';
	my $country ='US';
	my $str = Google::Shopping->new(api_key=>$api_key, country=>$country, rankBy=>"price:descending");
	my $shopping = $str->search('Perl');
		
	my $data = decode_json($shopping);
	foreach my $items(@{$data->{items}}){
	 print $items->{product}->{inventories}->[0]->{price} ;
	 print $items->{product}->{inventories}->[0]->{currency} . "\n";
	}

=head1 AUTHOR

Ovidiu Nita Tatar, C<< <ovn.tatar at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to: https://github.com/ovntatar/Google-Shopping/issues

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Google::Shopping


You can also look for information at: https://github.com/ovntatar/Google-Shopping

or on the Google official api documnetation site: https://developers.google.com/shopping-search/v1/getting_started#filters


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Ovidiu Nita Tatar.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;

