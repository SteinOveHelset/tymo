class Project < ApplicationRecord
  belongs_to :client
  belongs_to :team
  belongs_to :created_by, class_name: 'User'
  has_many :entries, dependent: :destroy

  validates :client_id, :title, :description, presence: true
  
  def title_plus_client
    "#{client.title}: #{title}"
  end

  def total_minutes
    entries.sum(:minutes)
  end

  def total_percentage
    ((self.total_minutes / 60)/self.budget.to_f)*100
  end

  def pill_class
    if self.budget
      if self.total_percentage >= 100
        'bg-[#e45c34]'
      elsif self.total_percentage >= 90
        'bg-[#e88e70]'
      elsif self.total_percentage >= 60
        'bg-[#5e7857]'
      elsif self.total_percentage >= 30
        'bg-[#789b6f]'
      else
        'bg-[#8fb984]'
      end
    else
      'bg-slate-200'
    end
  end
end
