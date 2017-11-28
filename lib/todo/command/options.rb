require 'optparse'
require 'pry'

module Todo
  class Command
    module Options

      def self.parse!(argv)
        options = {}

        sub_commands_parsers = create_sub_command_parsers(options)
        command_parser = create_command_parser

        begin
          command_parser.order!(argv)
          options[:command] = argv.shift
          sub_commands_parsers[options[:command]].parse!(argv)
        rescue OptionParser::MissingArgument, OptionParser::InvalidOption, ArgumentError => e
          abort e.message
        end
      end

      def self.create_sub_command_parsers(optsions)
         sub_commands_parsers = Hash.new do |k ,v|
          raise ArgumentError, "#{v} is not todo sub command"
        end

        sub_commands_parsers['create'] = OptionParser.new do |opt|
          opt.on('-n VAL', '--name=VAL', 'task name') { |v| options[:name] = v }
          opt.on('-c VAL', '--content=VAL', 'task content') { |v| options[:content] = v }
        end

        sub_commands_parsers['list'] = OptionParser.new do |opt|
          opt.on('-s VAL', '--status=VAL', 'list status') { |v| options[:status] = v }
        end

        sub_commands_parsers['create'] = OptionParser.new do |opt|
          opt.on('-n VAL', '--name=VAL', 'task name') { |v| options[:name] = v }
          opt.on('-c VAL', '--content=VAL', 'task content') { |v| options[:content] = v }
        end

        sub_commands_parsers
      end

      def self.create_command_parser
        OptionParser.new do |opt|
          opt.on_head('-v', '--version', 'Show program version') do |v|
            opt.version = Todo::VERSION
            puts opt.version
            exit
          end
        end
      end

    end
  end
end
