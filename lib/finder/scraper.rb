class FindAnything::Scraper

  def get_page(search_item, zipcode)
    Nokogiri::HTML(open("https://www.yelp.com/search?find_desc=#{search_item}&find_loc=#{zipcode}"))
  end

  def scrape_items_index(search_item, zipcode)
    self.get_page(search_item, zipcode).css("li.regular-search-result")
  end

  def make_items(search_item, zipcode)
    scrape_items_index(search_item, zipcode).each do |item|
      FindAnything::Items.new_from_index_page(item)
    end
  end
end
