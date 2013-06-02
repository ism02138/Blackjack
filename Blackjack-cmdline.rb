def get_new_card(hand, deck)
	hand << deck.pop
end

def hand_sum(hand)
	sum = [0, 0]
	hand.each { |i|
		if i == 'J' || i == 'Q' || i == 'K'
			sum[0] += 10
			sum[1] += 10
		elsif i == 'A'
			sum[0] += 1
			sum[1] += 11
		else
			sum[0] += i
			sum[1] += i
		end
	}
	if sum[1] > 21 
		sum.pop
	end
	return sum
end

def player_wins(hand_player, hand_computer)
	if hand_sum(hand_player).max > hand_sum(hand_computer).max
		return true
	else
		return false
	end
end

def print_hand(player_name, hand)
	print "=> #{player_name} hand: #{hand} . . . total: "
	sum = hand_sum(hand)
	if (sum[0] == sum[1])
		print "#{sum[0]}\n"
	else
		print "#{sum[0] or sum[1]}\n"
	end
end

#def is_game_over(hand_player, hand_computer)


# build deck

cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
deck = []
4.times { |i| deck.push(*cards) }

# shuffle deck

deck.shuffle!

# initialize hands

hand_player = []
hand_computer = []

# deal

2.times { |i| 
	get_new_card(hand_player, deck)
	get_new_card(hand_computer, deck)
}

# play

while hand_sum(hand_player).max < 21
	print_hand("Your", hand_player)
	puts "=> Would you like to hit (Y or N): "
	hit = gets.chomp
	if hit == 'Y'
		get_new_card(hand_player, deck)
	else
		break
	end
end

if hand_sum(hand_player).min > 21
	print_hand("Your", hand_player)
	puts "=> You've gone over, computer wins"
else
	while hand_sum(hand_computer).max < 17
		get_new_card(hand_computer, deck)
		print_hand("Computer's", hand_computer)
	end	

	if hand_sum(hand_computer).min > 21
		puts "=> Computer has gone over, you win"
	elsif player_wins(hand_player, hand_computer)
		print_hand("Your", hand_player)
		print_hand("Computer's", hand_computer)
		puts "=> You win"
	else
		print_hand("Your", hand_player)
		print_hand("Computer's", hand_computer)
		puts "=> You lose"
	end
end