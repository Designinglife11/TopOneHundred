class TopOneHundred::CLI

    def start #CLI instance method that the user uses to interact
        puts "Top 100 Movies:"
        puts "/n"
        user_input = "y"
        movie_list = TopOneHundred.print_movie_list
        scraper = TopOneHundred::Scraper.new

    while user_input = "y"
        movie = scraper.initializer
        movie.print_details
        puts "Do you want to know more about #{movie.title}?"
        puts "please type 'y' for yes or 'n' for no."
        user_input = movie.response
        while user_input == 'y'
            movie.ask_user
            user_input = movie.response
            if user_input == 1
              movie.print_tagline
            elsif user_input == 2
              movie.print_plot
            elsif user_input == 3
              movie.print_trivia
            elsif user_input == 4
              movie.print_quotes
            elsif user_input == 5
              movie.print_cast
            end

            puts "Would you like to know more about #{movie.title}?"
            puts "Pleae enter 'y' for yes or 'n' for no."
            user_input = movie.y_n_response
        end
        puts "Okay, exiting #{movie.title} now..."
	    puts "Would you like to research another movie?"
        puts "Please enter 'y' for yes or 'n' for no"
        user_input = movie.y_n_response
	    end

        if userinput == "y"
            movie_list
        end
        puts "Thank you for checking out IMDB's Top 100 Movies."
    end

    #CLI instance methos that initializes and prints the top 100 movies from IMDB.
    def basic_generate_all
      puts "This is IMDb's Top 100 Movie List."
      scraper = TopOneHundred::Scraper.new
      all_movies = scraper.initialize_all_movies
      all_movies.each{|movie| movie.print_details}
      all_movies
    end
   