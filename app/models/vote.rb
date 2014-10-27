class Vote < ActiveRecord::Base
  VALUES = {
    'thumbs_up' => 1,
    'thumbs_down' => -1
  }

  belongs_to :movie
  belongs_to :user
end
