class subversion {
    package { "subversion": ensure => installed }
}

class subversion-tools {
    package { "subversion-tools": ensure => installed }
    package { "libsvn-java": ensure => installed }
}

