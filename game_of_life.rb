# Game of life

def get_user_input
  puts "How big do you want your grid (square)?"
  grid_size = gets.chomp.to_i
  puts "How long do you want to play ideally?"
  generations = gets.chomp.to_i
  return grid_size, generations
end
# - load a population from a file?

# Let's use and helping edge that is always 0, to avoid having to adjust
# the neighbour_calculation function
def setup_grid_with_edge(grid_size)
  input = Array.new(grid_size) { Array.new(grid_size,rand(2)) }
  grid = Array.new(grid_size + 2) { Array.new(grid_size + 2, 0) }
  grid[1..grid_size].each_with_index do |row, id| 
    row[1..grid_size] = input[id]
  end
  grid
end

def calculate_next_generation(grid, grid_size, position)
  row, column = determine_location(position, grid_size)
  number_of_neighbours = calculate_neighbours(grid, row, column)
  # Move further, if we did not reach the end of the grid.
  unless position == 0
    calculate_next_generation(grid, grid_size, position-1)
  end
  # Update the cell
  grid[row][column] = dead_or_alive(grid[row][column], number_of_neighbours)
  return grid
end

def determine_location(position, grid_size)
  row = (position / grid_size) + 1
  column = (position % grid_size) + 1
  return row, column
end

def calculate_neighbours(grid, row, column)
  neighbours = grid[row-1..row+1].map do |neighbour_row|
    neighbour_row[column-1..column+1].sum
  end
  number_of_neighbours = neighbours.sum - grid[row][column]
end

def dead_or_alive(cell, neighbours)
  if neighbours == 3
    return 1
  elsif neighbours != 2
    return 0
  else
    return cell 
  end
end

def print_grid (grid, grid_size)
  print_what = {0 => "-", 1 => "x"}
  grid[1..grid_size].each do |row|
    row_translated = row.map{ |element| print_what[element]}
    print "#{row_translated.join(" ")} \n"
  end
  print "\n"
  sleep(0.5)
end

def print_game_over(how_long)
  puts "Sorry, seems like they all died..."
  puts "But they made it #{how_long} generations."
  puts "Better luck next time."
end

# Run the game:
grid_size, generations = get_user_input
end_position = grid_size**2 - 1
grid = setup_grid_with_edge(grid_size)
generations.times do |time|
  grid = calculate_next_generation(grid, grid_size, end_position)
  if grid.map{|row| row.sum}.sum == 0
    print_game_over(time)
    break
  end
  print_grid(grid, grid_size)
end