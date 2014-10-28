class Dashboard::MoviesController < DashboardsController
  def new; end

  def find
    imdb_client = Imdb.new(movie_params[:title])
    @movie = imdb_client.find_movie
    @similar_movies = imdb_client.find_movies_with_title![1..6]

    render :show
  end

  def show
    imdb_client = Imdb.new(movie_params[:text])
    @movie = imdb_client.find_movie(movie_params.with_indifferent_access)
    @similar_movies = imdb_client.find_movies_with_title![1..6]
  end

  def create
    if current_user.movie_suggestions.find_by_title(movie_params[:title])
      redirect_to dashboard_path, alert: 'You have already suggest that movie'
    else
      current_user.movie_suggestions << Movie.new(movie_params)

      if current_user.save
        redirect_to dashboard_path, notice: 'Thanks for your suggestion!'
      else
        redirect_to dashboard_movies_path(movie: movie_params), alert: current_user.errors.full_messages
      end
    end
  end

  def update
    if current_user.master?
      movie = Movie.find(params[:id])

      if movie.update_attributes(movie_params)
        redirect_to dashboard_path, notice: 'Thanks Master'
      else
        redirect_to dashboard_path, alert: 'Oops, Something went wrong.'
      end
    else
      redirect_to dashboard_path, alert: 'Only The Master can use that function'
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :text, :primary_photo, :url, :image_url, :description, :rating, :viewed)
  end
end
