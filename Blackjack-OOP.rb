class Deck
	attr_accessor :cards

	def initialize
		@cards = []
		['H', 'D', 'S', 'C'].each do |suit|
			['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |value|
				@cards << Card.new(suit, value)
			end
		end
		cards.shuffle!
	end

	def deal
		return cards.pop
	end
end

class Card
	attr_accessor :suit, :value

	def initialize (s, v)
		@suit = s
		@value = v
	end

	def to_s
		print "[#{@value} of #{@suit}] "
	end
end

class Player
	attr_accessor :name, :hand

	def initialize(name)
		@name = name
		@hand = Hand.new
	end

	def hit(card)
		hand.add(card)
	end

	def show_hand
		print "#{name}'s hand is: "
		hand.to_s 
	end

	def decide
		if @hand.sum.min <= 21
			print "Would you like to Y. hit N. stay? "
			return choice = gets.chomp
		else
			return 'N'
		end
	end

	def sum
		return @hand.sum.max
	end	
end

class Dealer < Player
	def decide
		if @hand.sum.min < 17
			return 'Y'
		else
			return 'N'
		end
	end
end

class Hand
	attr_accessor :cards, :sum

	def initialize
		@cards = []
		@sum = [0,0]
	end

	def add(card)
		@cards << card
		hand_sum
	end

	def to_s
		@cards.each do |c|
			c.to_s
		end
		print " sum is #{sum}\n"
	end

	def size
		return card.size
	end

def hand_sum
	@sum = [0,0]
	@cards.each { |i|
		if i.value == 'J' || i.value == 'Q' || i.value == 'K'
			@sum[0] += 10
			@sum[1] += 10
		elsif i.value == 'A'
			@sum[0] += 1
			@sum[1] += 11
		else
			@sum[0] += i.value.to_i
			@sum[1] += i.value.to_i
		end
	}
	if sum[1] > 21 || (sum[0] == sum[1]) && sum[0] != 'A'
		@sum.pop
	end	
end

end

deck = Deck.new

p1 = Player.new("Ian")
p2 = Dealer.new("Computer")

p1.hit(deck.deal)
p2.hit(deck.deal)
p1.hit(deck.deal)
p2.hit(deck.deal)

p1.show_hand
p2.show_hand

while p1.decide == 'Y'
	p1.hit(deck.deal)
	p1.show_hand
	p2.show_hand
end

if p1.sum > 21
	p1.show_hand
	puts ">21, you lose"
else	
	while p2.decide == 'Y'
		p2.hit(deck.deal)
		p1.show_hand
		p2.show_hand
	end
	if p1.sum > p2.sum || p2.sum > 21
		puts "You won"
	else
		puts "You lose"
	end
end



