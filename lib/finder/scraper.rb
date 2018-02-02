class RecipeFinder::Scraper

  def get_page(search_item)
    url = "http://allrecipes.com/search/results/?wt="+ search_item + "&sort=re&page=1"
    Nokogiri::HTML(open(url))
  end

  def scrape_items_index(search_item)
    recipes = self.get_page(search_item).css(".grid-col--fixed-tiles:not(.grid-ad)")
    recipes.select{|ele| ele.at_css(".grid-col__ratings span")}
  end

  def make_items(search_item)
    scrape_items_index(search_item).each do |item|
      RecipeFinder::Dish.new_from_index_page(item)
    end
  end

  def more_info(dish)
    dish.add_info(Nokogiri::HTML(open(dish.url)))
  end
end
