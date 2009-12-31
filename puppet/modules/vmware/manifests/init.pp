class vmwaretools {
  # Detect that we're a vmware guest
  case $productname {
    'VMware Virtual Platform': {
      # install vmware tools
      package { "open-vm-tools": ensure => present }
      package { "open-vm-toolbox": ensure => present }
    }
  }
}

