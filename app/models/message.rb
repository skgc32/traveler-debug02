class Message < ApplicationRecord
    belongs_to :conversation
    belongs_to :user
  
    after_initialize :set_default_read_status, if: :new_record?
  
    private
  
    def set_default_read_status
      self.read = false
    end
end
