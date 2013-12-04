require "thor"

module G2
  class Cli < Thor
    include Thor::Actions

    source_root File.dirname(__FILE__)

    desc "new", "create a new grape goliath application"
    def new app_root
      say "create a new grape goliath application named #{app_root}", :green

      # create folder structure
      %w{app config config/environments db script spec}.each do |item|
        empty_directory app_root + "/" + item
      end

      # create basic files
      {
        application: "config/application.rb",
        spec_helper: "spec/spec_helper.rb",
        gemfile: "Gemfile",
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

    desc "server", "start goliath server"
    def server
    end

    desc "console", "start console"
    def console
    end

    desc "generator", "generate files"
    def generate
    end

  end
end
