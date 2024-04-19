class Game
    @@color_list = ["blue", "red", "purple", "green", "yellow"]
    def initialize
        @answer = []
        @results = []
        create_answer
        game_loop
    end
    # randomly place 4 colors into the answer array
    def create_answer
        until @answer.length == 4
            color = @@color_list[rand(4)]
            @answer.push(color)
        end
    end
    # this is where the actual game is played
    def game_loop
        win = false
        moves = 12
        pool = @@color_list.join(", ")
        # the game will loop until either the player guesses correctly
        # or they run out of turns
        until win == true || moves == 0
            puts "Enter four colors from this color pool:"
            puts pool
            puts " "
            guess = gets.chomp.split(" ")
            until validate_input(guess)
                puts "Invalid Input. Try Again..."
                guess = gets.chomp.split(" ")
            end
            if validate_guess(guess)
                win = true
                puts " "
                puts "Congratulations! You won!"
            else
                moves -= 1
                if moves == 0
                    puts "You have lost!"
                else
                    puts "You have #{moves} moves remaining"
                    puts " "
                end
            end
        end
    end
    # make sure that the player inputs the right number of colors
    # and that the color are actual colors that can be guessed
    def validate_input(guess)
        unless guess.length == 4
            return false
        end
        is_valid = guess.all? { |element| @@color_list.include?(element) }
        return is_valid
    end
    # compare the answer and guess array at each index
    def validate_guess(guess)
        x = 0
        while x < 4
            # if the guess and answer are a match, indicate so in results
            if guess[x] == @answer[x]
                @results[x] = "match"
            # if the guess is just included in the answer, indicate
            elsif @answer.include?(guess[x])
                @results[x] = "included"
            # otherwise, indicate it is not found
            else
                @results[x] = "NA"
            end
            x += 1
        end
        result_message = @results.join(", ")
        puts result_message
        # check if the results array is all match
        complete_match = @results.all? { |element| element == "match" }
        return complete_match
    end
end

Game.new