require_relative 'lib/toy_simulator'

unless input_file = ARGV[0]
  help = %q(
Usage: ruby simulator.rb input_file
  input_file: A path of a text file that contains commands for Toy Robot, one command per line.
  Valid commands: PLACE X,Y,F
                  MOVE
                  LEFT
                  RIGHT
                  REPORT
 )
  print help
  exit
end

VALID_COMMANDS = %w(PLACE MOVE LEFT RIGHT REPORT).freeze
commands = []

begin
  File.foreach(input_file) do |line|
    cmd, args = line.strip.split(' ')
    next unless VALID_COMMANDS.include?(cmd)

    commands << {
      cmd: cmd.downcase.to_sym,
      args: args.to_s.split(',')
    }
  end
rescue Errno::ENOENT => e
  puts "Input file not found: #{input_file}"
  exit
rescue => e
  puts e.message
  exit
end

robot = Robot.new(Table.new)

commands.each do |command|
  if command[:cmd] == :place
    args = command[:args]
    robot.place(Position.new(args[0], args[1]), args[2])
    next
  end

  result = robot.send(command[:cmd])
  puts "Output: #{result}" if command[:cmd] == :report && result
end
