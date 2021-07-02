require './services/crawler'
require './document/product_crawler'
require './models/product'
require 'pry'

class Controller
  class << self
    def main
      puts "=====Web Crawler====="
        p "1. Show all", "2. Take breathe-easy-tank", "3. Take radiant-tee", "4. Enter item url", "5. Exit"
        answer = gets.chomp.to_i
      case answer
      when 1
        render_products
      when 2
        breathe_easy_tank
      when 3
        radiant_tee
      when 4
        custom
      when 5
        puts "Good Bye"
        exit  
      else
        puts 'Wrong command, try again'
      end
        main
      end
    def render_products
      Product.all  
    end

    def breathe_easy_tank
      url = 'http://magento-test.finology.com.my/breathe-easy-tank.html'
      get_crawel(url)
    end

    def radiant_tee
      url ='https://magento-test.finology.com.my/radiant-tee.html'
      get_crawel(url)
    end

    def custom
      puts "enter url"
      url = gets.chomp
      get_crawel(url)
    end

    def get_crawel(url)
      @crawler = Crawler.new(url)
      doc = @crawler.response.css('div.main')
      @product_crawler = ProductCrawler.new(doc)
      p @product_crawler.name, @product_crawler.price, @product_crawler.description, @product_crawler.more_info
      puts 'Do you want to store the item into DB (Y/N)'
      answer = gets.chomp
      if answer == 'Y'
        @product = Product.new(product_params)
        @product.save
      else
        '......'
      end
    end

    def product_params
      "\'#{@product_crawler.name}\', #{@product_crawler.price.delete('$').to_f}, \"#{@product_crawler.description.gsub("'", "")}\", \"#{@product_crawler.more_info}\""
    end
  end
end