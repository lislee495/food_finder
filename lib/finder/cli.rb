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
    show_list("first")
  end

  def print_items(itemsArray)
    itemsArray.each do |dish|
      puts ""
      puts "#{RecipeFinder::Dish.all.index(dish) + 1}.----------- #{dish.name} -----------"
      puts ""
      puts "Stars:           #{dish.stars.to_f.round(2)}"
      puts "Description:     #{dish.description}"
      puts "URL:             #{dish.url}"
    end
  end

  def print_item(dish)
    puts ""
    puts "----------- #{dish.name} -----------"
    puts ""
    puts "Stars:            #{dish.stars.to_f.round(2)}"
    puts "Description:      #{dish.description}"
    puts "URL:              #{dish.url}"
    puts ""
    puts "Ingredients: #{dish.ingredients.join(", ")}"
    puts ""
    puts "Prep Time: #{dish.time[0].slice(2, dish.time[0].length)}"
    puts "Cook Time: #{dish.time[1].slice(2, dish.time[1].length)}"
    puts "Ready in:  #{dish.time[2].slice(2, dish.time[2].length)}"
    puts ""
    puts "Instructions:"
    dish.instructions.each do |ele|
      puts ""
      puts "#{ele}"
    end
    puts "To go back, type 'back'. To exit, type 'exit'"
  end
end

def show_list(num)
  five = RecipeFinder::Dish.show(num)
  print_items(five)
  puts "Would you like to see more info about one of these? Enter its number, or no."
  more_info = gets.strip
  if more_info != "no"
    index = more_info.to_i
    specific_item = RecipeFinder::Dish.find(index)
    RecipeFinder::Scraper.new.more_info(specific_item)
    print_item(specific_item)
    next_action = gets.strip
    if next_action == "exit"
      ending
    else
      show_list(num)
    end
  else
    if (num == "first")
      puts "Wants to see more search results? Enter yes or no."
      more_results = gets.strip
      if more_results != "no"
        show_list("next")
      else
        repeat_end
      end
    else
      repeat_end
    end
  end
end

def repeat_end
  puts "Would you like to search for something else? Enter yes or no."
  restart_input = gets.strip
  if restart_input == "yes"
    RecipeFinder::Dish.reset
    start
  else
    ending
  end
end


def ending
  puts ""
  puts "Thank you for using this gem!"
  puts "Hope you RecipeFinder again."
  exit
end
