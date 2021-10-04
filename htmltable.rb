# class for html table
require_relative 'scraper'
class Htmltable
  # creates header for html table
  def create_page(f, notices)
    f.puts '<!DOCTYPE html>'
    f.puts '<html lang ="en"> '
    f.puts '  <head>'
    f.puts '    <title>Neighborhood Crime Around OSU</title>'
    f.puts '    <meta charset="utf-8" />'
    f.puts '  </head>'
    f.puts '  <body>'
    create_table f, notices
    add_image f, 'crime_time.png', 'Hot Time for Crimes'
    create_footer f
  end

  # Create Table
  def create_table(f, notices)
    f.puts '    <table border="1">'
    f.puts '    <caption><b>Important Neighborhood Crime Information Around OSU</b></caption>'
    f.puts '    <tr>'
    f.puts '      <th>Date</th>'
    f.puts '      <th>Location</th>'
    f.puts '      <th>Time</th>'
    f.puts '      <th>Additional Information</th>'
    f.puts '    </tr>'
    output_rows f, notices
    f.puts '    </table>'
  end

  # creates footer for html table
  def create_footer(f)
    f.puts '  </body>'
    f.puts '</html>'
    f.close
  end

  # puts all rows for table with information
  def output_rows(f, notices)
    notices.each do |notice|
        #Only output crime notices information if all information is available
        unless notice.date.nil? || (notice.location.nil? || notice.location.length == 0) || notice.time.nil? || notice.description.nil?
            f.puts '    <tr>'
            f.puts "      <td>#{notice.date}</td>"
            f.puts "      <td>#{notice.location.join ' '}</td>"
            f.puts "      <td>#{notice.time}</td>"
            f.puts "      <td>#{notice.description}</td>"
            f.puts '    </tr>'
        end
    end
  end

  # adds an image
  def add_image(f, source, alt)
    f.puts "    <img src = #{source} alt = #{alt} width = \"800\" height = \"500\">"
  end
end
