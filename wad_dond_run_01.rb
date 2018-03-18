# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'		
require 'pp'
# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_dond_gen_01"

# Main program
module DOND_Game

	def self.newgame(g)
		g.clearScreen
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
		g.clearScreen
		@output.puts "DEAL!"
		@output.puts "Congratulations! You have won #{money} pounds!"
		@output.puts "\n\npress any key to continue..."
		@input.gets
		self.newgame(g)
	end

	def self.win(g, box)
		g.clearScreen
		@output.print "Congratulations! You have won content of the box no #{box} "
		box = box.to_i - 1
		@output.print "#{g.sequence[box]} pounds"
		g.showamounts
		@output.puts "\n\npress any key to continue..."
		@input.gets
		self.newgame(g)
	end

	def self.validateandchoose(g, promptkind)
		box = -1
		forbidden = ['']

		while box == -1
			if promptkind == "select"
				g.displayselectboxprompt
				forbidden = [g.getchosenbox.to_i-1] + g.getopenedboxindex
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
			g.clearScreen
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
			# @output.puts "#{offer}"
			@output.puts "Do you accept the offer? Deal or not deal? [d/ND]: "
			dec = g.getinput
			
			if dec == "D" || dec == "DEAL"
				self.deal(g, offer)
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
	g.clearScreen
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

	# Sinatra routes
	# Any code added to web-based game should be added below.
	
end
# End modules
@@g = DOND_Game::Game.new(STDIN, STDOUT)
@@g.resetgame
@@g.assignvaluestoboxes

@@available = (1..22).to_a

get '/' do
	if @@g.chosenbox == 0
		redirect '/newgame'
	end
	erb :home
end

post '/' do
	box = params[:openbox]
	@@g.storeguess(box)
	@@g.openbox(box)
	pp box
	@@available.delete(box.to_i)

	redirect '/deal'
end

get '/newgame' do
	@@available = (1..22).to_a
	@@g.resetgame	
	@@g.assignvaluestoboxes

	erb :newgame
end

post '/newgame' do
	chosenbox = params[:chosenbox]
	@@g.setchosenbox(chosenbox)
	@@available.delete(chosenbox.to_i)
	redirect '/'
end

get '/deal' do
	@offer = @@g.bankercalcsvalue(@@g.bankercalculation)
	
	erb :deal
end
 
post '/deal' do
	deal = params[:deal]
	if deal == 1
		redirect '/endofgame'
	else
		redirect '/'
	end
end

get '/summary' do
	erb :about
end

get '/endofgame' do
	erb :about
end

get '/about' do
	erb :about
end

def self.validateandchoose(g, promptkind)
	box = -1
	forbidden = ['']

	while box == -1
		if promptkind == "select"
			g.displayselectboxprompt
			forbidden = [g.getchosenbox.to_i-1] + g.getopenedboxindex
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
	end
	return box
end
# Any code added to web-based game should be added above.
# End program