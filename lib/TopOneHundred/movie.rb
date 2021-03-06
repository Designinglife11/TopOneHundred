class TopOneHundred::Movie

    #class variables
    @@viewed = []

    #attr reader variables that scrape details from IMDB
    attr_reader :ranking, :genre, :index, :title, :director, :length, :release_date, :rating, 
    
    #attr reader variables that scrapes details from selected movie from IMDB
    attr_reader :cast, :tagline, :quotes, :trivia, :plot

    #initializes with details from IMDB
    def initialize(ranking = nil) 
        if ranking = nil
            user_input
        else
            @ranking = ranking
        end
        @genre = genre
        @title = title
        @release_date = release_date
        @director = director
        @length = length
        @rating = rating
        save
        self
    end

    #initializes methods requiring user input
    def needed_input(user_input)
        if user_input >= 1 && user_input <= 100
            true
        else
            false
        end
    end

    def user_input
        puts "Enter a movie ranking, between 1 and 100."
        user_input = (gets.strip).to_i

        if needed_input(user_input) == true
            @ranking = user_input
        else
            while needed_input(user_input) != true
                puts "Please enter a number between 1 and 100."
                user_input = (gets.strip).to_i
            end
            @ranking = user_input
        end
        @ranking
    end

    #index page details
    def index
        @imdb_ranking.to_i - 1
    end 
      
    def index_page
        TopOneHundred::Scraper.new.index_page
    end

    def rating
        index_page.css("span.certificate")[index].text.strip
    end

    def genre
        index_page.css("span.genre")[index].text.strip
    end
      
    def title
        index_page.css("h3.lister-item-header a")[index].text.strip
    end
      
    def director
        index_page.css("p + p.text-muted.text-small > a:first-child")[index].text.strip
    end
      
    def release_date
        index_page.css("h3.lister-item-header span.lister-item-year.text-muted.unbold")[index].text.strip.gsub("(","").gsub(")","")
    end
      
    def length
        index_page.css("span.runtime")[index].text.strip
    end
  
      
    #prints all the details scraped for the user
    def print_details 
        puts "IMDb Top 100 Ranking: #{imdb_ranking}\nMovie title: #{title}\nDirected by: #{director}\nReleased in: #{release_date}\nGenre(s): #{genre}\nRated: #{rating}\nRuntime: #{length}"
    end

    #details from selected movie IMDB page
    def movie_page
        TopOneHundred::Scraper.new.movie_page(self)
    end

    def trivia_page
        TopOneHundred::scraper.new.trivia_page(self)
    end

    def quotes_page
        TopOneHundred::Scraper.new.quotes_page(self)
    end

    def ask_user
        puts "Enter 1 for #{title}'s tagline."
        puts "Enter 2 for #{title}'s plot."
        puts "Enter 3 to learn random trivia about #{title}"
        puts "Enter 4 for quotes from #{title}."
        puts "Enter 5 if you'd like to know the cast of #{title}."
    end

    def response
        user_input = gets.strip.to_i
        if user_input != (1, 2, 3, 4, 5)
            puts "Please enter a number between 1 and 5."
            user_input = gets.strip.to_i
        end
        user_input
    end

    def tagline
        movie_page.css("div.txt-block")[0].text.split("\n")[2].to_s.strip
    end
     
    def print_tagline
        puts "Tagline: #{tagline}"
    end

    def plot
        unedited_plot = movie_page.css(".inline.canwrap").text.strip
        plot = unedited_plot.slice(0, unedited_plot.index("Written by")).strip
    end
      
    def print_plot
        puts "Plot: #{plot}"
    end

    def cast
        actors = []
        cast_array = movie_page.css("table.cast_list td.primary_photo + td a")
        cast_array.collect{|actor| actors << "\n" + actor.text.strip}
        actors.join(' ')
    end
      
    def print_cast
        puts "The cast: #{cast}"
    end

    def trivia
        trivia = []
        trivia_array = trivia_page.css("div.sodatext")
        i = 1
        trivia_array.collect{|trivium| 
          trivia << "Trivia ##{i}: #{ActionView::Base.full_sanitizer.sanitize(trivium.to_s.strip)}"
          i+=1
        }
        trivia
    end

    def y_n_response
		"Please enter 'y' for yes and 'n' for no."
		user_input = gets.strip.downcase
		while user_input != 'y' && user_input != 'n'
			puts "Invalid response."
			puts "Please enter 'y' for yes and 'n' for no."
			user_input = gets.strip.downcase
		end
	    user_input
	end

    def quotes
        quotes = []
        quotes_array = quotes_page.css("div.sodatext")
        i = 1
        quotes_array.collect{|quote| 
          quotes << "Quote ##{i}: #{ActionView::Base.full_sanitizer.sanitize(quote.to_s.strip)}"
          i+=1
        }
        quotes
      end

      #method that save movies to the @@viewed class variable
      def self.viewed
        @@viewed
      end

      def save
        if self.class.viewed.find {|saved_movie| saved_movie.ranking == self.ranking} != nil
         self
       else
         self.class.viewed << self
         self
       end
      end


    