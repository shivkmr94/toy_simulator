# Toy Robot Simulator
A simulation of a toy robot moving on a square tabletop.

## Dependencies
* Ruby 2.7.1

## Setup
```
git clone https://github.com/shivkmr94/toy_simulator.git
cd toy_simulator
bundle install
```

## Running
`ruby simulator.rb command.txt`

Inside `test_data_files` directory there are some test case files.

Example:
```
$ ruby simulator.rb test_data_files/test_case3.txt
Output: 3,3,NORTH
```
Note that at the end of each input file in `test_data_files` directory is the expected result. I did it in order to a easy understanding.

Really this "invalid commands" at the end of the input files are ignored by the simulator.

## Testing
`bundle exec rspec`
