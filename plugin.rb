# name: discourse-multiple-hostnames
# about: Allow multiple hostnames for your forum
# version: 1.0
# authors: xjtu-men
# url: https://github.com/xjtu-men/discourse-multiple-hostnames

after_initialize do

  class ::Middleware::EnforceHostname
    def call(env)
      hostname = env[Rack::Request::HTTP_X_FORWARDED_HOST].presence || env[Rack::HTTP_HOST]

      env[Rack::Request::HTTP_X_FORWARDED_HOST] = nil

      case hostname
      when 'xjtu.men', 'xjtu.love', 'xjtu.win', 'xjtu.live'
        env[Rack::HTTP_HOST] = hostname
      else
        env[Rack::HTTP_HOST] = 'xjtu.live'
      end

      @app.call(env)
    end
  end

end

