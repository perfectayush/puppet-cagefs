class cagefs::forceupdate {
  exec {"cagefsctl_forceupdate":
    path  => "/usr/bin/:/usr/sbin/",
    command => "cagefsctl --force-update",
    refreshonly => true,
  }
}
