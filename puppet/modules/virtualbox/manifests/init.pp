class virtualboxtools {
  # Detect that we're a VirtualBox guest
  case $productname {
    'VirtualBox': {
      # install VirtualBox tools
      package { "virtualbox-ose-guest-x11": ensure => present }
    }
  }
}

