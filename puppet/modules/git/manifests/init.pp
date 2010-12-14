class git {
    package { "git-gui": ensure => installed }
    package { "gitg": ensure => installed }
    package { "git-svn": ensure => installed }
}

