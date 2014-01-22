default[:php][:directives]['default_charset']            = 'UTF-8'
default[:php][:directives]['mbstring.language']          = 'neutral'
default[:php][:directives]['mbstring.internal_encoding'] = 'UTF-8'
default[:php][:directives]['date.timezone']              = 'UTC'


case node['platform_family']
when 'rhel', 'fedora'
  if node['platform_version'].to_f < 6
    default['php']['packages'] = %w{ php53 php53-devel php53-cli php-pear }
  else
    default['php']['packages'] = %w{ php php-devel php-cli php-pear php-mbstring }
  end
when 'debian'
  default['php']['packages'] = %w{ php5-cgi php5 php5-dev php5-cli php-pear }
else
  default['php']['packages'] = %w{ php5-cgi php5 php5-dev php5-cli php-pear }
end
