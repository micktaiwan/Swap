namespace :user do

  desc "Create a new user."
  task :create => :environment do
    puts "Name: "
    name     = STDIN.gets.chomp
    
    puts "Email: "
    email    = STDIN.gets.chomp
    
    puts "Password: "
    password = STDIN.gets.chomp

    user = User.new(:name => name, :email => email, :password => password, :password_confirmation => password)
    user.save
    
    if user.errors.empty?
      puts "User #{name} created: ##{user.id}"
    else
      puts user.errors.full_messages
    end  
  end

end

