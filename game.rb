require_relative "./player.rb"

class Game
    attr_reader :fragment, :losses, :players
    attr_accessor :players

    def initialize(player_one, player_two) 
        @players = [Player.new(player_one),Player.new(player_two)]
        @fragment = ""
        @losses = {}
        
        @players.each { |player| losses[player.name] = 0}
    end

    def dictionary
        @dictionary = {}

        file = File.open("dictionary.txt").each do |line|
            word = line.to_s.upcase.chomp
            @dictionary[word] = word.length 
        end

        @dictionary
    end

    def run
        until @losses.values.any? { |val| val == 5}
            self.play_round
        end
    end

    def record(player)
        ghost = "GHOST"
        length = @losses[player]

        if @losses[player] > 0
            player_record = ghost[0...length]
            return  "#{player} - #{player_record}".chomp
        else
            return "#{player} - No losses yet".chomp
        end
    end

    #what defines a single round of ghost? playing until one players spells a word
    #take_turn(current_player) needs to keep going until it returns true 
    def play_round #this is a single round 
        self.dictionary
        @fragment = ""
        round_over = false

        while round_over == false
            player = self.current_player
            if self.take_turn(player) == true
                round_over = true
            else
                self.next_player!
            end
        end

        puts "Round is over! Word spelt: #{@fragment}"
        puts "STANDINGS:"
        puts "#{self.record(self.current_player.name)}"
        puts "#{self.record(self.previous_player.name)}"
        puts "__________________________________________________"
        puts "__________________________________________________"
        puts "__________________________________________________"
        puts ""
    end

    def take_turn(player)     
        puts  "The current player is #{player.name}"
        current_guess = player.guess

        if !valid_play?(current_guess) 
            player.alert_invalid_guess
            puts ""
            take_turn(player)
        end

        @fragment += current_guess

        if @dictionary.has_key?(@fragment)
            @losses[player.name] += 1
            return true
        end

        puts "The current fragment is #{@fragment}"
        puts "_________________"
        puts ""
        false
    end

    def current_player
        @players[0]
    end
    
    def previous_player
        @players[-1]
    end

    def next_player!
        @players.rotate!
        @current_player = @players[0]
        @previous_player = @players[1]
    end

    def valid_play?(guess)
        words = self.dictionary.keys
        alphabet = [*'A'..'Z'].to_a
        potential_fragment = @fragment + guess

        has_potential = words.any? { |word| word.slice(0, potential_fragment.length) == potential_fragment } 
        if alphabet.include?(guess) && has_potential && guess.length == 1
            return true
        else
            return false
        end
    end

end

