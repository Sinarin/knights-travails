require_relative 'chess_board.rb'

Vector = Struct.new(:x, :y)

class Knight
  #all the possible directions(vectors) a knight can move
  @@change_in_position = [Vector.new(2, 1), Vector.new(2, -1), Vector.new(-2, 1), Vector.new(-2, -1), Vector.new(1, 2), Vector.new(1, -2), Vector.new(-1, 2), Vector.new(-1, -2)]
  def initialize(board)
    #possible changes in position
    @chess_board = board.chess_board
    make_knight_graph(@chess_board)
  end

  #create the edges between vertices
  def make_knight_graph(chess_board)
    @chess_board.each do |key, square|
      valid_move(@@change_in_position, square)
    end
  end
  
  #checks if a move would go outside the boundries if not then creates the edge but adding to a list of adjacent nodes
  def valid_move(vectors, square)
    vectors.each do |vector|
      x_new = vector.x + square.value[0]
      y_new = vector.y + square.value[1]
      if x_new.between?(0, 7) && y_new.between?(0, 7)
      square.add_edge(@chess_board[[x_new, y_new]])
      end
    end
  end

  def shortest_path(start, end_square, path = [end_square], queue = [], count = 0)
    #for each adjacent node (move you can do) go there
    @chess_board[start].adjacent_nodes.each do |move|
      #base case, if you get to the end square end recursive loop
      if move.value == end_square
        queue = []
        path.unshift(start)
        return path
      end
      #for each move push it in to the queue
      queue << move.value
    end
    found = shortest_path(queue.shift, end_square, path, queue, count) if queue.length > 0
    #this part of the code only activates if the node/square has been found.
    #for this recusive call push start of the move if the starting square can get to the position previously recorded(adjacent node)
    path.unshift(start) if @chess_board[start].adjacent_nodes.any? { |node| node == @chess_board[path[0]]}
    path
  end

end