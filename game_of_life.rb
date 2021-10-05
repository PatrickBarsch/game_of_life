# Game of life

# Input:
def get_user_input
  puts "How big do you want your grid (square)?"
  grid_size = gets.chomp.to_i
  puts "How long do you want to play ideally?"
  generations = gets.chomp.to_i
  return grid_size, generations
end
# - load a population from a file

# let's mock this for now

def setup_grid_with_edge(grid_size)
  input = Array.new(grid_size) { Array.new(grid_size,rand(2)) }
  grid = Array.new(grid_size + 2) { Array.new(grid_size + 2, 0) }
  grid[1..grid_size].each_with_index do |row, id| 
    row[1..grid_size] = input[id]
  end
  grid
end

# Run the game:
# - calculate the next generation for the defined number of iterations
def calculate_next_generation(grid, grid_size, position)
  # calculate the value for all the neighbours
  row = (position / grid_size) + 1
  column = (position % grid_size) + 1
  cell = grid[row][column]
  neighbours = grid[row-1..row+1].map do |neighbour_row|
    neighbour_row[column-1..column+1].sum
  end
  number_of_neighbours = neighbours.sum - cell
  # check if we reached the end of the grid
  unless position == 0
      # --> if not, call this function recursively
    calculate_next_generation(grid, grid_size, position-1)
  end
  # switch the cell based on its own and its neighbours status
  if number_of_neighbours == 3
    grid[row][column] = 1
  elsif number_of_neighbours != 2
    grid[row][column] = 0 
  end
  return grid
end

def print_grid (grid, grid_size)
  print_what = {0 => "-", 1 => "x"}
  grid[1..grid_size].each do |row|
    row_translated = row.map{ |element| print_what[element]}
    print "#{row_translated.join("")} \n"
  end
end

grid_size, generations = get_user_input
end_position = grid_size**2 - 1
grid = setup_grid_with_edge(grid_size)
generations.times do
  grid = calculate_next_generation(grid, grid_size, end_position)
  print_grid(grid, grid_size)
  print "\n"
end

# Output:
# - print the grid to stdout
# - wait for the pre-defined time