require 'nokogiri'
require 'watir'

class Player
  attr_accessor :name, :team, :gp, :g, :a, :pts, :pim

  def initialize
    @name = ""
    @team = ""
    @gp = 0
    @g = 0
    @a = 0
    @pts = 0
    @pim = 0    
  end
end

File.open('floorballscorers-czech.csv', 'w') do |f|

browser = Watir::Browser.new
browser.goto 'http://www.cfbu.cz/fis/open.php?reportno=5&competition_code=8XM12013/2014&division_code=A'
sleep 5
page = Nokogiri::HTML.parse(browser.html)

puts page

players = page.css('.playersTable tr')

puts players.inspect
puts players

  stats_array = []

  # each turn of this loop advances the current player row
  players.each_with_index do |player, i|

    # first row is actually the header
    if (i == 0)
      next
    end

    # stats_array << Player.new

    current_player = Player.new

    #each stat represents a particular td or column
    player.css('td').each_with_index do |stat, column|

      #skip the player rank number
      if column == 0
        next
      end

      if column == 1
        parsed_stat = stat.at_css('a').text
      else
        parsed_stat = stat.text
      end

      # if parsed_stat == nil
      #   stat_value = 0
      # elsif
      #   stat_value = parsed_stat
      # end

      # Take second stat value and save as Name
      if column == 1
        current_player.name = parsed_stat
      end

      #Take third stat value and save as Team
      if column == 2
        current_player.team = parsed_stat
      end

      #Take fifth stat value and save as GP
      if column == 4
        current_player.gp = parsed_stat
      end

      #Take sixth stat value and save as G
      if column == 5
        current_player.g = parsed_stat
      end

      #Take ninth stat value and save as A
      if column == 8
        current_player.a = parsed_stat
      end

      #Take tenth stat value and save as P
      if column == 9
        current_player.pts = parsed_stat
      end

      #Take eleventh stat value and save as PIM
      if column == 10
        current_player.pim = parsed_stat
      end

      #Skip the stuff we don't need - 19 columnts
      if column == 3 || column == 6 || column == 7 || column == 11 ||  column == 12 ||  column == 13 ||  column == 14 ||  column == 15 ||  column == 16 ||  column == 17 ||  column == 18 ||  column == 19 ||  column == 20 ||  column == 21 ||  column == 22 ||  column == 23 ||  column == 24 ||  column == 25 ||  column == 26 ||  column == 27 ||  column == 28 ||  column == 29
        next
      end

      # end of the td level (column)
    end

puts current_player

    stats_array << current_player
    # end of the tr level (row)



    # we're now done gathering data at this point.
  end

    #writes the results to a CSV file
  stats_array.each do |x|
      f.write(x.name.to_s + ", ")
      f.write(x.team.to_s + ", ")
      f.write(x.gp.to_s + ", ")
      f.write(x.g.to_s + ", ")
      f.write(x.a.to_s + ", ")
      f.write(x.pts.to_s + ", ")
      f.write(x.pim.to_s + ", ")
      f.write("
        ") 
  end

puts stats_array.inspect

end