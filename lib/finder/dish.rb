class RecipeFinder::Dish
  attr_accessor :name, :stars, :time, :url

  @@all = []

  def self.new_from_index_page(search_terms)
    puts search_terms
    self.new(
      search_terms.css(".title a").text,
      search_terms.css(".fd-rating-percent").xpath('@style').text,
      search_terms.css(".cook-time").text,
      search_terms.css(".title a").xpath('@href').text,
      )
  end

  def initialize(name, stars=nil, time, url)
    @name = name
    @stars = stars
    @time = time
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.detect {|dish| dish.name == name}
  end
end
