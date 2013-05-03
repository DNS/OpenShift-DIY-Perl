# shebang not needed !

use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
	my $self = shift;
	$self->render(text => "Mojolicious - OK <br> \nPerl Version - $]");
};





# Start the Mojolicious command system
app->start();