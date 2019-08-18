class wordpress::apache inherits wordpress {
package {"apache2":
ensure => present,
}

service {"apache2":
ensure => running,
}


exec {"restart apache2":
command => "/usr/sbin/service apache2 restart",
}
}
