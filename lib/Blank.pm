package Blank;

use Mojo::Base 'Mojolicious', -signatures;

use utf8;
use open qw(:std :encoding(UTF-8));

use Mojolicious::Plugin::Config;
use Mojo::Pg;
use Mojo::JWT;
use Mail::RFC822::Address;

use Blank::Model::Emailer;
use Blank::Model::Accounts;

our $VERSION = '0.91';


=head1 NAME

Blank - a skeleton Mojolicious website with some essential features

=head1 SYNOPSIS

# how to deploy it and start using it

=head1 DESCRIPTION

Blank is a blank skeleton Mojolicious website with common features such as a configuration file,
database migrations, multi-language, an account system (with safe password storage, register form,
email confirmation, access recovery by email, a profile page), email sending and a test suite.

The website is deployable with HTTPS and dev/test/prod environments.

=head1 FEATURES

=head2 CONFIGURATION FILE

The configuration file is blank.conf. You can have different configuration files for each environment
(development, testing, production) and make blank.conf a symbolic link to one of these files.
Tests use the TEST-blank.conf configuration file (to have a dedicated test database).

=head2 EMAIL SENDING

Blank email sending is done via a third party email sending provider. The code for sending emails
should probably be adapted to your email provider.

=head2 DATABASE

Mojo::Pg (and so Postgresql) is used for the database access. The migrations are in the directory
migrations, using a hierarchical structure. A simple eval is used to catch Exceptions from query().

=head2 USER ACCOUNTS

There are two tables, one for users (with a uuid, a name, an email address and a password) and one
for accounts (with an account name and a color). For now, one user has only one account but that may
change. The user may have a name, an email or both.

=head2 PASSWORD

Password secure storage is done using Argon2id. The parameters have been chosen using the utility
argon2calibrate provided by Crypt::Argon2 (see SECURITY file for more information).

=head2 INTERNATIONALIZATION

All texts to be read by end users is between l('') using Mojolicious::Plugin::I18N and
Blank::I18N::* for translation files.

=head2 EMAIL MANAGEMENT

Email texts are stored in templates. The text in the template can be automatically translated the
same way that web pages are.

=head2 EMAIL ADDRESS VERIFICATION

Mojo::JWT is used to create a JWT to let the user verify his email address. The secret comes from
the configuration file.

=head2 PUBLIC PROFILE PAGE

WARNING: this feature may expose the name of your users, if you don't want that feature at all, you
must at least remove the corresponding routes under /profiles/.

In order to demonstrate differentiated access, each user has a public profile page that shows his
name (unless the name corresponds to the user email address) and a description text provided by the
user. This page can be accessed by anyone.

=head2 SUBSCRIPTION

As a foundation for user subscription management, there is a database table for payments made by
users in favor of the website and a subscription status field for users.

=head2 ENCODING

UTF-8 is considered the default encoding.

=head2 TIME ZONE

UTC is set as the time zone in the first database migration.

=head2 FORM VALIDATION

Forms are validated using Mojolicious::Validator (including its CSRF protection), with a custom
helper for redirection and showing specific validation errors to the end user.

=head2 WHAT IS NOT IN THIS WEBSITE

No job queue (such as Minion) has been integrated yet.

No database backup facility is offered yet.

No ORM is used. The Model uses SQL queries directly.

There is no admin account (admin tasks can be done directly with a Mojo eval or in the database).

There is no frontend framework.

=head1 HOW TO USE

=over 4

=item *

Clone the project. You may want to follow the original Blank project for updates.

=item *

Rename all Blank/blank to your new project's name (including 'blanc' in the French translation).

=item *

Create a database with the new name and run the migrations (for the account management tables etc).

=item *

Adapt the Email sending module if necessary (and the configuration file).

=item *

Copy a configuration file from the blank.conf.sample (you can remove this sample file). Don't forget
to generate new secrets.

=back

=cut


# a general error message for a form with an absent/invalid CSRF token
my $csrf_failure_error_msg = 'You can not do that.';


sub make_pg_connec_string_from_conf {
  my $config = shift;
  return
      'postgresql://'
    . ($config->{postgresql_user}     || '') . ':'
    . ($config->{postgresql_password} || '') . '@'
    . ($config->{postgresql_host}     || '') . '/'
    . ($config->{postgresql_dbname}   || '')
    . ';port='
    . ($config->{postgresql_port} || '');
}

