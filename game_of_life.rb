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
print grid

# Run the game:
# - calculate the next generation for the defined number of iterations
def calculate_next_generation(grid, grid_size, generation)
  # calculate the value for all the neighbours
  # check if we reached the end of the grid
  # --> if not, call this function recursively
  # switch the cell based on its own and its neighbours status
end

# Output:
# - print the grid to stdout
# - wait for the pre-defined time