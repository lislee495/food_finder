class RecipeFinder::Scraper

  def get_page(search_item)
    url = "http://www.geniuskitchen.com/search/" + search_item
    Nokogiri::HTML(open(url))
  end

  def scrape_items_index(search_item)
    self.get_page(search_item).css(".fd-recipe")
  end

  def make_items(search_item)
    scrape_items_index(search_item).each do |item|
      RecipeFinder::Dish.new_from_index_page(item)
    end
  end
end
