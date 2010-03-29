#!/usr/bin/perl

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
