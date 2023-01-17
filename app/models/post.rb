class Post < ApplicationRecord
    belongs_to :community
    belongs_to :user
    has_many :comments, dependent: :destroy
end
