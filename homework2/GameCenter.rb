require 'pry'

# 遊戲會用到的一般工具
module GameTools
	def print_game_title (game_title) # 美化遊戲進入畫面
		system "clear"
		puts "|===============================================|" 
  	puts "|Welcome to #{game_title.ljust(36)}|"
  	puts "|===============================================|"
	end

	def play_again # 遊戲結束後 是否再玩
		begin
      puts "Play Again?: Y / N"
      continue = gets.chomp.upcase
	  end while !["Y", "N"].include?(continue)

	  continue == "Y" ? true : false 
	end

	def game_end
		puts "|===============================================|"
		puts "|Thanks for playing, bye!                       |"
		puts "|===============================================|"
	end

	def game_menu
		system "clear"
		puts "|===============================================|"
		puts "|Please select a game:                          |"
		puts "|  1) Rock Paper Scissors                       |"
		puts "|  2) Tic Tac Toe                               |"
		puts "|===============================================|\n"
		puts "Enter: "
		begin
			user_select = gets.chomp.to_i
		end while !(1..2).include?(user_select)
		user_select
	end
		
end
#============================================================================

# 建立Game類別
class Game
	include GameTools

	def initialize # 建構式
	end

	def play 
		begin
			play_game
		end while play_again
		game_end
	end

	protected
		def play_game # 請撰寫遊戲內容
		end

end
#============================================================================

# 遊戲類別: 剪刀石頭布
class RockPaperScissors < Game
	# 宣告 instance variable
	
	def initialize
		print_game_title("Rock Paper Scissors!!!") # Print welcome message as object initialized.
		@gestures = { "R" => "Rock", "P" => "Paper", "S" => "Scissors"}
	end

	protected
		def play_game			
			playing_RPS(get_user_gesture, get_computer_gesture)			
		end

	# --- Private methods for RockPaperScissors ---

	private # 玩家
		def get_user_gesture
			begin 
	      puts "please choose one of the following: R / P / S"
	      user_input = gets.chomp.upcase
    	end while !["R", "P", "S"].include?(user_input) 
    	@gestures[user_input]
		end

	private # 電腦
		def get_computer_gesture
			@gestures[["R", "P", "S"].shuffle!.last]
		end

	private # 遊戲內容
		def playing_RPS(user, computer)		
			if ((user == "Rock") && (computer == "Scissors")) ||
				 ((user == "Paper") && (computer == "Rock")) ||
				 ((user == "Scissors") && (computer == "Paper"))
				result = "you win"
			elsif ((user == "Rock") && (computer == "Paper")) || 
						((user == "Paper") && (computer == "Scissors")) ||
						((user == "Scissors") && (computer == "Rock"))
				result = "you lose"
			else 
				result = "it's a tie"
			end
				  
	    puts "You choose #{user}, the computer choose #{computer}, #{result}!"
		end

end
#============================================================================

# 遊戲類別: 圈圈叉叉
class TicTacToe < Game
	# 宣告 instance variable
	@counts
	@row_count
	@is_game_over
	@msg_result
	@tb

	def initialize
		print_game_title("Tic Tac Toe!!!") # Print welcome message as object initialized.
	end

	protected
		def play_game # 請撰寫遊戲內容
			set_board
			playing_TTT
		end

	# --- Private methods for TicTacToe ---

	private
		def playing_TTT
			@is_game_over = false
			@msg_result = ""
			@counts = 0
			refresh_board
			
			begin
				user_move
				@is_game_over ? break : computer_move
			end while !@is_game_over
			
			puts "Game is over! #{@msg_result}"	
		end

	private
		def set_board
			begin
				print "Please enter board size (must between 3 and 5): "
				@row_count = gets.chomp.to_i
			end while !(3..5).include?(@row_count)

			@tb = Array.new(@row_count ** 2, "_") # initialize game board
			print_board
		end

	private
		def print_board
			for i in 0..(@row_count - 1)
				puts @tb[(i * @row_count)..((i + 1) * @row_count - 1)] * "|"
			end
		end

	private
		def refresh_board
			system "clear"
			print_game_title("Tic Tac Toe!!!")
			puts "Input board size is #{@row_count} * #{@row_count}\n"
			print_board
		end		

	private
		def user_move
			puts "Please enter next move: "
			puts "(ex. Enter index from 0 to #{@row_count ** 2 - 1} : "
			begin
				um = gets.chomp.to_i
			end	while !is_valid_move(um)

			@tb[um] = "O"
			refresh_board
			check_result(true)
		end

	private
		def computer_move
			begin
				cm = rand(1..((@row_count ** 2) - 1))
			end while !is_valid_move(cm)

			@tb[cm] = "X"
			refresh_board
			check_result(false)
		end

	private 
		def is_valid_move(move)
			if @tb[move] == "_"
				@counts += 1 # valid move
			else
				puts "Index has been chosen, please enter again : "
				return false
			end

		if @counts == @row_count ** 2
			@is_game_over = true
			@msg_result = "It's a tie, no one wins."
		end				

		true
	end

	private
		def check_result(is_user)			
			is_user ? mrk = "O" : mrk = "X" 

			# Horizontal check
			for i in 0..(@row_count - 1)
				chk_ary = @tb[(i * @row_count)..((i + 1) * @row_count - 1)].uniq

				if(chk_ary == [mrk])
					@is_game_over = true
					@msg_result = (is_user ? "You win!" : "You lose!")
					return
				end
			end

			# Vertical check
			for i in 0..(@row_count - 1)
				chk_ary = []

				for j in 0..(@row_count - 1)
					chk_ary.push(@tb[i + (j * @row_count)])
				end

				if (chk_ary.uniq == [mrk])
					@is_game_over = true
					@msg_result = (is_user ? "You win!" : "You lose!")
					return
				end
			end	

			# Diagonal check 1
			chk_ary = []
			for i in 0..(@row_count - 1)
				chk_ary.push(@tb[i * @row_count + i])
			end	

			if (chk_ary.uniq == [mrk])
					@is_game_over = true
					@msg_result = (is_user ? "You win!" : "You lose!")
					return
			end

			# Diagonal check 1
			chk_ary = []
			for i in 1..@row_count
				chk_ary.push(@tb[i * @row_count - i])
			end	

			if (chk_ary.uniq == [mrk])
					@is_game_over = true
					@msg_result = (is_user ? "You win!" : "You lose!")
					return
			end

		end
end

