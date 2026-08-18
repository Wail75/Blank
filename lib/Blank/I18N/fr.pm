package Blank::I18N::fr;

use utf8;
use Mojo::Base 'Blank::I18N';
use V;

our %Lexicon = (
  'Blank website!'            => 'Site Web en Blanc',
  'Hello from Blank Website.' => "Bonjour, du site web en Blanc,",
  'The Blank Website team'    => "L'équipe du site web en Blanc",
  'Blank Website'             => "Site Web en Blanc",

  'You can not do that.'                                            => "Vous ne pouvez pas faire cela.",
  'This action can not be done for the moment. Please retry later.' =>
    "Cette action ne peut pas être faite pour le moment. Veuillez recommencer plus tard.",

  'index'   => 'accueil',
  'Index'   => 'Accueil',
  'Welcome' => 'Bienvenue',
  'Send'    => "Envoyer",

  'Log in'                     => 'Connexion',
  'Login'                      => 'Connexion',
  'Login successful.'          => 'Connexion réussie.',
  'You are logged in'          => 'Vous êtes connecté',
  'You are already logged in.' => 'Vous êtes déjà connecté',
  'Login failed.'              => "La connexion a échoué.",

  'Account'                                                       => 'Compte',
  'My Account'                                                    => 'Mon Compte',
  'User Account'                                                  => 'Compte Utilisateur',
  'Your user account'                                             => 'Votre compte utilisateur',
  'Dashboard'                                                     => 'Tableau de bord',
  'Connected:'                                                    => 'Connecté :',
  'logout'                                                        => 'déconnexion',
  'Logout'                                                        => 'Déconnexion',
  'You need to log in first.'                                     => "Vous devez d'abord vous connecter.",
  'You must give a user name and a password in order to connect.' =>
    "Vous devez donner un nom d'utilisateur et un mot de passe pour vous connecter.",
  'Wrong user name or password.'                  => "Mauvais nom d'utilisateur ou mot de passe.",
  'You are now logged out.'                       => "Vous êtes désormais déconnecté.",
  'Forgotten password? Click here to recover it.' => "Mot de passe oublié? Cliquez ici pour le récupérer.",
  'Enter your email address and, if it is recognized, you will receive a link that will allow you to reset your password.'
    => "Saisissez votre adresse email et, si elle est reconnue, vous recevrez un lien qui vous permettra de redéfinir votre mot de passe.",
  'Your email address:'             => "Votre adresse email :",
  'You must give an email address.' => "Vous devez donner une adresse email.",
  'If the email address is correct, you will receive an email to reset your password.' =>
    "Si l'adresse email est correcte, vous recevrez un email pour redéfinir votre mot de passe.",
  'The password reset link is incorrect.' => "Le lien pour redéfinir le mot de passe n'est pas correct.",
  'Reset Password'                        => "Redéfinir le mot de passe",
  'You are already logged in as'          => "Vous êtes déjà connecté",
  "You can register with a name only if you don't to give an email address." =>
    "Vous pouvez vous inscrire avec seulement un nom d'utilisateur si vous ne voulez pas donner d'adresse email.",
  "However, without an email address, you won't be able to recover your account if you forget your password." =>
    "Cependant, si vous ne donnez pas d'adresse email, nous ne serons pas capable de récupérer votre compte utilisateur si vous perdez votre mot de passe.",
  'If you give an email address but no name, you will be able to login with your email address.' =>
    "Si vous donnez une adresse email mais pas de nom, vous pourrez vous loguer avec votre adresse email.",

  'Account Management' => "Gestion du compte utilisateur",

  'Register'                                       => "Inscription",
  'Name'                                           => "Nom d'utilisateur",
  'Password'                                       => "Mot de passe",
  'Email'                                          => "Adresse email",
  'Repeat password'                                => "Répéter le mot de passe",
  'OR'                                             => "OU",
  'You must give a user name or an email or both.' =>
    "Vous devez donner un nom d'utilisateur ou une adresse mail ou les deux.",

  # NOTE watchout for the plural
  "Name must be at least $V::V_MIN_NAME character."    => "Le nom doit faire au moins $V::V_MIN_NAME caractère.",
  "Name must be at maximum $V::V_MAX_NAME characters." => "Le nom doit faire au maximum $V::V_MAX_NAME caractères.",
  "Email address must be at least $V::V_MIN_EMAIL characters." =>
    "L'adresse email doit faire au moins $V::V_MIN_EMAIL caractères.",
  "Email address must be at maximum $V::V_MAX_EMAIL characters." =>
    "L'adresse email doit faire au maximum $V::V_MAX_EMAIL caractères.",
  'The syntax of the email is not valid.'               => "La syntaxe de l'adresse email n'est pas correcte.",
  'You must give a password.'                           => 'Vous devez donner un mot de passe.',
  "Password must be at least $V::V_MIN_PWD characters." =>
    "Le mot de passe doit faire au moins $V::V_MIN_PWD caractères.",
  "Password must be at maximum $V::V_MAX_PWD characters." =>
    "Le mot de passe doit faire au maximum $V::V_MAX_PWD caractères.",
  'You must give a confirmation password.'               => "Vous devez donner un mot de passe de confirmation.",
  'Password and confirmation password must be the same.' =>
    "Le mot de passe et sa confirmation doivent être identiques.",
  'Registration failed.'                                                      => "L'inscription a échoué.",
  'You are now registered.'                                                   => "Vous êtes désormais inscrit.",
  'This name is not available.'                                               => "Ce nom n'est pas disponible.",
  "Password must be between $V::V_MIN_PWD and $V::V_MAX_PWD characters long." =>
    "Le mot de passe doit faire entre $V::V_MIN_PWD et $V::V_MAX_PWD caractères de long.",
  "Password must contain at least one letter and one digit." =>
    "Le mot de passe doit contenir au moins une lettre et un chiffre.",
  'Please respect the given password syntax.' => 'Veuillez respecter la syntaxe du mot de passe indiquée.',

  'You have not given an email address yet.' => "Vous n'avez pas donné d'adresse email.",
  'Consider giving one so that we can send you relevant messages and let you recover your account.' =>
    "Pensez à en donner une pour que nous puissions vous envoyer des messages importants et vous permettre de récupérer votre compte.",
  'Your email address is'                   => "Votre adresse email est",
  'Your email address is not verified yet.' => "Votre adresse email n'est pas encore confirmée.",
  'Check your email inbox and your spams.'  => "Vérifiez votre boîte email et vos spams.",
  'Once you have the verification email, click the link inside it to verify your email address.' =>
    "Une fois que vous avez reçu l'email de vérification, cliquez sur le lien qu'il contient pour confirmer votre adresse email.",
  'To send the verification email again, click on this link' =>
    "Pour recevoir à nouveau l'email de vérification, cliquez sur ce lien.",
  'The email verification link is incorrect.'          => "Le lien pour vérifier l'adresse email n'est pas correct.",
  'Your email address has been successfully verified.' => "Votre adresse email a bien été confirmée.",
  'Your email address could not be verified.'          => "Votre adresse email n'a pas pu être confirmée.",

  'You have not given a name for your account so we are calling you by your email address.' =>
    "Vous n'avez pas donné de nom pour votre compte, nous utilisons donc votre adresse email.",
  'You can change your account name here: '               => "Vous pouvez changer votre nom ici : ",
  'You can give a new account name here: '                => "Vous pouvez changer votre nom ici : ",
  'Save the new name'                                     => 'Enregistrer le nouveau nom',
  'You must give the current name.'                       => "Vous devez donner le nom actuel.",
  'You must give a new name.'                             => "Vous devez donner un nouveau nom.",
  'The new name must be different from the current name.' => "Le nouveau nom doit être différent du nom actuel.",
  'Your name has been changed.'                           => "Votre nom a été changé.",
  'Name change failed.'                                   => "Le changement de nom a échoué.",
  'You must give a new email.'                            => "Vous devez donner une nouvelle adresse email.",
  'Your email has been changed.'                          => "Votre adresse email a été changée.",
  'Ask email change failed.'                              => "La demande de changement d'adresse email a échoué.",
  'The syntax of the new email is not valid.' => "La syntaxe de la nouvelle adresse email n'est pas correcte.",

  'You can change your account email here: '                     => "Vous pouvez changer votre email ici : ",
  'You can give a new account email here: '                      => "Vous pouvez changer votre email ici : ",
  'Save the new email'                                           => 'Enregistrer la nouvelle adresse email',
  'We have sent you an email to confirm your new email address.' =>
    "Nous vous avons envoyé un email pour confirmer votre nouvelle adresse email.",
  'The new password must be different from the current password.' =>
    "Le nouveau mot de passe doit être différent du mot de passe actuel.",
  'You must give the current password.'                => "Vous devez donner le mot de passe actuel.",
  'You must repeat the new password for confirmation.' =>
    "Vous devez répéter le nouveau mot de passe pour confirmation.",
  'You must give a new password.'      => "Vous devez donner un nouveau mot de passe.",
  'The new password is invalid.'       => "Le nouveau mot de passe est invalide.",
  'Wrong password.'                    => "Mauvais mot de passe.",
  'Your password has been changed.'    => "Votre mot de passe a été changé.",
  'Password change failed.'            => "Le changement de mot de passe a échoué.",
  'You can give a new password here: ' => "Vous pouvez donner un nouveau mot de passe ici : ",
  'Repeat the new password here: '     => "Répétez le nouveau mot de passe ici : ",
  'Give your current password: '       => "Donnez votre mot de passe actuel : ",
  'Save the new password'              => "Enregistrer le nouveau mot de passe.",

  'Recover your password'   => "Récupérez votre mot de passe",
  'Recover password failed' => "La récupérationd du mot de passse a échoué.",

  'You have just asked to change your account email address.' =>
    "Vous venez de demander de changer l'adresse email de votre compte.",
  'Please confirm that you received this email by visiting this link' =>
    "Veuillez confirmer que vous avez bien reçu cet email en cliquant sur ce lien",
  'If you have not tried to change your email address, please tell us.' =>
    "Si vous n'avez pas essayé de changer votre adresse email, veuillez nous en avertir.",

  'You have just asked to reset your account password.' =>
    "Vous venez de demander de redéfinir le mot de passe de votre compte.",
  'To reset your account password, please visit this link' =>
    "Pour redéfinir le mot de passe de votre compte, veuillez cliquer sur ce lien",
  'If you have not tried to reset your password, please tell us.' =>
    "Si vous n'avez pas essayé de changer votre mot de passe, veuillez nous en avertir.",
  'Verify your email address' => "Vérifiez votre adresse email",
  'Reset your password'       => "Redéfinissez votre mot de passe",

  'Profile'                                              => "Profil",
  'Profile: '                                            => "Profil : ",
  'My Profile'                                           => "Mon Profil",
  'This is your Profile page.'                           => "Ceci est votre page de Profil.",
  'By default, it is private.'                           => "Par défaut, elle est privée.",
  'But if you add a description, it will become public.' =>
    "Mais si vous ajoutez une description, elle deviendra publique.",
  'Your profile has been changed.'                  => "Votre profil a été changé.",
  'Profile change failed.'                          => "Le changement du profil a échoué.",
  'This profile is not available.'                  => "Ce profil n'est pas disponible.",
  'You can view or change your profile here:'       => "Vous pouvez voir ou modifier votre profil ici :",
  'You must give a new description, even if empty.' =>
    "Vous devez donner une nouvelle description, même si celle-ci est vide.",
  'The new profile description is too long.' => "La nouvelle description de profil est trop longue.",

  'Replace this with your own content.' => 'Remplacez ce texte avec votre propre contenu.'

  # '' => "",

);

1;
