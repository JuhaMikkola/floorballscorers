
require 'CSV'
require 'iconv'

floorballscorers-switzerland = Iconv.conv("UTF8", "LATIN1", text_in)

arr_of_arrs = CSV.read("floorballscorers-.csv")

puts arr_of_arrs