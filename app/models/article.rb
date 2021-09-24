class Article < ApplicationRecord
    belongs_to :user

    #to valiadte that new article will not save if title not entered
    validates :title, presence: true, length: { minimum: 3, maximum: 30 }
    validates :description, presence: true, length: { minimum: 10, maximum: 300 }
    validates :user_id, presence: true
end