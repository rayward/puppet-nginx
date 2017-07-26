# Class to manage NGinx configs
define nginx::config(
  $ensure  = 'present',
  $source  = '',
  $content = '',
  $path    = "/etc/nginx/conf.d/${name}.conf",
) {
  validate_string($source, $content)

  if ($ensure != 'present' and $ensure != 'absent') {
    fail("Nginx::Config[${name}] ensure should be one of present/absent")
  }

  if ($content == '' and $source == '' and $ensure != 'absent') {
    fail("Nginx::Config[${name}] either source or content must be present")
  }
  elsif ($content != '' and $source != '') {
    fail("Nginx::Config[${name}] cannot specify both source and content")
  }

  include nginx

  File {
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  if ($content != '') {
    file { $path:
      content => $content,
    }
  }
  elsif ($ensure != 'absent') {
    file { $path:
      source => $source,
    }
  }
  else {
    file { $path : }
  }
}
