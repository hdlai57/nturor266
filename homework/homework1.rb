# homework1
# 剪刀石頭布
# 先要使用者輸入剪刀石頭或布的其中一個選項
# 接下來讓電腦亂數選出一個選項
# 比較兩個選項，決定誰贏誰輸
# 輸出結果
# 問使用者是否再玩一次


begin #可以美化輸出
  puts "|===============================================|" 
  puts "|Welcome to Rock Paper Scissors!!!              |"
  puts "|===============================================|"

  begin
    
    begin 
      puts "please choose one of the following: R / P / S"
      user_input = gets.chomp.upcase
    end while !["R", "P", "S"].include?(user_input) 

    #接下來請把剩下的部份寫出來...

    #宣告變數
    result = nil
    arr_getsures = ["Rock", "Paper", "Scissors"]
    computer_output = arr_getsures.shuffle!.last

    case user_input #判斷使用者輸入
    when "R"
      user_input = "Rock"
      case computer_output #判斷機器輸入與結果
      when "Rock" then result = "it's a tie"
      when "Paper" then result = "you lose"
      when "Scissors" then result = "you win"
      end
    when "P"
      user_input = "Paper"
      case computer_output #判斷機器輸入與結果
      when "Rock" then result = "you win"
      when "Paper" then result = "it's a tie"
      when "Scissors" then result = "you lose"
      end
    when "S"
      user_input = "Scissors"
      case computer_output #判斷機器輸入與結果
      when "Rock" then result = "you lose"
      when "Paper" then result = "you win"
      when "Scissors" then result = "it's a tie"
      end
    end

    #印出結果
    puts "You choose #{user_input}, the computer choose #{computer_output}, #{result}!"

    #問使用者是否還要再玩 
    begin
      puts "Play Again?: Y / N"
      continue = gets.chomp.upcase
    end while !["Y", "N"].include?(continue)

  end while continue == "Y"
# 若使用者回答 "N"，印出離開的訊息，不是就回到迴圈的上層繼續玩

puts "Good Bye! Thanks for playing!"

end