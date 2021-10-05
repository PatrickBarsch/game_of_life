# Game of life

# Input:
# - get some input from the user through the terminal (grid size, number of iterations, time between iterations)
# - generate a random population
# - load a population from a file

# let's mock this for now
grid_size = 3
generations = 1
input = [[0,1,0],[1,1,1],[0,1,0]]

def setup_grid_with_edge(grid_size, input)
  grid = Array.new(grid_size + 2) { Array.new(grid_size + 2, 0) }
  grid[1..grid_size].each_with_index do |row, id| 
    row[1..grid_size] = input[id]
  end
  grid
end

grid = setup_grid_with_edge(grid_size, input)

# Run the game:
# - calculate the next generation for the defined number of iterations
def calculate_next_generation(grid, grid_size, generation)
  # calculate the value for all the neighbours
  row = (generation / grid_size) + 1
  column = (generation % grid_size) + 1
  neighbours = grid[row-1..row+1].map do |neighbour_row|
    neighbour_row[column-1..column+1].sum
  end
  number_of_neighbours = neighbours.sum - grid[row][column]
  puts number_of_neighbours
  # check if we reached the end of the grid
  # --> if not, call this function recursively
  # switch the cell based on its own and its neighbours status
end

calculate_next_generation(grid, grid_size, 0)

# Output:
# - print the grid to stdout
# - wait for the pre-defined time