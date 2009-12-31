class java {
    package { "default-jre": ensure => installed }
}

class jdk {
    package { "default-jdk": ensure => installed }
    package { "junit4": ensure => installed }
    package { "ant": ensure => installed }
}


