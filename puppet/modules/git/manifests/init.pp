class git {
    package { "git": ensure => installed }
    package { "git-gui": ensure => installed }
    package { "gitg": ensure => installed }
    package { "git-svn": ensure => installed }
    
    class gitserver {
        package { "gitolite": ensure => installed }
    }
}

