# builddep.pp

define apt::builddep() {
  include apt::update

  Class['apt'] -> Apt::Builddep[$name]

  exec { "apt-builddep-${name}":
    command => "/usr/bin/apt-get -y --force-yes build-dep ${name}",
    notify  => Exec['apt_update'],
  }

  # Need anchor to provide containment for dependencies.
  anchor { "apt::builddep::${name}":
    require => Class['apt::update'],
  }
}
