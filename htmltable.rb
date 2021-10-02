#class for html table
class Htmltable
    
    #creates header for html table
    def create_header (f)
        f.puts "<!DOCTYPE html>"
        f.puts "<html lang =\"en\"> <head> <title>"
        f.puts "Crime around OSU"
        f.puts "</title> </head>"
        f.puts "<body> <h1> Crime around OSU </h1><table border=\"1\">"
        f.puts "<tr>"
        f.puts "<th>Date</th>"
        f.puts "<th>Time</th>"
        f.puts "<th>Location</th>"
        f.puts "<th>Description</th>"
        f.puts "</tr>"
    end
    #creates footer for html table
    def create_footer (f)
        f.puts "</table>"
        f.puts "</body> </html>"
    end
    #outputs one crime to the table
    def output_element (f)
        f.puts "<tr>"
        f.puts "<td>"
#date here
        f.puts "</td>"
        f.puts "<td>"
#time here
        f.puts "</td>"
        f.puts "<td>"
#location here
        f.puts "</td>"
        f.puts "<td>"
#description here
        f.puts "</td>"
        f.puts "</tr>"
end

