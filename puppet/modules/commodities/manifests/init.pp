class xclip {
    package { "xclip": ensure => installed }
    package { "gftp": ensure => installed }
    package { "nautilus-open-terminal": ensure => installed }
}

