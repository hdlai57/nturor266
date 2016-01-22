require_relative "GameCenter.rb"

begin
	include GameTools

	puts case game_menu
	when 1
		game = RockPaperScissors.new
	when 2
		game = TicTacToe.new
	end

	game.play
end