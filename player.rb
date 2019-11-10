class Player
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess
        p "What's your guess?"
        guess = gets.to_s.chomp.upcase
    end

    def alert_invalid_guess
        p "Bad guess! Your guess should be a single alphabet letter, and should be able to make valid words after being added to the fragment - try again" 
    end

end