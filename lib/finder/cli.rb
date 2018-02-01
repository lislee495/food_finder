class RecipeFinder::CLI

  def call
    puts "Welcome to Find Anything! Where you can quickly FindAnything you want near you"
    start
  end

  def start
    puts ""
    puts "What are you looking for?"
    search_item = gets.strip
    RecipeFinder::Scraper.new.make_items(search_item)
    last_ten = RecipeFinder::Dish.all.slice(-9)
    print_items(last_ten)

    puts "Would you like to see more info about one of these? Enter its name, or No."
    more_info = gets.strip.downcase
    if moreInfo != "no"
      specific_item = RecipeFinder::Dish.find_by_name(name)
      print_item(specific_item)
    else
      puts "Would you like to search for something else? Enter Yes or No."
      restart_input = gets.strip.downcase
      if restart_input == "yes"
        start
      else
        puts ""
        puts "Thank you for using this gem!"
        puts "Hope you FindAnything again."
        exit
      end
    end
  end

  def print_items(itemsArray)
    itemsArray.each do |item|
      puts ""
      puts "----------- #{item.name.titleize}-----------"
      puts ""
      puts "Location:           #{item.location}"
      puts "Contact:            #{item.contact}"
    end
  end

  def print_item(item)
    puts ""
    puts "----------- #{item.name.titleize}-----------"
    puts ""
    puts "Location:            #{item.location}"
    puts "Contact:             #{item.contact}"
    puts "Price:               #{item.price}"
    puts "Categories:          #{item.categories}"
  end
end
