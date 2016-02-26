class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :reviews

  validates :title, presence: true
  validates :description, presence: true
  validates :author, presence: true

  has_attached_file :book_img, styles: { book_index: "250x350>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\Z/
end
