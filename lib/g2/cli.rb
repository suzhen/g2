require "thor"

module G2
  class Cli < Thor
    include Thor::Actions

    desc "new", "create a new grape goliath application"
    def new app_root
      say "create a new grape goliath application named #{app_root}", :green
      %w{app config db}.each do |item|
        empty_directory app_root + "/" + item
      end
    end
    
  end
end
