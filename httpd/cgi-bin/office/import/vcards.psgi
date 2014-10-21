#!/usr/bin/perl
#
# Run with:
# starman -l 127.0.0.1:5005 --workers 1 httpd/cgi-bin/office/import/vcards.psgi &
# or, for more debug output:
# plackup -l 127.0.0.1:5005 httpd/cgi-bin/office/import/vcards.psgi &

use strict;
use warnings;

use CGI::Application::Dispatch::PSGI;

use Plack::Builder;

# ---------------------

my($app) = CGI::Application::Dispatch -> as_psgi
(
	prefix => 'App::Office::Contacts::Import::vCards::Controller',
	table  =>
	[
	''              => {app => 'Initialize', rm => 'display'},
	':app'          => {rm => 'display'},
	':app/:rm/:id?' => {},
	],
);

builder
{
	enable "Plack::Middleware::Static",
	path => qr!^/(assets|yui)/!,
	root => '/var/www';
	$app;
};
