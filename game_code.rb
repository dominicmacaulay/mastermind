class Game
    @@color_list = ["blue", "red", "purple", "green", "yellow"]
    def initialize
        @answer = []
        create_answer()
    end
    # randomly place 4 colors into the answer array
    def create_answer()
        until @answer.length == 4
            color = @@color_list[rand(4)]
            @answer.push(color)
        end
    end
end

Game.new