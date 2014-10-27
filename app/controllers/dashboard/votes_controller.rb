class Dashboard::VotesController < DashboardsController
  before_action :find_movie

  def create
    if @movie.votes.find_by_user_id(current_user.id)
      redirect_to dashboard_path, alert: 'You have already voted for this movie.'
    else
      @movie.votes << Vote.new(user_id: current_user.id, value: Vote::VALUES[votes_params[:value]])

      if @movie.save
        redirect_to dashboard_path, notice: 'Thanks for your vote.'
      else
        redirect_to dashboard_path, alert: 'Oops something went wrong. Please try again.'
      end
    end
  end

  private
  def find_movie
    @movie ||= Movie.find(params[:movie_id])
  end

  def votes_params
    params.require(:vote).permit(:value)
  end
end
