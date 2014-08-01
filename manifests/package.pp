define cagefs::package($ensure = "present", $version = "latest") {
  include cagefs::forceupdate

  package {"${name}":
    ensure => $version
  }

  cagefs_rpm{"${name}":
    ensure  => $ensure,
    require => Package["${name}"],
    notify => Exec["cagefsctl_forceupdate"]
  }
}
