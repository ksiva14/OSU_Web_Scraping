#class for html table
require_relative "scraper"
class Htmltable
    
    #creates header for html table
    def create_page (f)
        f.write "<!DOCTYPE html>"
        f.write "<html lang =\"en\"> "
        f.write "  <head>"
        f.write "    <title>Neighborhood Crime Around OSU</title>"
        f.write "    <meta charset=\"utf-8\" />"
        f.write "  </head>"
        f.write "  <body>"
        create_table f
        create_footer f
    end
    #Create Table
    def create_table (f)
        f.write "    <table border=\"1\">"
        f.write "    <caption>Important Neighborhood Crime Information Around OSU</caption>"
        f.write "    <tr>"
        f.write "      <th>Date<th>"
        f.write "      <th>Location<th>"
        f.write "      <th>Time<th>"
        f.write "      <th>Additional Information<th>"
        f.write "    </tr>"
        output_rows f
    end
    #creates footer for html table
    def create_footer (f)
        f.write "    </table>"
        f.write "  </body>"
        f.write "</html>"
        f.close
    end
    #write all rows for table with information
    def output_rows (f)
        @all_notices.each do |notice|
                f.write "    <tr>"
                f.write "      <td>#{notice.date}</td>"
                f.write "      <td>#{notice.location}</td>"
                f.write "      <td>#{notice.time}</td>"
                f.write "      <td>#{notice.description}</td>"
                f.write "    </tr>"
        end
    end
end

