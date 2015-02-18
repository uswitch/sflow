class Nginx < FPM::Cookery::Recipe
    homepage 'https://github.com/NETWAYS/sflow'
    name     'sflow'
    version  '1.0'
    source "https://github.com/uswitch/sflow.git", with: 'git', tag: 'production'
    revision `git rev-list HEAD --count`.chomp 
    maintainer 'itoperations@uswitch.com'
    description 'sflow to json forwarder for Logstash'

    depends   'ruby'

    build_depends 'ruby-dev'

    config_files  '/opt/sflow/etc/config.yaml'

    post_install  'nginx.postinst'
    pre_uninstall 'nginx-extras.prerm'
    pre_install   'nginx-common.preinst'

  def build
    safesystem 'bundle install --without uswitch'
  end

  def install
    safesystem "cp -r #{builddir}/sflow #{(opt/'sflow')}"
    (opt/'sflow/etc').install(workdir('debian/config.yaml'))
    (etc/'init').install_p(workdir('debian/sflow.upstart', 'sflow.conf'))
  end
end


module FPM
  module Cookery
    module Package
      # See the following URLs for package naming conventions.
      # 
      #  * https://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
      #  * https://fedoraproject.org/wiki/Packaging:NamingGuidelines?rd=Packaging/NamingGuidelines#Package_Versioning
      class Version
        REVISION_DELIMITER = {
          :default => '-'
        }
        VENDOR_DELIMITER = {
          :deb => '%2B',
          :rpm => '.',
          :default => '-'
        }
      end
    end
  end
end


