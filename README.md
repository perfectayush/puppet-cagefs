# cagefs

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Reference](#reference)
6. [Limitations](#limitations)


## Overview

This module tries to manage the
[cagefs](http://docs.cloudlinux.com/index.html?cagefs.html) virtual
filesystem for users in [Cloudlinux](http://www.cloudlinux.com/).

## Module description
Managing rpms and files in cagefs can be troublesome when managing
large number of servers. This module helps in adding and removing
these resources in cagefs. Its especially useful for managing rpms
inside cagefs.

## Setup
This module does not manage installation of cloudlinux, and cagefs.
This is a prerequirement. It only manages the resources inside cagefs.
It works with both Cloudlinux 5/6.

If you are using hiera, you can efficiently manage the resource in
yaml file. Ofcourse, this requires hiera to be properly setup.

## Usage
To use the module, just include the cagefs module in the relevant node
definition.

```puppet
node "cloudlinuxserver" {
  include cagefs
}
```

Now you can install and add packages in cagefs by adding the cagefs_packages key
in the hiera yaml which specifies the required package.

```yaml
cagefs_packages:
  php: {}
  perl:
    ensure: absent
    version: "5.10.1"
  ruby:
    ensure: present
    version: "1.9.3"
```

else you can directly can install a package and add it to cagefs using
cagefs::package resource:

```puppet
cagefs::package { "php":
  ensure  => present,
  version => latest
}
```

## Reference
#### cagefs class ###
* This file includes the cagefs::files class and creates resources for
  cagefs packages using a hiera hierarchy

#### cagefs::package defined type ####

This resource installs the required rpm package and add/remove it
to/from cagefs using cagefs_rpm custom type and finally force updates
cagefs.

It has two parameters:

* ensure:  specifies whether or not to include this rpm
* version: specifies the version of the rpm to be installed

#### cagefs_rpm custom type ####
cagefs::package behind the scenes uses package resource and custom
defined cagefs_rpm type. You can also use cagefs_rpmtype directly as
follows:

```puppet
cagefs_rpm {"php":
  ensure => present,
}
```

Whether an rpm is present or absent in cagefs,is a state and this is
managed via cagefs_rpm type. It uses cagefsctl utility to accomplish
this task.

#### cagefs::forceupdate class ####
This includes an exec which runs `cagefsctl --forceupdate` only when
any file or package is updated in cagefs.

`cagefs::files` class and `cagefs::package` resource notify this exec
if any state change happens.

#### cagefs::files class ####
This files contains all the important files whose update require
cagefs to be updated. It includes the cagefs forceupdate exec which is
triggered only if any of the package or file is updated. You can add
more files in this class if they need to updated in cagefs.

For more refrence to how cagefs/cloudlinux work refer
[Cloudlinux Documentation](#http://docs.cloudlinux.com/index.html)

## Limitations
* This works only with Cloudlinux 5/6.
* It doesn't manage any installation of cagefs. Only a few resources
  within cagefs.
