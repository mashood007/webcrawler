require 'nokogiri'
require 'open-uri'

class Crawler
  def initialize(url)
    @url = url
    @html = open(@url)
  end

  def response
    Nokogiri::HTML(@html)
  end

end