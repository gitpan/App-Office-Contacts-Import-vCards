#!/usr/bin/perl
#
# Run with:
# 1)
# Edit .htoffice.contacts.conf to change tmpl_path to /dev/shm...
# 2) One of:
# start_server --port=127.0.0.1:5005 -- starman --workers 1 httpd/cgi-bin/office/import/vcards.psgi &
# or
# plackup --host 127.0.0.1 --port 5005 httpd/cgi-bin/office/import/vcards.psgi &

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
