class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  def self.get(sender_id, recipient_id)
    where(sender_id: sender_id, recipient_id: recipient_id)
      .or(where(sender_id: recipient_id, recipient_id: sender_id))
      .first_or_create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def other_user(user)
    user == sender ? recipient : sender
  end
end
