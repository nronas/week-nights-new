class Imdb
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def find_movie(movie=nil)
    movies = movie ? [movie] : find_movies_with_title!
    movie_data = get_movie!(movies.first)
    parse_movie(movie_data)
  end

  def find_movies_with_title!
    response = connection.get('/find', q: title)
    ImdbSearchResult.new(response.body).results
  end

  private
  def parse_movie(data)
    MovieParser.new(data).parse
  end

  def get_movie!(movie_data)
    connection.get(movie_data[:url]).body
  end

  def connection
    @connection ||= Faraday.new(:url => 'http://www.imdb.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end
end
