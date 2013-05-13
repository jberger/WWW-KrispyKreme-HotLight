package WWW::KrispyKreme::Hotlight;

use Moose;
use 5.008_005;
use URI;
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Geo::PostalCode;

our $VERSION = '0.01';

has where => (is => 'rw', isa => 'Int');

has hours => (is => 'rw', lazy => 1, builder => '_build_hours');

sub _build_hours {
    my ($self) = @_;
    my $loc = $self->{where} or return {};

    #my %location_hours;

    my $mech = WWW::Mechanize->new;
    my $uri = URI->new('http://locations.krispykreme.com/');
    $mech->get($uri->as_string);
    my ($form) = $mech->forms;
    foreach my $input ($form->inputs) {
        $input->value($loc) if $input->name and $input->name eq 'PostalCode';
    }
    #warn $form->attr('id');
    my $r = $mech->submit_form(with_fields => {PostalCode => 91202});
    warn $r->is_success;
    warn $r->content;
    #$uri->query_form({PostalCode => $loc,});
    #$mech->post

    #my $tree = HTML::TreeBuilder::XPath->new_from_content($mech->content);
    #my @cities =
    #  map { my $h = $_->attr('href'); $h =~ /^http/ ? $h : "http://locations.krispykreme.com$h" }
    #  grep { $_->as_text =~ /$loc/ }
    #  $tree->findnodes('.//ul[@class="content-states"]//ul/li/a[@href=~/location/]');

    #foreach my $city (@cities) {
    #    $mech->get($city);
    #    $tree->parse_content($mech->content);

    #    my @hrs = map { split(/\s*\|\s*/, $_) } $tree->findvalues('.//ul[@class="hours-container"]//li[not(./*)]');
    #    $location_hours{$city} = \@hrs;

    #    if (@hrs) {
    #        my $parsed = $self->_parse_hours(join '; ', @hrs);
    #        use Data::Dumper;
    #        warn Dumper $parsed;
    #    }
    #}
    ## '5:30-10A & 5:30-9:30 P (Sun-Thr)',
    ## '5:30 A-10A & 5-10P Fri & Sat'
    #return \%location_hours;
}

sub _parse_hours {
    my ($self, $hours) = @_;

    my %hrs;
    warn $hours;

    my $hr_regex = qr{\d{1,2}[:\d]* \s* (?:to|-) \s* \d{1,2}[:\d]*}ix;
    warn $hours =~ /$hr_regex{2}/;# (?: (?:and|&) \d{1,2})?
    #/ix;
    #(?: \s+ \(? ([A-Z]{3,}) \s* [\-&] \s* ([A-Z]{3,}) \)? )? \b

    #while ($hours =~ /(\d{1,2}[:\d]*)\s*(?:to|-)?\s*(?:\s+\(?([A-Z]{3,})\s*[\-&]\s*([A-Z]{3,})\)?)?\b/gi) {
    #    warn $1;
    #    warn $2;
    #}

    return \%hrs;
}

1;
__END__

=encoding utf-8

=head1 NAME

WWW::KrispyKreme::Hotlight - Blah blah blah

=head1 SYNOPSIS

  use WWW::KrispyKreme::Hotlight;

=head1 DESCRIPTION

WWW::KrispyKreme::Hotlight is

=head1 AUTHOR

Curtis Brandt E<lt>curtis@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2013- Curtis Brandt

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
