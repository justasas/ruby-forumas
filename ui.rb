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
    File.open('app.yaml', 'w') do |file|
      file.puts YAML::dump($app)
    end
  end

  def view_users
    $app.accounts.each do |user|
      puts 'user: ' + user.name + '  email: ' + user.email + '  birth year: ' +
        user.birth_year + '  privilege: ' + user.privilege 
    end
  end
  
  def view_forums
    i = 0
    j = 0
    $app.categories.each do |categorie|
      puts j.to_s + '  ' + categorie.name
      j = j + 1
      categorie.forums.each do |forum|
        puts '  ' + i.to_s + '  ' + forum.title
        i = i + 1
      end
    end
  end

  def view_topics(category_id, forum_id)
    i = 0
    $app.categories[category_id].forums[forum_id].topics.each do |topic|
      puts 'topic id: ' + i.to_s + ' topic title: ' + topic.title
      i = i + 1
    end
  end

  def view_replies(category_id, forum_id, topic_id)
    i = 0
    $app.categories[category_id].forums[forum_id].topics[topic_id]
      .replies.each do |reply|
      puts 'reply id: ' + i.to_s + ' reply owner: ' + reply.owner.name +
        ' reply date: ' + reply.time +
        ' last edit by: ' + reply.last_edit_owner.name + ' last edit time: ' +
        reply.last_edit_time
      reply.quotes.each do |quote|
      puts '--quotes--' + '  reply id: ' + i.to_s + '  reply owner: ' + quote.owner.name +
        '  reply date: ' + quote.time +
        '  last edit by: ' + quote.last_edit_owner.name + '  last edit time: ' +
        quote.last_edit_time
      end
      i = i + 1
      puts ' reply text: ' + reply.text
    end
  end

  def topic_menu(category_id, forum_id, topic_id)
    view_topics(category_id, forum_id)
    puts 'Please select:'
    puts '1 to add reply'
    puts '2 to add reply with quotes'
    puts '3 to remove reply' if $user.privilege == 'Administrator'
    puts '4 to edit reply'
    puts '5 to add rating to the topic'

    case gets.strip
    when '1'
      puts 'Input reply text'
      reply_text = gets
      reply = Reply.new $user, reply_text 
      $app.categories[category_id].forums[forum_id].topics[topic_id]
        .add_reply(reply)
      topic_menu(category_id, forum_id, topic_id)
    when '2'
      puts 'Input reply text'
      reply_text = gets
      puts 'Input reply id you want to quote'
      reply_id = gets.to_i
      quote = $app.categories[category_id].forums[forum_id].topics[topic_id]
        .replies[reply_id]
      reply = Reply.new $user, reply_text, quote
      $app.categories[category_id].forums[forum_id].topics[topic_id]
        .add_reply(reply)
      topic_menu(category_id, forum_id, topic_id)
    when '3'
      puts 'Input reply id'
      reply_id = gets.to_i
      $app.categories[category_id].forums[forum_id].topics[topic_id]
        .remove_reply($user, reply_id)
      topic_menu(category_id, forum_id, topic_id)
    when '4'
      puts 'Input reply id'
      reply_id = gets.to_i
      puts 'Input reply text'
      reply_text = gets
      $app.categories[category_id].forums[forum_id].topics[topic_id]
        .edit_reply($user, reply_id, text)
      topic_menu(category_id, forum_id, topic_id)
    when '5'
      while (!(rating = gets.to_i).between?(1, 5)) do
        puts 'Input number from 1 to 5'
      end
      $app.categories[category_id].forums[forum_id].topics[topic_id]
        .add_rating($user, rating)      
    when '15'
      e
    else
      puts 'Bad choice..Try again!'
      topic_menu(category_id, forum_id)
    end
  end

  def forum_menu(category_id, forum_id)
    view_topics(category_id, forum_id)
    puts 'Please select:'
    puts '1 to create topic'
    puts '2 to delete topic'
    puts '3 to access topic'

    case gets.strip
    when '1'
      puts 'Input topic name'
      name = gets
      puts 'Input first reply'
      reply_text = gets
      reply = Reply.new $user, reply_text 
      topic = Topic.new name, [reply]
      $app.categories[category_id].forums[forum_id]
        .create_topic(topic)
      forum_menu(category_id, forum_id)    
    when '2'
      puts 'Input topic id'
      topic_id = gets.to_i
      $app.categories[category_id].forums[forum_id]
        .delete_topic(topic_id, $user)
      forum_menu(category_id, forum_id)    	  	
    when '3'
      puts 'Input topic id'
      topic_id = gets.to_i
      topic_menu(category_id, forum_id, topic_id)
    when '15'
      e
    else
      puts 'Bad choice..Try again!'
      forum_menu(category_id, forum_id)
    end
  end

  def start_menu
    puts 'Please select:'
    puts '1 for new account registration'
    puts '2 for log in'
    puts '3 for accessing a forum'
    puts '4 to create a new category'
    puts '5 to delete a category'
    puts '6 to create a new forum'
    puts '7 to delete a forum'
    puts '8 to view registered users'
    # puts "6 to view users'
    puts '15 to exit'

    case gets.strip
    when '1'
      puts "Input account's name"
      name = gets  
      puts "Input account's pass"
      pass = gets
      puts 'Input your email'
      email = gets
      puts 'Input your birth year'
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
        print '                                           Hello,' + $user.name
        $user.privilege.delete!("\n")
      else
        puts 'aaaaaa'
        $user = nil
      end
      start_menu
    when '3'
      view_forums()
      puts 'Input category id'
      category_id = gets
      if category_id == "back\n"
        start_menu
      end
      category_id = category_id.to_i
      puts 'Input forum id'
      forum_id = gets.to_i
      forum_menu(category_id, forum_id)
    when '4'
      puts 'Input category name'
      name = gets
      puts 'Input category description'
      description = gets
      category = Category.new name, description
      $user.privilege.delete!("\n")
      $app.add_category(category, $user)
      start_menu
    when '5'
      view_forums()
      puts "Input category id\n"
      category_id = gets.to_i
      $user.privilege.delete!("\n")
      $app.remove_category(category_id, $user)
      start_menu
    when '6'
      puts 'Input forum name'
      name = gets
      puts 'Input forum description'
      description = gets
      puts 'Input category id'
      category_id = gets.to_i
      forum = Forum.new name, description
      $user.privilege.delete!("\n")
      $app.categories[category_id].add_forum(forum, $user)
      start_menu
    when '7'
      view_forums()
      puts 'Input category id'
      category_id = gets.to_i
      puts 'Input forum id'
      forum_id = gets.to_i
      $user.privilege.delete!("\n")
      $app.categories[category_id].remove_forum(forum_id, $user)
      start_menu
    when '8'
      view_users
    when '15'
      e()
    else
      puts 'Bad choice'
      start_menu
    end
  end
end

$app = YAML::load_file('app.yaml')
# Internet_forum.new('title', 'description', 'admin')
$user = Account.new 'vardas', 'slapt', 'pastas', 'year'
$user.privilege = 'Administrator'

UI.new
