use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

use lib 'lib';
use Blank::Model::Emailer;

my $emailer = Blank::Model::Emailer->new();

my $t = Test::Mojo->new('Blank');
ok($t->app->emailer,       'Emailer object exists');
ok($t->app->emailer->ping, 'ping to the Email API');

done_testing();
