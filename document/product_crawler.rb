class ProductCrawler
  attr_accessor :doc

  def initialize(doc)
    @doc = doc
  end

  def name
    humanize @doc.css('div.page-title-wrapper')
  end

  def price
    humanize @doc.css('div.product-info-main span.price')
  end
  
  def description
    humanize @doc.css('div.description')
  end

  def more_info
    table = @doc.css('table.additional-attributes tbody')
    data = []
    table.text.strip.split("\n").each_slice(2) do |row|
      key = row[0]&.strip 
      value = row[1]&.strip
      if key.size > 0
        data << "#{key}: #{value}"
      end
    end
    data.join(' | ')
  end

  private
  def humanize(text)
    text.text.strip.split("\n")[0]
  end
end