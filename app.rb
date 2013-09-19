require 'bundler'
Bundler.require :default, :app, :assets

class App < Sinatra::Base

  #Usually, you'll need to change only the following settings
  set :app_name,      'jQuEdit'
  set :app_version,   '0.1.0'
  set :assets_prefix, 'assets'
  set :main_js,       'main.js'
  set :main_css,      'main.css'
  set :js_path,       'app/js'
  set :css_path,      'app/css'
  set :res_path,      'app/resources'
  set :index,           :index

  ##################################################################
  set :assets, Sprockets::Environment.new(root)
  set :digest_assets, false

  #Disable protection to get work reverse_proxy
  disable :protection

  configure do
    # Setup Sprockets
    puts 'Configuring'
    assets.append_path js_path
    assets.append_path css_path
    assets.append_path res_path

    if  development?
      register Sinatra::Reloader
      #set :main_js,"main?r=#{rand}"
      #set :main_css,"main?r=#{rand}"
    else
      Bundler.require :compressors
      assets.js_compressor = Uglifier.new
      options = Sass::Engine::DEFAULT_OPTIONS.merge(:style => :compressed)
      Sass::Engine.send(:remove_const, :DEFAULT_OPTIONS)
      Sass::Engine.const_set(:DEFAULT_OPTIONS, options)
      set :api_url,       'http://html5.fdvs.com.ar/geopfizer/API'
      #set :api_url,       'http://localhost/API'

    end
    #Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder

      # Force to debug mode in development mode
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      config.debug      = development?
    end
  end

###############################
  helpers do
    include Sprockets::Helpers
    def render_markdown(file_name)
      file_path = File.join(settings.root , file_name)
      return [404, "#{file_name}: File not found"] unless File.file?(file_path)
      markdown_text = File.new(file_path).read
      markdown markdown_text
    end

    def app_name
      settings.app_name
    end

    def app_version
      settings.app_version
    end

    def changelog
      render_markdown 'changelog.md'
    end

    def index
      erb settings.index
    end

    def main_js
      settings.main_js
    end

    def main_css
      settings.main_css
    end

    def get_assets
      assets_list = []
      [main_js,main_css].each do |asset|
        assets = settings.assets.find_asset(asset)
        if settings.development?
          assets_list.concat assets.to_a
        else
          assets_list.push assets
        end
      end
      assets_list
    end

  end
  ##############################################
  get '/' do
    index
  end

  get '/readme' do
    render_markdown 'README.md'
  end

  get '/changelog' do
    changelog
  end

end

