package Blank::Controller::Blank;

use Mojo::Base 'Mojolicious::Controller';

sub log_context {
  my ($c, $method_name) = @_;
  return $c->app->log->context('[ControllerProfweb]', "[$method_name]");
}

sub index {
  my $c = shift;

  my $log = $c->log_context("index");
  $log->info("start.");
  $log->info("done.");

  # do your thing here
  return $c->render();
}

sub dashboard {
  my $c = shift;

  my $user_id = $c->session('id') || '';
  my $log     = $c->log_context("dashboard '$user_id'");
  $log->info("start.");


  return $c->render();
}

1;
