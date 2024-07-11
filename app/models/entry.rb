class Entry < ApplicationRecord
  belongs_to :team
  belongs_to :client
  belongs_to :project
  belongs_to :created_by, class_name: 'User'

  validates :description, :start_time, :end_time, presence: true
  validate :is_end_time_after_start_time

  scope :from_today, -> { where(start_time: Date.today.all_day) }
  scope :from_thisweek, -> { where(start_time: Date.today.beginning_of_week..Date.today.end_of_week) }

  before_save :calculate_minutes

  private

  def is_end_time_after_start_time
    if end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def calculate_minutes
    self.minutes = ((end_time - start_time) / 60).to_i
  end
end
