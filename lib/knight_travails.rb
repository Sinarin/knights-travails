require_relative 'chess_board.rb'
require_relative 'knight.rb'

board = ChessBoard.new()
knight = Knight.new(board)

p knight.shortest_path([0, 0], [1, 6])