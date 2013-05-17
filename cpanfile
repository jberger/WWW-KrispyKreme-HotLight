requires 'perl', '5.008005';

requires 'Moose',                    '0.0';
requires 'URI',                      '0.0';
requires 'WWW::Mechanize',           '0.0';
requires 'HTML::TreeBuilder::XPath', '0.0';
requires 'Mojo::JSON',               '0.0';

on test => sub {
    requires 'Test::More', '0.88';
};
