require 'nokogiri'
require 'open-uri'
require 'pry'

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

File.open('floorballscorers.html', 'w') do |f|
page = Nokogiri::HTML(open("http://www.innebandy.se/templates/IDA/TopScorersList.aspx?PageId=8811&CompetitionID=16922&epslanguage=en"))
# players = page.css('div.tableContainer td')
players = page.css('.tableList tr')


  f.write("<html>")
  f.write("<head>")
  f.write("<title>Professional Floorball League Top Scorers</title>")
  f.write('<link type="text/css" rel="stylesheet" href="stylesheet.css">')
  f.write('<meta charset="utf-8">')
  f.write("</head>")
  f.write("<body>")

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

      if column == 1 || column == 2
        parsed_stat = stat.at_css('a').text
      else
        parsed_stat = stat.text
      end

      if parsed_stat == nil
        stat_value = 0
      elsif
        stat_value = parsed_stat
      end


      # ternary equivalent of the above if statement
      # stat_value = (parsed_stat == nil ? 0 : parsed_stat.text)

      field_name = current_player.instance_variables[ column-1 ]
      current_player.instance_variable_set( field_name, stat_value )

      #Take second stat value and save as Name
      # if column == 1
      #   current_player.name = stat_value
      # end

      # #Take third stat value and save as Team
      # if column == 2
      #   current_player.team = stat_value
      # end

      # #Take fourth stat value and save as GP
      # if column == 3
      #   current_player.gp = stat_value
      # end

      # #Take firth stat value and save as G
      # if column == 4
      #   current_player.g = stat_value
      # end

      # #Take sixth stat value and save as A
      # if column == 5
      #   current_player.a = stat_value
      # end

      # #Take seventh stat value and save as P
      # if column == 6
      #   current_player.pts = stat_value
      # end

      # #Take eighth stat value and save as PIM
      # if column == 7
      #   current_player.pim = stat_value
      # end

      # end of the td level (column)
    end


    stats_array << current_player
    # end of the tr level (row)

    # we're now done gathering data at this point.
  end

  f.write("<table>")
  f.write("<caption>Floorball Top Scorers</caption>")

  f.write("<thead>")

  f.write(' <tr class="odd">
            <td class="column1"></td>
            <th scope="col" abbr="Player Name">Name</th>  
            <th scope="col" abbr="League">League</th>
            <th scope="col" abbr="Team">Team</th>
            <th scope="col" abbr="Games Players">GP</th>
            <th scope="col" abbr="Goals">G</th>
            <th scope="col" abbr="Assists">A</th>
            <th scope="col" abbr="Points">P</th>
            <th scope="col" abbr="Penalties in Minutes">PIM</th>
            </tr> 
            </thead>')

  f.write('<tbody>')

  stats_array.each do |x|
      f.write("<tr>")
      f.write('<th scope="row" class="column1"></th>')
      f.write("<td class='column2'>" + x.name.to_s + "</td>")
      f.write("<td>SSL</td>")
      f.write("<td>" + x.team.to_s + "</td>")
      f.write("<td>" + x.gp.to_s + "</td>")
      f.write("<td>" + x.g.to_s + "</td>")
      f.write("<td>" + x.a.to_s + "</td>")
      f.write("<td>" + x.pts.to_s + "</td>")
      f.write("<td>" + x.pim.to_s + "</td>")
      f.write("</tr>") 
  end

  # players.each do |player|
  # f.write( player.css('a').text)
  # end

  f.puts('</tbody>')
  f.puts('</table>')

  f.puts("</body>")
  f.puts("</html>")
end


# Other countries:
# Switzerland
# http://www.swissunihockey.ch/spielbetrieb/mobiliar_topscorer/
# Czech Republic
# http://www.cfbu.cz/fis/open.php?reportno=5&competition_code=8XM12013/2014&division_code=A
# Finland COMING SOON
# http://salibandyliiga.fi/sites/salibandyliiga/files/miesten_salibandyliigan_pisteporssi.pdf