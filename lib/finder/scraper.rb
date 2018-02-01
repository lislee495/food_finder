class Recipe::Scraper

  def get_page(search_item)
    url = "http://allrecipes.com/search/results/?wt="+search_item+"&sort=re"
    puts url

    begin
      Nokogiri::HTML(open(url))
    rescue OpenURI::HTTPError => error
      response = error.io
      puts response.status
      # => ["503", "Service Unavailable"]
      puts response.string
      # => <!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\n<html DIR=\"LTR\">\n<head><meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"initial-scale=1\">...
    end
  end

  def scrape_items_index(search_item)
    self.get_page(search_item).css("li.regular-search-result")
  end

  def make_items(search_item)
    scrape_items_index(search_item).each do |item|
      FindAnything::Item.new_from_index_page(item)
    end
  end
end
