class Game
    @@color_list = ["blue", "red", "purple", "green", "yellow"]
    def initialize
        @answer = []
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
    def game_loop
        win = false
        moves = 1
        pool = @@color_list.join(", ")
        until win == true || moves == 12
            puts "Enter four colors from this color pool:"
            puts pool
            guess = gets.chomp.split(" ")
            until validate_input(guess)
                puts "Invalid Input. Try Again..."
                guess = gets.chomp.split(" ")
            end
        end
    end
    def validate_input(guess)
        unless guess.length == 4
            return false
        end
        is_valid = guess.all? { |element| @@color_list.include?(element) }
        return is_valid
    end
end

Game.new