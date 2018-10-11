#id-bitcoin > td.no-wrap.currency-name > a
require 'rubygems'
require 'nokogiri'
require 'open-uri'


def cryptos
    
    page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
    nom = page.css("td.no-wrap.currency-name > a").map do |key|
        
    key.text
    end
    
    page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
    cours = page.css("a.price").map do |key2|

    key2.text
    end
    
    hash = Hash[nom.zip(cours)]
    puts hash

end

cryptos
