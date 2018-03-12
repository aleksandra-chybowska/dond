# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'		

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_dond_gen_01"

# Main program
module DOND_Game

	def self.newgame(g)
		g.start	
		g.resetgame	
		@output.puts "\n"
		g.assignvaluestoboxes
		g.showboxes
		@output.puts "\n"
		chosenbox = self.validateandchoose(g, "primary")
		g.setchosenbox(chosenbox)
	end

	def self.deal(g, money)
		@output.puts "DEAL!"
		@output.puts "Congratulations! You have won #{money} pounds!"
		@output.puts "\n"
		self.newgame(g)
	end

	def self.win(g, box)
		@output.print "Congratulations! You have won content of the box no #{box}"
		box = box.to_i - 1
		@output.print "#{g.sequence[box]}"
		g.showamounts
		@output.puts "\n"
		self.newgame(g)
	end

	def self.validateandchoose(g, promptkind)
		box = -1
		forbidden = ['']

		while box == -1
			if promptkind == "select"
				g.displayselectboxprompt
				forbidden = [g.getchosenbox] + g.getopenedboxindex
			else
				g.displaychosenboxprompt
			end

			box = g.getinput

			if promptkind == "select" && box == ''
				return box
			elsif g.boxvalid(box) == 1 || forbidden.include?(box.to_i - 1)
				box = -1
				g.displaychosenboxerror
			end
			@output.puts "\n"
		end
		return box
	end

	def self.play(g)
		while true
			g.showboxes
			g.showselectedboxes
			box = self.validateandchoose(g, "select")
			if box == '' 
				break 
			end
			g.storeguess(box)
			g.openbox(box)
			
			offer = g.bankercalcsvalue(g.bankercalculation)
			banker = g.bankerphoneswithvalue(offer)
			@output.puts "#{banker}"
			@output.puts "Do you accept the offer? Deal or not deal? [d/ND]: "
			dec = g.getinput
			
			if dec == "D" || dec == "DEAL"
				self.deal(g, banker)
				break		
			end

			if g.numberofboxesclosed == 1
				self.win(g, g.getchosenbox)
				break
			end

			@output.puts "NO DEAL!"			
		end
	end

	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	playing = true
	input = ""
	menu = ""
	guess = ""
	box = 0
	turn = 0
	win = 0
	deal = 0
	@output.puts "\n" + '-------------------------------------------------------------------------' + "\n"
	@output.puts "\n" + 'Enter "1" runs game in command-line window or "2" runs it in web browser.' + "\n"
	@output.puts "\n" + '-------------------------------------------------------------------------' + "\n"
	game = g.getinput
	if game == "1"
		@output.puts "\nCommand line game.\n"
	elsif game == "2"
		@output.puts "\nWeb-based game.\n"
	else
		@output.puts "\nInvalid input! No game selected.\n"
		exit
	end
		
	if game == "1"
		
		# Any code added to command line game should be added below.
		self.newgame(g)

		while true
			g.displaymenu
			selection = g.getinput
			@output.puts "\n"

			case selection
				when '1'
					self.play(g)
				when '2'
					self.newgame(g)
				when '3'
					g.displayanalysis
				else
					g.finish
					exit
			end
		end

	# Any code added to command line game should be added above.
	
		exit	# Does not allow command-line game to run code below relating to web-based version
	end
end
# End modules

# Sinatra routes

	# Any code added to web-based game should be added below.



	# Any code added to web-based game should be added above.

# End program