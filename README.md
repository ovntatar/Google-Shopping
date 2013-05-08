Google-Shopping

Google::Shopping - a interface to  Google::Shopping!

INSTALLATION

To install this module, run the following commands:

   	./perl Build.PL
	./Build
	./Build test
	./Build install

SYNOPSIS

Google::Shopping - is a interface to Google Shopping Search API.

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
    ...



After installing, you can find documentation for this module with the
perldoc command.

    perldoc Google::Shopping
    
    You can also look for information at: https://github.com/ovntatar/GoogleShopping 
    or on the Google official api documnetation site: 
    https://developers.google.com/shopping-search/v1/getting_started#filters

You can also look for information at:

    RT, CPAN's request tracker (report bugs here)
        http://rt.cpan.org/NoAuth/Bugs.html?Dist=Google-Shopping

    AnnoCPAN, Annotated CPAN documentation
        http://annocpan.org/dist/Google-Shopping

    CPAN Ratings
        http://cpanratings.perl.org/d/Google-Shopping

    Search CPAN
        http://search.cpan.org/dist/Google-Shopping/


LICENSE AND COPYRIGHT

Copyright (C) 2013 Ovidiu Nita Tatar

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

