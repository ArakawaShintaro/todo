require 'optparse'
require 'pry'

module Todo
  class Command
    module Options

      def self.parse!(argv)
        command_parser = OptionParser.new do |opt|
          opt.on_head('-v', '--version', 'Show program version') do |v|
            opt.version = Todo::VERSION
            puts opt.version
            exit
          end
        end

        command_parser.parse!(argv)
      end

    end
  end
end
