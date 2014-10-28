class Movie < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  scope :suggested, ->() do
    where("viewed = ? AND movies.created_at >= ?", false, Time.now - 1.week)
  end

  def current_votes
    votes.pluck(:value).inject(0, :+)
  end
end
