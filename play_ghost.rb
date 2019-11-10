require_relative "./game.rb"

puts "Welcome to Ghost! In this game, each player will take turns entering a single letter to create a 'word'. If the 'word' is real - aka it exists in the dictionary, you lose that round. For every round lost, that player will receive a letter of the word GHOST. The first player to spell the word GHOST loses :^)"

puts "First player, what's your name?"
first_player = gets.chomp
puts ""

puts  "Second player, what's your name?"
second_player = gets.chomp
puts ""

game = Game.new(first_player, second_player)
game.run

puts ""
puts "Game over!"