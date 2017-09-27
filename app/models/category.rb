class Category < ApplicationRecord
    has_many :subcategories
    validates :title, presence: true, length: { minimum: 1 }
end
