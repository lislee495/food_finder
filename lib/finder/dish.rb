class RecipeFinder::Dish
  attr_accessor :name, :stars, :description, :url, :ingredients, :instructions, :time

  @@all = []

  def self.new_from_index_page(search_terms)
    self.new(
      search_terms.css(".grid-col__h3.grid-col__h3--recipe-grid a").text.strip,
      search_terms.at_css(".grid-col__ratings span")["data-ratingstars"],
      search_terms.css(".rec-card__description").text,
      search_terms.at_css(".grid-col__h3.grid-col__h3--recipe-grid a")["href"]
      )
  end

  def initialize(name, stars=nil, description, url)
    @name = name
    @stars = stars
    @description = description
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find(id)
    self.all[id - 1]
  end

  def self.reset
    @@all = []
  end

  def add_info(page)
    self.ingredients = []
    self.instructions = []
    self.time = []
    page.css(".recipe-ingred_txt.added")[0..-3].each {|ele| self.ingredients << ele.text}
    page.css(".recipe-directions__list--item").each {|ele| self.instructions << ele.text}
    page.css(".prepTime__item time").each {|ele| self.time << ele["datetime"]}
  end

  def self.show(place)
    if place == "first"
      self.all[0..9]
    elsif place == "next"
      self.all[10..(self.all.length-1)]
    end
  end
end
