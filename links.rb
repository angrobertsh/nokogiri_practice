require 'nokogiri'
require 'open-uri'
require 'byebug'

def scrape(url, hash = {})
  puts "top of method"
  doc = Nokogiri::HTML(open(url))

  arr = []

  doc.css('a').each do |link|
    begin
      puts link.attributes["href"].value
      if(!hash[link.attributes["href"].value])
        hash[link.attributes["href"].value] = true
        open(link.attributes["href"].value) do |f|
          puts "it's going #{link.attributes["href"].value}"
          if(f.status[0] == "200")
            arr += scrape(link.attributes["href"].value, hash)
          end
          arr << [link.attributes["href"].value, f.status[1]]
        end
      end
    rescue
      arr << [link.attributes["href"].value, "404"]
    end
  end

  return arr

end

scrape("https://scottduane.github.io/TopSecretClue/")
