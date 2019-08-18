class ntp::config inherits ntp {

file {"/etc/ntp.conf":
ensure => file,
content => template("${module_name}/ntp.conf.erb"),
}

}
