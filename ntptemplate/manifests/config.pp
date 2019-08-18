class ntptemplate::config inherits ntptemplate {

file {"/etc/ntp.conf":
ensure => file,
content => template("${module_name}/ntp.conf.erb"),
}

}
