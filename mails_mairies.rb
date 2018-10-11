
require 'rubygems'
require 'nokogiri'
require 'open-uri'


# je choppe tous mes noms de commune : étape 1 
# je les downcase et les capitalise (pour leur donner un joli nom)
# je leur mets des tirets pour les rendre utilisables dans un url
# je les insère dans un url (qui seront tous dans un array)
# je déf une méthode qui va scrapper tous les url en question (de mon array précédent)


    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
   	villes = doc.css("a.lientxt").map do |keys|
	keys.text

end

# J'ai toutes mes villes  : ETAPE 1 DONE


def downcasing(string)

	string.map do |key|
		key.downcase.capitalize
	end

end

noms_propres = downcasing(villes)

# J'ai mes villes en propres ! : ETAPE 2 DONE


def getting_usable(string)

	string.map do |key|
		key.downcase.tr(" ", "-")
	end

end

usable_names = getting_usable(noms_propres)

# J'ai mes villes utilisables pour les URLs : ETAPE 3 DONE

def insert_url(string)

	string.map do |key|
		"http://annuaire-des-mairies.com/95/#{key}.html"
	end

end

urls = insert_url(usable_names)

# J'ai tous mes URLs : ETAPE 4 DONE

def mails_mairies(string)

	string.map do |key|
		page = Nokogiri::HTML(open(key))
		mails = page.css("body > div > main > section:nth-child(2) > div > table > tbody > tr:nth-child(4) > td:nth-child(2)")
		
		mails.text

	end

end

les_beaux_mails = mails_mairies(urls)

def putting_in_hash(ville, mail)

	Hash[ville.zip(mail)]

end

my_hash = putting_in_hash(noms_propres, les_beaux_mails)

puts my_hash
