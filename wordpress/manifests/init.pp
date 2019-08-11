# Class: wordpress
# ===========================
#
# Full description of class wordpress here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'wordpress':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2019 Your name here, unless otherwise noted.
#
class wordpress {


exec {"apt update":
command => "/usr/bin/apt update",
}

package {"apache2":   
ensure => present, 
}
                  
service {"apache2":
ensure => running,
}

$packagenames = ['php', 'libapache2-mod-php', 'php-mcrypt', 'php-mysql']

$packagenames.each |String $package| {
package {"${package}":
    ensure => latest,
  }
}

#exec {"mysqladmin ":
#command => "mysqladmin -u root password rootpassword",
#}

class { '::mysql::server':
  root_password           => 'rootpassword',
}

#file {"/tmp/mysqlcommands":
#ensure => present,
#mode => '0755',
#source => "https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands",
#}

#exec {"download mysqlcmmds":
#command => "wget https://gitlab.com/roybhaskar9/devops/raw/master/coding/chef/chefwordpress/files/default/mysqlcommands",
#}

#exec {"copy sqlcmds in tmp":
#command => "cp mysqlcommands /tmp/mysqlcommands",
#}

#exec {"run sqlcmds in mysql":
#command => "/usr/bin/mysql -u root -prootpassword < /tmp/mysqlcommands",
#onlyif => "/usr/bin/test -e /tmp/mysqlcommands",
#unless => "/usr/bin/test -e /tmp/db_created",
#}

mysql::db { 'wordpress':
  user     => 'wordpressuser',
  password => 'password',
  host     => 'localhost',
  grant    => ['ALL'],
}

#file {"/tmp/db_created":
#ensure => present,
#mode => '0755',
#}

file {"/tmp/latest.zip":
ensure => present,
mode => '0755',
source => "https://wordpress.org/latest.zip",
}

#exec {"download latest.zip":
#command => "wget https://wordpress.org/latest.zip",
#}


#exec {"copy latest.zip in tmp":
#command => "cp latest.zip /tmp/latest.zip",
#}

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

exec {"restart apache2":
command => "/usr/sbin/service apache2 restart",
}
}
