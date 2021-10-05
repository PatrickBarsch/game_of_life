# Game of life

# Input:
# - get some input from the user through the terminal (grid size, number of iterations, time between iterations)
# - generate a random population
# - load a population from a file

# let's mock this for now

def setup_grid_with_edge(grid_size, input)
  grid = Array.new(grid_size + 2) { Array.new(grid_size + 2, 0) }
  grid[1..grid_size].each_with_index do |row, id| 
    row[1..grid_size] = input[id]
  end
  grid
end

# Run the game:
# - calculate the next generation for the defined number of iterations
def calculate_next_generation(grid, grid_size, generation)
  # calculate the value for all the neighbours
  row = (generation / grid_size) + 1
  column = (generation % grid_size) + 1
  cell = grid[row][column]
  neighbours = grid[row-1..row+1].map do |neighbour_row|
    neighbour_row[column-1..column+1].sum
  end
  number_of_neighbours = neighbours.sum - cell
  # check if we reached the end of the grid
  unless generation == grid_size**2 - 1
      # --> if not, call this function recursively
    calculate_next_generation(grid, grid_size, generation+1)
  end
  # switch the cell based on its own and its neighbours status
  if number_of_neighbours == 3
    grid[row][column] = 1
  elsif number_of_neighbours != 2
    grid[row][column] = 0 
  end
  return grid
end

grid_size = 3
generation = 1
input = [[0,1,0], [1,1,1], [0,1,0]]
grid = setup_grid_with_edge(grid_size, input)
grid = calculate_next_generation(grid, grid_size, 0)
print grid

# Output:
# - print the grid to stdout
# - wait for the pre-defined time