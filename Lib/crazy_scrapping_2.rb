require 'nokogiri'
require 'open-uri'

PAGE_URL1 = "https://www.annuaire-des-mairies.com/95/avernes.html"
PAGE_URL2 = "http://annuaire-des-mairies.com/val-d-oise.html"



########## one_townhall_email_selection ##########
def get_townhall_email(page1)
    townhall_email = page1.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
    return townhall_email.text
end



########## 95_townhalls_urls_selection ##########
def get_95_townhalls_urls(page2)
    townhalls_urls = page2.xpath('//a[contains(@class, "lientxt")]/text()').map {|x| x.to_s.downcase.gsub(" ","-") }
    return townhalls_urls
end
########## 95_townhalls_emails_selection ##########
def get_95_townhalls_emails(townhalls_urls)
    array_95_emails = []
    townhalls_urls.each do |counter|
    page3 = Nokogiri::HTML(URI.open("https://www.annuaire-des-mairies.com/95/#{counter}.html"))
    array_95_emails << page3.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
    end
    return array_95_emails
end


########## final_protocol ##########
def perform
    page1 = Nokogiri::HTML(URI.open(PAGE_URL1))
    page2 = Nokogiri::HTML(URI.open(PAGE_URL2))
    townhall_email = get_townhall_email(page1)
    townhalls_urls = get_95_townhalls_urls(page2)
    array_95_emails = get_95_townhalls_emails(townhalls_urls)
    puts townhalls_results = Hash[townhalls_urls.zip(array_95_emails)]
    
end



########## activation ##########
perform


