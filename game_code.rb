class Game
    @@color_list = ["blue", "red", "purple", "green", "yellow"]
    def initialize
        @validate = Validate.new(@@color_list)
        @player = PlayerPlays.new(@validate)
        @computer = ComputerPlays.new(@validate)
        setup
    end
    def setup
        puts "Welcome to Mastermind"
        puts "Would you like to create the code or crack it?"
        puts "You can type 'create' or 'crack'"
        choice = " "
        until choice == "create" || choice == "crack"
            choice = gets.chomp
            unless choice == "create" || choice == "crack"
                puts "Invalid choice! Try again..."
            end
            puts " "
        end
        # if the player chooses create, prompt them to make an code
        # and call the computer plays class
        if choice == "create"
            puts "Input four colors of your choice."
            puts "Colors can be chosen from this selection:"
            pool = @@color_list.join(", ")
            puts pool
            answer = gets.chomp.split(" ")
            until @validate.input(answer)
                puts "Invalid Input. Try Again..."
                answer = gets.chomp.split(" ")
            end
            @computer.create_answer(answer)
            @computer.game_loop
        end
        # if the player chooses crack, call the player plays class
        if choice == "crack"
            puts "The computer has created a code."
            @player.game_loop
        end
    end
end

class ComputerPlays < Game
    def initialize(validator)
        @answer = []
        @guess = []
        @validate = validator
    end
    def create_answer(answer)
        @answer = answer
    end
    def game_loop
        until @guess.length == 4
            color = @@color_list[rand(4)]
            @guess.push(color)
        end
        win = false
        moves = 12
        until win == true || moves == 0
            puts "The computer guesses:"
            puts @guess.join(" ")
            puts " "
            if @validate.guess(@guess, @answer)
                win = true
                puts "The computer has won!"
            else
                moves -= 1
                if moves == 0
                    puts "The computer has lost"
                else
                    puts "The computer didn't get it."
                    puts "#{moves} moves left. Trying again..."
                    puts " "
                    @validate.new_guess(@guess)
                end
            end
        end
    end
end

class PlayerPlays < Game
    def initialize(validator)
        @answer = []
        @validate = validator
        create_answer
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
            until @validate.input(guess)
                puts "Invalid Input. Try Again..."
                guess = gets.chomp.split(" ")
            end
            if @validate.guess(guess, @answer)
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
    
end
class Validate < Game
    def initialize(pool)
        @color_list = pool
        @results = []
    end
    # make sure that the player inputs the right number of colors
    # and that the color are actual colors that can be guessed
    def input(guess)
        unless guess.length == 4
            return false
        end
        is_valid = guess.all? { |element| @color_list.include?(element) }
        return is_valid
    end
    # compare the answer and guess array at each index
    def guess(guess, answer)
        x = 0
        while x < 4
            # if the guess and answer are a match, indicate so in results
            if guess[x] == answer[x]
                @results[x] = "match"
            # if the guess is just included in the answer, indicate
            elsif answer.include?(guess[x])
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
    def new_guess(guess)
        x = 0
        while x < 4
            unless @results[x] == "match"
                current_color = guess[x]
                while guess[x] == current_color
                    guess[x] = @color_list[rand(4)]
                end
            end
            x += 1
        end
    end
end

Game.new