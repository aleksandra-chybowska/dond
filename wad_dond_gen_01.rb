# Ruby code file - All your code should be located between the comments provided.

# Main class module
module DOND_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 5

	class Game
		attr_reader :sequence, :selectedboxes, :openedboxes, :chosenbox, :selectedbox, :turn, :input, :output, :winner, :played, :wins, :losses, :guess, :values, :amounts
		attr_writer :sequence, :selectedboxes, :openedboxes, :chosenbox, :selectedbox, :turn, :input, :output, :winner, :played, :wins, :losses, :guess, :values, :amounts

		def initialize(input, output)
			@input = input
			@output = output
		end
		
		def getinput
			@input.gets.chomp.upcase
		end
		
		def storeguess(guess)
			if guess != ""
				@selectedboxes = @selectedboxes.to_a.push "#{guess}"
			end
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
	sequence =
	selectedboxes =
	openedboxes = 
	chosenbox = 
	selectedbox =
	turn = 
	winner = 
	played = 
	wins = 
	losses = 
	guess = 
	values = 
	amounts = values

	def start 
		output.puts 'Welcome to Deal or No Deal!'
		def created_by
			'Nassr Al-Emrani'
		end
		output.puts "Designed by: #{created_by}"
		def student_id
			'51771025'
		end
		output.puts "StudentID: #{student_id}"
		output.puts 'Starting game...'
	end
	

		

		
	def displaymenu
		output.puts "Menu: (1) Play | (2) New | (3) Analysis | (9) Exit"
	end
	
	def resetgame
		output.puts "New game..."
		
				@sequence = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
				@selectedboxes = []
				@openedboxes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
				@chosenbox = 0
				@selectedbox = 0
				@turn = 0
				@winner = 0
				@played = 0
				@wins = 0
				@losses = 0
				@guess = ""
				@values = [0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]
				@amounts = @values
		
	end
	
	def assignvaluestoboxes
			b = @values.sample
			@sequence.map! {|x| x == 0 ? b : x}
			if @sequence.uniq.length != @sequence.length
				a=@sequence.detect { |e| @sequence.count(e) > 1 }
				@sequence.map! {|x| x == a ? b : x}
			else
			end

	end
	
	def showboxes
		output.puts "Box #{b}: [#{b}] Status: #{@game.openedboxes[i]}"
		output.print "#{g} "
	end
	
	def showamounts
		output.puts "#{c1}   #{c2}"
	end
	
	def removeamount (value)
		b= "    "
		@values.map! {|x| x == value ? b : x}
	end
	
	def setchosenbox(b)
		@chosenbox = b
	end
	
	def getchosenbox
		return @chosenbox
	end
	
	def displaychosenbox
		output.puts "Chosen box: [#{box}]"
	end
	
	def displaychosenboxvalue
		output.puts "Chosen box: [#{box}] contains: #{value}"
	end
	
	def displaychosenboxprompt
		output.puts "Enter the number of the box you wish to keep."
	end
	
	def displaychosenboxerror
		output.puts "Error: Box number must be 1 to 22."
	end
	
	def displayanalysis
		output.puts "Game analysis"
		output.puts "#{g} Status: #{s}"
	end
	
	def showselectedboxes
		output.puts "Log: #{@selectedboxes.inspect}"
	end
	
	def displayselectboxprompt
		output.puts "Enter the number of the box you wish to open. Enter returns to menu."
	end
	
	def openbox(guess)
		output.puts	"#{g} Status: #{s}"
		output.print "#{g} "
	end
	
	def bankerphoneswithvalue(offer)
		output.puts "Banker offers you for your chosen box: #{offer}"
	end
	
	def bankercalcsvalue(value)
		return value/2
	end
	
	def numberofboxesclosed
		openedboxes.reject{ |o| o != 0 }.length
	end
	
	def incrementturn
		@turn +=1
	end
	
	def getturnsleft
		i=GOES-@turn
		return i
	end
	
	def finish
		output.puts "... game finished."
	end
	
	
#	
#	puts displaymenu
#	puts resetgame
#	showboxes


		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end


