require "thor"
require "active_support/inflector"

module G2
  class Cli < Thor
    include Thor::Actions

    source_root File.dirname(__FILE__)

    desc "new [app]", "create a new grape goliath application"
    def new app_root
      say "create a new grape goliath application named #{app_root}", :green
      @app_name = app_root.capitalize

      # create folder structure
      %w{app app/apis app/helpers app/models config config/environments db lib script log tmp spec spec/apis spec/models spec/helpers}.each do |item|
        empty_directory app_root + "/" + item
      end

      # create basic files
      {
        application: "config/application.rb",
        database: "config/database.yml",
        spec_helper: "spec/spec_helper.rb",
        gemfile: "Gemfile",
        guardfile: "Guardfile",
        rakefile: "Rakefile",
        rspec_config: ".rspec",
        server: "script/server.rb"
      }.each do |k, v|
        template("templates/#{k}.erb", "#{app_root}/#{v}")
      end

      inside app_root do
        run "bundle install"
      end
    end

    desc "s [options]", "start goliath server"
    method_option :port, :aliases => "-p", :desc => "server port"
    method_option :environment, :aliases => "-e", :desc => "server environment"
    method_option :pid, :aliases => "-P", :desc => "server pid path"
    method_option :log, :aliases => "-l", :desc => "server log path"
    method_option :daemon, :aliases => "-d", :desc => "run server as daemon"
    def s
      command = "ruby script/server.rb -p #{options[:port] || 3030} -e #{options[:environment] || 'development'}"

      if options[:log]
        command += " -l #{options[:log]}"
      else
        command += " -s"
      end
      if options[:pid]
        command += " -P #{options[:pid]}"
      end
      if options[:daemon]
        command += " -d"
      end

      exec command
    end

    desc "c", "start console"
    def c
      puts "starting console ..."
      require "pry"
      require "awesome_print"
      require "./script/server"
      Pry.start
      puts ""
    end

    desc "g", "generate files"
    def g g_type, g_name, *args
      @class_name = g_name.camelize
      case g_type
      when "model"
        generate_model g_name, args
      when "migration"
        generate_migration g_name, args
      when "api"
        @resources_symbol = g_name.to_sym
        generate_api g_name, args
      else
        puts "invalid generator type"
      end
    end

    private

    def generate_model name, *args
      template "templates/generator/model.erb", File.join('app/models', "#{name}.rb")
      template "templates/generator/migration.erb", File.join('db/migrate', "#{Time.now.to_i}_#{name}.rb")
    end

    def generate_migration name, *args
      template "templates/generator/migration.erb", File.join('db/migrate', "#{Time.now.to_i}_#{name}.rb")
    end

    def generate_api name, *args
      template "templates/generator/api.erb", File.join('app/apis', "#{name}_api.rb")
    end
  end
end
