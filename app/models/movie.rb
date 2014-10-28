class Movie < ActiveRecord::Base
  belongs_to :user

  has_many :votes

  scope :suggested, ->() do
    where("viewed = ? AND created_at >= ?", false, Time.now - 1.week).order(rating: :desc)
  end

  def current_votes
    votes.pluck(:value).inject(0, :+)
  end
end
