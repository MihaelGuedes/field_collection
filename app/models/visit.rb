class Visit < ApplicationRecord
  before_save :TaskStatus

  validates_presence_of :date

  def TaskStatus
    if !self.checkin_at.nil?
      if !self.checkout_at.nil?
        self.status = 'finished'
      else
        self.status = 'realizing'
      end
    else
      p 'saved'
    end
  end
end
