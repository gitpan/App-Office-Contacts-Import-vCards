package App::Office::Contacts::Import::vCards::Controller;

use base 'App::Office::Contacts';
use strict;
use warnings;

use App::Office::Contacts::Database;
use App::Office::Contacts::Import::vCards::Util::Config;
use App::Office::Contacts::Import::vCards::View;

use Log::Dispatch;

our $VERSION = '1.02';

# -----------------------------------------------

sub cgiapp_prerun
{
	my($self) = @_;

	# Outputs nothing, since logger not yet set up.
	#$self -> log(debug => 'Entered cgiapp_prerun');

	$self -> param(config => App::Office::Contacts::Import::vCards::Util::Config -> new -> config);

	# Set up half the logger, but don't use it until the dbh is available.

	$self -> param(logger => Log::Dispatch -> new);

	# Set up the database.

	$self -> param(db => App::Office::Contacts::Database -> new
	(
		config => $self -> param('config'),
		logger => $self -> param('logger'),
	) );

	# Set up the things shared by:
	# o App::Office::Contacts
	# o App::Office::Contacts::Donations
	# o App::Office::Contacts::Import::vCards

	$self -> global_prerun;

	# Set up the view.

	$self -> param(view => App::Office::Contacts::Import::vCards::View -> new
	(
		config    => $self -> param('config'),
		db        => $self -> param('db'),
		logger    => $self -> param('logger'),
		session   => $self -> param('session'),
		tmpl_path => $self -> tmpl_path,
	) );

} # End of cgiapp_prerun.

# -----------------------------------------------

1;