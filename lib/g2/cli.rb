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
      template("templates/application.erb", "#{app_root}/config/application.rb")
      template("templates/spec_helper.erb", "#{app_root}/spec/spec_helper.rb")
      template("templates/Gemfile.erb", "#{app_root}/Gemfile")
      template("templates/Rakefile.erb", "#{app_root}/Rakefile")
      template("templates/rspec.erb", "#{app_root}/.rspec")
      template("templates/server.erb", "#{app_root}/script/server.rb")
    end
    
  end
end
