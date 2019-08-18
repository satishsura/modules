class wordpress::php inherits wordpress {

$packagenames = ['php', 'libapache2-mod-php', 'php-mcrypt', 'php-mysql']

$packagenames.each |String $package| {
package {"${package}":
    ensure => latest,
  }
}
}
