class Idea < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 75 }

  belongs_to :user

  has_many :comments

  has_and_belongs_to_many :users


  # Change the follwing Idea table method to scope most recent below
  # def self.most_recent()
  #   all.order(created_at: :desc).limit(3)
  # end

  scope :most_recent,          -> { order(created_at: :desc).limit(3) }
  scope :title_contains,       ->(item) { where('title LIKE ?', "%#{item}%") }
  scope :description_contains, ->(item) { where('description LIKE ?', "%#{item}%") }

  scope :search,               ->(search_term) { title_contains(search_term).or(description_contains(search_term)) }

  paginates_per 9

  # The following search is modified as the search scope above
  # def self.search(search_term)
  #   wildcard_filter = "%#{search_term}%"
  #   where('title LIKE ?', wildcard_filter).or(where('description LIKE ?', wildcard_filter))
  # end
end
