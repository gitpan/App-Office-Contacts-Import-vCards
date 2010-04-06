use Module::Build;

my($builder) = Module::Build -> new
(
 module_name    => 'App::Office::Contacts::Import::vCards',
 license        => 'artistic',
 dist_abstract  => 'Import vCards for use by App::Office::Contacts',
 dist_author    => 'Ron Savage <ron@savage.net.au>',
 build_requires =>
 {
	Test::Simple => 0.94,
	Test::Pod    => 1.41,
 },
 requires =>
 {
	App::Office::Contacts   => 1.06,
	Moose                   => 0.98,
	namespace::autoclean    => 0.09,
	Text::DoubleMetaphone   => 0,
	Text::GenderFromName    => 0,
	Text::vFile::toXML      => 0, # For importing vCards.
	XML::Handler::YAWriter  => 0, # For xmlpretty.
	XML::SAX::Base          => 0,
	XML::SAX::ParserFactory => 0,
 },
);

$builder -> add_build_element('conf');
$builder -> create_build_script();

