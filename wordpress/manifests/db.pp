class wordpress::db inherits wordpress {
class { '::mysql::server':
  root_password           => 'rootpassword',
}

mysql::db { 'wordpress':
  user     => 'wordpressuser',
  password => 'password',
  host     => 'localhost',
  grant    => ['ALL'],
}
}
