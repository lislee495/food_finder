class FindAnything::Item
  attr_accessor :name, :location, :categories, :price, :contact

  @@all = []

  def self.new_from_index_page(search_terms)
    self.new(
      search_terms.css("a.biz-name.js-analytics-click").text,
      search_terms.css("search-result_tags").text,
      search_terms.css("address").text,
      search_terms.css(".business-attribute.price-range").text,
      search_terms.css(".biz-phone").text
      )
  end

  def initialize(name=nil, categories=nil, location=nil, price=nil, contact=nil)
    @name = name.downcase
    @categories = categories
    @location = location
    @price = price
    @contact = contact
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(name)
    self.all.detect {|item| item.name == name}
  end
end
