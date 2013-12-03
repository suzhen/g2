require "thor"

module G2
  class Cli < Thor

    desc "new", "create a new grape goliath application"
    def new app
      say "create a new grape goliath application named #{app}", :green
    end
    
  end
end
