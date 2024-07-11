class User < ApplicationRecord
    has_many :clients, foreign_key: 'created_by_id', dependent: :destroy
    has_many :projects, foreign_key: 'created_by_id', dependent: :destroy
    has_many :entries, foreign_key: 'created_by_id', dependent: :destroy
    has_many :teams, foreign_key: 'created_by_id', dependent: :destroy

    has_one_attached :avatar

    has_and_belongs_to_many :teams, join_table: :teams_users

    has_secure_password

    validates :email, presence: true, uniqueness: true
end