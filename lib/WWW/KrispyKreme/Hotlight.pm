package WWW::KrispyKreme::Hotlight;

use Mojo::Base -base;
use Mojo::UserAgent;
use Mojo::URL;

our $VERSION = '0.01';

has 'where';
has locations => \&_build_locations;

sub _build_locations {
  my ($self) = @_;
  my $geo = $self->where or return [];

  my $url = Mojo::URL->new('http://locations.krispykreme.com');

  my $ua = Mojo::UserAgent->new;
  my $locations = $ua->get(
    $url->clone->path('/Store-Locator/'),
    { 'X-Requested-With' => 'XMLHttpRequest' },
    form => {
      lat => $geo->[0],
      lng => $geo->[1],
    },
  )->res
   ->dom('.content-locations .content-results')
   ->map(sub{$_->{id}})
   ->join(',');

  return [] unless $locations;

  my $json = $ua->post(
    $url->clone->path('/Hotlight/HotLightStatus.ashx'),
    { Referer => $url->host },
    form => {locations => $locations},
  )->res
   ->json;

  return $json && $json->{status} eq 'success'
    ? [@{$json->{data}{locations}}]
    : [];
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::KrispyKreme::Hotlight - Fetch Krispy Kreme locations near a given geolocation!

=head1 SYNOPSIS

  use WWW::KrispyKreme::Hotlight;

  my $donuts = WWW::KrispyKreme::Hotlight->new(where => [34.170833,-118.25]);

  # get array ref of all the krispy kreme locations near given geo
  my $stores = $donuts->locations;

  foreach my $store (@$stores) {

      # boolean value which shows if the Hot Light is on now!
      my $is_fresh = $store->{hotLightOn};

      # store name (Burbank, Los Angeles, etc)
      my $store_name = $store->{title};

      # geolocation of store
      my $geo = $store->{geoLocation};

      # shortened krispy kreme link to the location page!
      # i.e. http://kkre.me/okjGVT
      my $url = $store->{url};
  }

=head1 DESCRIPTION

WWW::KrispyKreme::Hotlight is a Perl wrapper for Krispy Kreme's location search
page.  This module will return an array ref of hash refs which contain info for
all the Krispy Kreme stores near the given geolocation.

=head1 METHODS

=head2 new

Creates a new WWW::KrispyKreme::Hotlight object.  Currently the only REQUIRED
option is 'where' and only supports geo

    my $donuts = WWW::KrispyKreme::Hotlight->new(where => [34.170833,-118.25]);

=head2 locations

Returns an array ref of hash refs.  Each hash ref represents a store near the
given geolocation.  A structure will look like this:

    [   {   'storeHours2' => '',
            'locationId'  => '993',
            'hotLightOn'  => '0',
            'storeHours1' => '',
            'phone'       => '818-955-9015',
            'zipcode'     => '91504',
            'state'       => 'CA',
            'city'        => 'Burbank',
            'geoLocation' => '34.190000,-118.330000',
            'url'         => 'http://kkre.me/oXMuQQ',
            'title'       => 'Burbank',
            'address'     => '1521 North Victory Place'
        },
        {   'storeHours2' => '',
            'locationId'  => '985',
            'hotLightOn'  => '0',
            'storeHours1' => '',
            'phone'       => '323-291-4133',
            'zipcode'     => '90008',
            'state'       => 'CA',
            'city'        => 'Los Angeles',
            'geoLocation' => '34.010000,-118.340000',
            'url'         => 'http://kkre.me/pF3cuI',
            'title'       => 'Los Angeles',
            'address'     => '4034 Crenshaw Boulevard'
        },
        {   'storeHours2' => '',
            'locationId'  => '4502',
            'hotLightOn'  => '0',
            'storeHours1' => '',
            'phone'       => '310-393-8319',
            'zipcode'     => '90403',
            'state'       => 'CA',
            'city'        => 'Santa Monica',
            'geoLocation' => '34.030000,-118.490000',
            'url'         => 'http://kkre.me/okjGVT',
            'title'       => 'Santa Monica',
            'address'     => '1231 Wilshire Boulevard'
        },
        {   'storeHours2' => '',
            'locationId'  => '984',
            'hotLightOn'  => '0',
            'storeHours1' => '',
            'phone'       => '310-532-5281',
            'zipcode'     => '90248',
            'state'       => 'CA',
            'city'        => 'Gardena',
            'geoLocation' => '33.870000,-118.290000',
            'url'         => 'http://kkre.me/r55gEc',
            'title'       => 'Gardena',
            'address'     => '1199 W. Artesia Boulevard'
        },
        {   'storeHours2' => '',
            'locationId'  => '989',
            'hotLightOn'  => '0',
            'storeHours1' => '',
            'phone'       => '626-964-5044',
            'zipcode'     => '91748',
            'state'       => 'CA',
            'city'        => 'City of Industry',
            'geoLocation' => '34.000000,-117.930000',
            'url'         => 'http://kkre.me/pnyzpu',
            'title'       => 'City Of Industry',
            'address'     => '1548 Azusa Avenue'
        }
    ]

=cut

=head1 AUTHOR

Curtis Brandt E<lt>curtis@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2013- Curtis Brandt

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
