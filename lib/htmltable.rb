require_relative 'scraper'

# class for html table
class Htmltable
  # Function to create header for html table
  # Parameter f: file to add header to
  # Paramter notices: links to articles to pull data from
  def create_page(f, notices)
    f.puts '<!DOCTYPE html>'
    f.puts '<html lang ="en"> '
    f.puts '  <head>'
    f.puts '    <title>Neighborhood Crime Around OSU</title>'
    f.puts '    <meta charset="utf-8" />'
    f.puts '    <link rel="stylesheet" type="text/css" href="lib/globalstyle.css" />'
    f.puts '  </head>'
    f.puts '  <body>'
    # function call to create and add data to table
    create_table f, notices
    f.puts '    <div class="graph-container">'
    add_image f, 'lib/graphs/crime_time.png', 'Hot Time for Crimes'
    add_image f, 'lib/graphs/num_crimes.png', 'Number of Crimes Each Year'
    f.puts '    </div>'
    # function call to add footer to file to close tags
    create_footer f
  end

  # Function to create table
  # Parameter f: file to add header to
  # Paramter notices: links to articles to pull data from
  def create_table(f, notices)
    f.puts '    <h1 class="title">Important Neighborhood Crime Information Around OSU</h1>'
    f.puts '    <table border="1">'
    f.puts '    <tr>'
    f.puts '      <th class="header"><h3>Date</h3></th>'
    f.puts '      <th class="header"><h3>Location</h3></th>'
    f.puts '      <th class="header time"><h3>Time</h3></th>'
    f.puts '      <th class="header"><h3>Additional Information</h3></th>'
    f.puts '    </tr>'
    output_rows f, notices
    f.puts '    </table>'
  end

  # Function to create footer for html table
  # Parameter f: file to add header to
  def create_footer(f)
    f.puts '  </body>'
    f.puts '</html>'
    f.close
  end

  # Function to put all rows for table with information
  # Parameter f: file to add header to
  # Paramter notices: links to articles to pull data from
  def output_rows(f, notices)
    notices.each do |notice|
      # Only output crime notices information if all information is available
      if notice.date.nil? || (notice.location.nil? || notice.location.length == 0) || notice.time.nil? || notice.description.nil?
        next
      end

      f.puts '    <tr>'
      f.puts "      <td class=\"data\">#{notice.date}</td>"
      f.puts "      <td class=\"data location\">#{notice.location.join ' '}</td>"
      f.puts "      <td class=\"data\">#{notice.time}</td>"
      f.puts "      <td class=\"data description\">#{notice.description}</td>"
      f.puts '    </tr>'
    end
  end

  # Function to add image to html
  # Parameter f: file to add header to
  # Parameter source: stored source of image
  # Parameter alt: stored alt for users unable to see image
  def add_image(f, source, alt)
    f.puts "      <img class=\"graph\" src = #{source} alt = #{alt}>"
  end
end
