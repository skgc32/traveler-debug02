class Message < ApplicationRecord
    belongs_to :conversation
    belongs_to :user
  
    validates :body, presence: true, length: { maximum: 140 }

    after_initialize :set_default_read_status, if: :new_record?

    after_create_commit :broadcast_message
  
    private
  
    def set_default_read_status
      self.read = false
    end

    def broadcast_message
        ActionCable.server.broadcast "conversation_#{conversation.id}", {
          message: self.body,         # メッセージ本文
          user_id: self.user.id,      # メッセージ送信者ID
          created_at: self.created_at.strftime('%Y-%m-%d %H:%M:%S'), # 作成日時
          read: self.read             # 既読状態
        }
    end
end
