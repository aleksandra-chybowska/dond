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

		while g.getchosenbox == 0
			g.displaychosenboxprompt
			chosenbox = g.getinput
			
			if g.boxvalid(chosenbox) == 0
				g.setchosenbox(chosenbox)
			else
				g.displaychosenboxerror
				# g.displaychosenbox
			end
			@output.puts "\n"
		end
	end

	def self.play(g)
		g.showboxes
		g.showselectedboxes
		box = 0

		while box == 0
			g.displayselectboxprompt
			box = g.getinput
			
			if g.boxvalid(box) == 1
				box = 0
				g.displaychosenboxerror
			end
			@output.puts "\n"
		end

		g.storeguess(box)
		g.openbox(box)
		offer = g.bankercalcsvalue(g.bankercalculation)
		@output.puts "#{g.bankerphoneswithvalue(offer)}"

		#implement better offer options

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