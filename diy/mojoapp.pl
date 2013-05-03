#!/usr/bin/perl -w

use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
	my $self = shift;
	$self->render(text => "Mojolicious - OK");
};





# Start the Mojolicious command system
app->start();