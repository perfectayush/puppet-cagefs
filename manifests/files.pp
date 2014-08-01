class cagefs::files {
  include cagefs::forceupdate

  File{
    notify => Exec["cagefsctl_forceupdate"],
  }

  file { "/etc/cagefs/conf.d/php.cfg":
    mode => 644,
    source => "puppet:///modules/cagefs/php.cfg",
  }

}
