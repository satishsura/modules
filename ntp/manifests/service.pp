class ntp::service inherits ntp{
service { "ntp" :
                   require => Package['ntp'],
                   ensure => running
}
}
