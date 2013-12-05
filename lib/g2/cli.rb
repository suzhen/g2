require "thor"

module G2
  class Cli < Thor
    include Thor::Actions

    source_root File.dirname(__FILE__)

    desc "new [app]", "create a new grape goliath application"
    def new app_root
      say "create a new grape goliath application named #{app_root}", :green
      @app_name = app_root.capitalize

      # create folder structure
      %w{app app/apis app/helpers app/models config config/environments db script log tmp tmp/pids spec}.each do |item|
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
      say "not implemented yet ):", :yellow
    end

    desc "g", "generate files"
    def g
      say "not implemented yet ):", :yellow
    end

  end
end
