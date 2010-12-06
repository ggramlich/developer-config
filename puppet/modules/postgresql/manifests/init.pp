class postgresql {
    package { "postgresql": ensure => installed }
    package { "pgadmin3": ensure => installed }
}

