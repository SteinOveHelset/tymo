class Client < ApplicationRecord
  belongs_to :team
  belongs_to :created_by, class_name: 'User'
  has_many :projects, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
