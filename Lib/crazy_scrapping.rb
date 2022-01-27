require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "https://coinmarketcap.com/all/views/all/"



########## crypto_names ##########
def import_crypto_names(page)
    array_names = []
    crypto_names = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/*/td[2]/div/a[2]')
    crypto_names.each do |counter|
    array_names << counter.text
    end
    return array_names
end


########## crypto_values ##########
def import_crypto_values(page)
    array_values = []
    crypto_values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[@class="cmc-table-row"]/td[5]/div/a/span')
    crypto_values.each do |counter|
    array_values << counter.text.delete("$,").to_f
    end
    return array_values
end

########## hash_pushing ##########
def hash_pushing(array_names,array_values)
    hash_names_and_values = Hash[ array_names.zip(array_values) ]
    return hash_names_and_values
end


########## final_protocol ##########
def perform
    page = Nokogiri::HTML(URI.open(PAGE_URL).read)
    array_names = import_crypto_names(page)
    array_values = import_crypto_values(page)
    #puts array_names
    #puts array_values
    hash_names_and_values = hash_pushing(array_names,array_values)
    puts hash_names_and_values
end

########## activation ##########
perform
