class ntptemplate::service inherits ntptemplate{
service { "ntp" :
                   require => Package['ntp'],
                   ensure => running
}
}
