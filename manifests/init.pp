class cagefs {

  include cagefs::files
  create_resources("cagefs::package",hiera("cagefs_packages",""))

}
