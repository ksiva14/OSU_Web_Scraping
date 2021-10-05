# PG3901-Project3_WebScraping

## Description
This project is focused on scraping the OSU Department of Public Safety website (https://dps.osu.edu/news?tag%5B15%5D=15). This project gets Neighborhood Safety Notices and displays them to the user. An html file is created for the user to see the date, location, time, and description of a crime that happened around OSU campus. At the bottom of the page, a graph of most common times for crimes, and a graph of the number of crimes each year, can be found. 

## Contributors
[Zheng Ji Tan](https://github.com/Just-ZJ), [Karthick Sivasubramanian](https://github.com/ksiva14), [Tyler Frantz](https://github.com/tylerfrantz), [Justin King](https://github.com/jking3019)

## Install
Make sure you have installed
- ruby | [Course Website](http://web.cse.ohio-state.edu/~giles.25/3901/resources/vm-install.html) | [Official Website](https://www.ruby-lang.org/en/documentation/installation/)
- [mechanize](https://www.rubydoc.info/gems/mechanize/Mechanize):
```
gem install mechanize
```

- [nokogiri](https://rubygems.org/gems/nokogiri):
```
gem install nokogiri
```

- [gruff](https://www.rubydoc.info/github/topfunky/gruff):
```
sudo apt-get install libmagickwand-devlibsdl2-ttf-dev
gem install gruff
```


## How to Use
  *  To run the program, use the following command:

    ruby main.rb

A file named `index.html` will be created and can be opened in any web browser.
 
## Challenges Faced
Many challenges were faced when creating this project. Trying to not flood OSU servers with requests was a big issue to work around. Formats for how streets were listed differed among articles, making it difficult to hardcode a way to scrape this data. Learning new gems like gruff proved time consuming. 

## Future Technologies
If we had more time, we would want to add a couple things to our project.
 * Allow the user to input a date range to show things like past or recent crimes
 * Allow the user to input a region of campus to see if there is a lot of crime in area they are potentially moving into
 * Add a function to show the severity of the crime. Was someone hurt, killed, unharmed, etc.. 

## Test Cases
Make sure you have installed
- [minitest](https://docs.ruby-lang.org/en/2.0.0/MiniTest.html#module-MiniTest-label-INSTALL-3A)
```
gem install minitest
```
  *  To run the test cases, run the following commands:

    ruby test/test_graph.rb 
    ruby test/test_notice.rb 
    ruby test/test_page.rb 
    ruby test/test_scraper.rb 

