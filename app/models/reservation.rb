class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :space, optional: true
    def booked_time
        start_date..end_date
    end
    validates :space_id, presence: true
    validates :start_date, presence: true
    validate :check_reserved_date?, on: :check_reserved
    validate :check_reserved_space
    def check_reserved_date?
      # binding.irb
      if !(Date.today <= start_date.to_date && DateTime.current.hour * 100 + DateTime.current.min <= start_time.hour * 100 + start_time.min)
        errors.add(:start_date, "は今の時刻よりもあとに設定しましょう。")
      end
    end

    validate :check_reserved_time?, on: :check_reserved
    def check_reserved_time?
      # binding.irb
      # if !(self.start_date < self.end_date) || !(self.start_date = self.end_date && self.start_time < self.end_time)
      #   errors.add(:start_time, "有効な時間を設定してください。")
      # end
      
      
      if self.start_date > self.end_date
        errors.add(:start_time, "有効なDateを設定してください。")
      end
      
      if self.start_time > self.end_time
        errors.add(:start_time, "有効なTimeを設定してください。")
      end
      
    end
    
    def check_reserved_space
      space = Reservation.where(space_id: self.space_id)
      
      # TODO : GET DATE BETWEEN
      if space.where('start_time >= ? AND ? < end_time', self.start_time, self.start_time).present?
        errors.add(:start_time, "予約済です。")
      end
      if space.where('start_time < ? AND ? <= end_time', self.end_time, self.end_time).present?
        errors.add(:end_time, "予約済です。")
      end      
    end




end
