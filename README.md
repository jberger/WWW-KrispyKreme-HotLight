# NAME

WWW::KrispyKreme::Hotlight - Fetch Krispy Kreme locations near a given geolocation!

# SYNOPSIS

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

# DESCRIPTION

WWW::KrispyKreme::Hotlight is a Perl wrapper for Krispy Kreme's location search
page.  This module will return an array ref of hash refs which contain info for
all the Krispy Kreme stores near the given geolocation.

# METHODS

## new

Creates a new WWW::KrispyKreme::Hotlight object.  Currently the only REQUIRED
option is 'where' and only supports geo

    my $donuts = WWW::KrispyKreme::Hotlight->new(where => [34.170833,-118.25]);

## locations

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

# AUTHOR

Curtis Brandt <curtis@cpan.org>

# COPYRIGHT

Copyright 2013- Curtis Brandt

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