sub startup {
  my ($self) = shift;

  # more detailed form validation
  $self->validator->add_check(min => sub ($v, $name, $value, $min) { length($value) < $min });
  $self->validator->add_check(max => sub ($v, $name, $value, $max) { length($value) > $max });
  $self->validator->add_check(
    diff_than => sub ($v, $name, $value, $than) {
      return 1 unless defined(my $other = $v->input->{$than});
      return $value eq $other;
    }
  );

  $self->helper(validate_email => sub ($c, $email) { Mail::RFC822::Address::valid($email) });
  $self->validator->add_check(
    email_syntax => sub ($v, $name, $value) {
      return !$self->validate_email($value);
    }
  );


  $self->helper(
    reports => sub ($c, $v) {
      return {map { $_ => $v->error($_) } @{$v->failed()}};
    }
  );

  # returns true if validation errors, creates stash values for general error message and previous
  # values to carry after a redirect
  # $prev_names is a reference to an array with the param values to report to the form again
  # $operation is a unique name to create an error message and a variable with the errors
  $self->helper(
    validation_failed => sub ($c, $v, $operation, @prev_names) {
      return 0 unless $v->has_error();

      if ($v->has_error('csrf_token')) {
        $c->flash(error => $csrf_failure_error_msg);
      }
      else {
        my $operation_var = (lc($operation) =~ s/ /_/gr);
        my %prevs         = ();
        foreach (@prev_names) { $prevs{"prev_${operation_var}_$_"} = $c->param($_) || '' }

        # save validation errors and report them through the redirect
        my $reports         = {map { $_ => $v->error($_) } @{$v->failed()}};
        my $errors_variable = "${operation_var}_errors";
        $c->flash(error => "$operation failed.", $errors_variable => $reports, %prevs);
      }
      return 1;
    }
  );

  # Configuration file
  my $config = $self->plugin('Config');

  $self->secrets($self->app->config->{app_secrets});

  # keep the default session expiration duration

  # remove the default Mojolicious favicon
  delete $self->static->extra->{'favicon.ico'};

  # Internationalization
  $self->plugin('I18N', default => 'en', support_url_langs => [qw(en fr)]);

  # database
  my $pg_conec_str = make_pg_connec_string_from_conf($config);
  $self->helper(pg => sub { state $pg = Mojo::Pg->new($pg_conec_str) });
  $self->pg->migrations->from_dir('migrations');
  $self->app->log->error('Mojo::Pg not started') unless $self->pg;
  $self->app->log->debug($self->pg->db->query('SELECT VERSION() AS version')->hash->{version});

  # account management
  my %account_params = map { $_ => $config->{$_} } Blank::Model::Accounts::argon2_params();
  $self->helper(
    accounts => sub {
      state $accounts = Blank::Model::Accounts->new(pg => $self->pg, %account_params);
    }
  );

  # NOTE this check needs the account
  $self->validator->add_check(
    pwd_syntax => sub ($v, $name, $value) {
      return !$self->accounts->validate_password($value);
    }
  );

  # email sending
  my %emailer_params = map { $_ => $config->{"email_$_"} } qw(api_host api_header api_token from);
  $self->helper(
    emailer => sub {
      state $emailer = Blank::Model::Emailer->new(%emailer_params);
    }
  );

  # JWT for email verification
  my $jwt_obj = Mojo::JWT->new(secret => $config->{jwt_email_verify_secret});
  if ($jwt_obj) {

    $self->helper(jwt => sub { state $jwt = $jwt_obj });

  }
  else {
    $self->log->error("Mojo::JWT new failed.");
  }


  #
  # Routing
  #

  my $r = $self->routes;
  $r->any('/')->to('blank#index')->name('index');

  ## User Account
  # registration
  $r->post('/register')->to('account#register')->name('register');
  $r->get('/verify-email')->to('account#verify_email')->name('verify_email');

  # log in and out
  $r->post('/login')->to('account#login')->name('login');
  $r->get('/logout')->to('account#logout')->name('logout');

  # recover password
  $r->get('/recover-password')->to('account#recover_password_form')->name('recover_password_form');
  $r->post('/recover-password')->to('account#recover_password')->name('recover_password');

  # with the JWT link from the password reset email
  $r->get('/reset-password')->to('account#reset_password_form')->name('reset_password_form');
  $r->post('/reset-password')->to('account#reset_password')->name('reset_password');

  # public profile
  $r->get('/profiles/:user-id')->to('account#get_profile')->name('get_profile');

  ## logged in routes
  my $logged_in = $r->under('/')->to('account#logged_in');

  # dashboard
  $logged_in->any(['GET', 'POST'] => '/dashboard')->to('blank#dashboard');

  ## User account
  my $account = $logged_in->any('/account')->to(controller => 'account');
  $account->any([qw(GET POST)] => '/')->to(action => 'account')->name('account');

  # routes without account id for the default account
  $account->post('/name')->to(action => 'modify_user_name')->name('modify_user_name');

  # ask to change the user email, it does not immediately change but it sends a confirmation email
  $account->post('/email')->to(action => 'ask_email_change')->name('ask_email_change');
  $account->post('/password')->to(action => 'modify_user_password')->name('modify_user_password');

  # public profiles
  $logged_in->post('/profiles')->to('account#modify_profile')->name('modify_profile');
}

1;
