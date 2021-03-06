class TopOneHundred::Scraper

    #list of methods that access the data on IMDB html
    def index_page #allows access to the html
        html = "https://www.imdb.com/list/ls080028651/"
        Nokogiri::HTML(open(html))
    end

    def movie_url(selected_movie) #generates selected movie IMDB page URL
        index = selected_movie.index
	    resource = index_page.css(".lister-item-header a")[index]["href"]
	    movie_url = "https://www.imdb.com" + resource
    end

    def movie_page(selected_movie) #retrieves Nokogiri data from selected movies IMDB page
        movie_html = movei_url(selected_movie)
        Nokogiri::HTML(open(movie_html))
    end

    def trivia_url(selected_movie) #generates Nokogiri data from selected movie IMDB trivia page
        movie_page = movie_page(selected_movie)
        movie_url = movie_url(selected_movie)
        resource = movie_page.css("div#trivia a.nobr")[0]["href"].to_s
        trivia_url = movie_url.to_s + resource
    end

    def trivia_page(selected_movie) #retreives Nokogiri data from selected movie IMDB trivia page
        trivia_html = trivia_url(selected_movie)
        Nokogiri::HTML = (open(trivia_html))
    end

    def quotes_url(selected_movie) #generates Nokogiri data from selecteed movie IMDB qotes page
        movie_page = movie_page(selected_movie)
        movie_url = movie_url(selected_movie)
        resource = movie_page.css("div#quotes a.nobr")[0]["href"].to_s
        quotes_url = movie_url.to_s + resource
    end

    def quotes_page(selected_movie) #retrieves Nokogiri data from selected movie IMDB  trivia page
        quotes_html = quotes_url(selected_movie)
        Nokogiri::HTML(open(quotes_html))
    end

    def movie_initializer
        new_movie = TopOneHundred::Movie.new
    end
    
    def initialize #instance method that initializes top 100 movies
        y = 0
        all_movies = []
        while y < 100
        new_movie = TopOneHundred::Movie.new(y)
        all_movies << new_movie
        y += 1
        end
        all_movies
    end
end
