class java {
    package { "default-jre": ensure => installed }
}

class jdk {
    package { "default-jdk": ensure => installed }
# The JUnit version results in problems 
# http://stackoverflow.com/questions/1171264/ant-junit-noclassdeffounderror
#    package { "junit4": ensure => installed }
    package { "junit4": ensure => absent }
    package { "libhamcrest-java": ensure => absent }
    package { "ant": ensure => installed }
}


