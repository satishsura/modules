class wordpress::wordpress inherits wordpress {
file {"/tmp/latest.zip":
ensure => present,
mode => '0755',
source => "https://wordpress.org/latest.zip",
}


package {"unzip":
ensure => present,
}

exec {"/usr/bin/unzip latest.zip":
command => "/usr/bin/unzip /tmp/latest.zip -d /var/www/html",
onlyif => "/usr/bin/test -e /tmp/latest.zip",
}

file {"/var/www/html/wordpress/wp-config.php":
ensure => present,
mode => '0775',
owner => 'www-data',
group => 'www-data',
source => "https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/wp-config-sample.php",
}

file {"/var/www/html/wordpress":
ensure => directory,
recurse => true,
owner => 'www-data',
group => 'www-data',
mode => '0775',
}
}
