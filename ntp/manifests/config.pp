class ntp::config inherits ntp {
file { "/etc/ntp.conf" : 
                        source => "puppet:///modules/ntp/ntp.conf"
}
}
