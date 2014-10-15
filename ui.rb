require_relative 'forum'
require_relative 'category'
require_relative 'topic'
require_relative 'reply'
require_relative 'account'
require_relative 'internet_forum'
require 'yaml'

class UI
  def initialize
    start_menu
  end

  def e
    File.open("app.yaml", "w") do |file|
      file.puts YAML::dump($app)
    end
  end

  def view_forums
    $app.categories.each do |categorie|
      puts categorie.name + "\n"
      categorie.forums.each do |forum|
        puts '  ' + forum.id + '  ' + forum.title + "\n" 
      end
    end
  end

  def view_topics(forum_id)
    # $app.categories.foru
  end

  def forum_menu(forum_id)
    view_topics
    puts "Please select:\n"
    puts "1 to access topic\n"

    case gets.strip
    when "1"
    
    when "2"

    when "3"
    
    else
      puts "Bad choice..Try again!"
      forum_menu
    end
  end

  def start_menu
    puts "Please select:\n"
    puts "1 for new account registration\n"
    puts "2 for log in\n"
    puts "3 for accessing a forum\n"
    puts "4 to create a new category\n"
    puts "5 to delete a category\n"
    puts "6 to create a new forum\n"
    puts "7 to delete a forum\n"
    # puts "6 to view users\n"
    puts "15 to exit\n"

    case gets.strip
    when '1'
      puts "Input account's name\n"
      name = gets  
      puts "Input account's pass\n"
      pass = gets
      puts "Input your email\n"
      email = gets
      puts "Input your birth year\n"
      year = gets
      user = Account.new name, pass, email, year
      $app.register_new_user(user)
      start_menu
    when '2'
      puts "Input account's name\n"
      name = gets  
      puts "Input account's pass\n"
      pass = gets
      $user = $app.log_in(name, pass)
      if $user.instance_of?(Account)
        puts 'Hello,' + $user.name
      else
        puts 'aaaaaa'
        $user = nil  
      end
      start_menu
    when '3'
      view_forums()
      puts "Input forum id\n"
      forum_id = gets
      forum_menu(forum_id)
    when '4'
      puts "Input category name\n"
      name = gets
      puts "Input category description\n"
      description = gets
      category = Category.new name, description
      $app.add_category(category, $user)
      start_menu
    when '5'
      puts "Input category id\n"
      category_id = gets  
      $app.remove_category(category_id, $user)
      start_menu
    when '6'
      puts "Input forum name\n"
      name = gets
      puts "Input forum description\n"
      description = gets
      forum = Forum.new name, description
      $app.add_forum(forum, $user)
      start_menu
    when '7'
      puts "Input forum id\n"
      forum_id = gets
      remove_forum(forum_id, $user)
      start_menu
    when '15'
      e()
    else
      puts "Bad choice"
      start_menu
    end
  end
end

$app = YAML::load_file('app.yaml') #Internet_forum.new('title', 'description', 'admin')
$user = nil

UI.new
