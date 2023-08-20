# name: discourse-multiple-hostnames
# about: Allow multiple hostnames for your forum
# version: 1.0
# authors: xjtu-men
# url: https://github.com/xjtu-men/discourse-multiple-hostnames

after_initialize do

  class ::Middleware::EnforceHostname
    def call(env)
      cur_hostname = env[Rack::Request::HTTP_X_FORWARDED_HOST].presence || env[Rack::HTTP_HOST]
      env[Rack::Request::HTTP_X_FORWARDED_HOST] = nil

      use_hostname = SiteSetting.canonical_hostname
      SiteSetting.extra_hostnames.split('|').each do |name|
        if name == cur_hostname
          use_hostname = name
          break
        end
      end
      env[Rack::HTTP_HOST] = use_hostname

      @app.call(env)
    end
  end

end

