class Question < ApplicationRecord
    validates :format, presence: true
    validates :body, presence: true
    validates :option1, presence: true, length: {:within => 1..400}
    validates :option2, presence: true, length: {:within => 1..400}
    validates :option3, presence: true, length: {:within => 1..400}
    validates :option4, presence: true, length: {:within => 1..400}
    validates :answer, presence: true
end
