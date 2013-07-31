require 'generators/webhookr/init_generator'

module Webhookr
  module Mandrill
    module Generators
      class InitGenerator < Webhookr::Generators::InitGenerator

        desc "This generator updates the named initializer with Mandrill options"
        def init
          super
          append_to_file "config/initializers/#{file_name}.rb" do
            plugin_initializer_text
          end
        end

        def plugin_initializer_text
          <<-EOS
Webhookr::Mandrill::Adapter.config.security_token = '#{generate_security_token}'
# Uncomment the next line to include your custom Mandrill handler
# Webhookr::Mandrill::Adapter.config.callback = your_custom_class
# Uncomment the next line to use authentication with Mandrill key
# Webhookr::Mandrill::Adapter.config.secret_token = 'your_secret_token'
          EOS
        end
      end
    end
  end
end
