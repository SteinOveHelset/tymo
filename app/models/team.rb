class Team < ApplicationRecord
    belongs_to :created_by, class_name: 'User'
    
    has_many :clients, dependent: :destroy
    has_many :projects, dependent: :destroy
    has_many :entries, dependent: :destroy

    has_and_belongs_to_many :members, class_name: 'User', join_table: :teams_users

    validates :title, presence: true
end
