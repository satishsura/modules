class ntptemplate::install inherits ntptemplate {
package { 'ntp':

    ensure => installed,

 }
}
