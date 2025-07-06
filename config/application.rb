# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.after_initialize do
      ActiveSupport.on_load(:action_controller) { include Devise::Controllers::Helpers }
    end

    config.middleware.use Warden::Manager do |manager|
      manager.default_strategies(:user).unshift :jwt
      # 認証失敗時のJSONレスポンスを返すカスタム`failure_app`を設定することもできます
      manager.failure_app = lambda { |_env|
        [401, { 'Content-Tyape' => 'application/json' }, [{ error: 'Unauthorized' }.to_json]]
      }
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' # 本番では特定のドメインを指定
        resource '*',
                 headers: :any,
                 methods: %i[get post put patch delete options head],
                 expose: ['Authorization'] # JWT認証のためにAuthorizationヘッダーを公開
      end
    end

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.i18n.default_locale = :ja
    config.session_store :cookie_store, key: '_nova_lance_api_session'

    config.generators do |g|
      g.test_framework :rspec,
                       fixture: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
      g.template_engine :erb
      g.orm :active_record
      g.helper false
      g.assets false
      g.skip_routes true
      g.frozen_string_literal true
    end
  end
end

Faker::Config.locale = :ja
