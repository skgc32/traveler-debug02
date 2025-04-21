class ConversationsController < ApplicationController
    def index
        @conversations = Conversation.where(sender: current_user).or(Conversation.where(recipient: current_user))
      end
    
      def show
        @conversation = Conversation.find(params[:id])
        @messages = @conversation.messages.order(:created_at)
        @message = Message.new
        @messages.where.not(user_id: current_user.id).where(read: false).update_all(read: true)
      end
    
      def create
        recipient = User.find(params[:recipient_id])
        if current_user.following?(recipient) && recipient.following?(current_user)
          @conversation = Conversation.get(current_user.id, recipient.id)
          redirect_to @conversation
        else
          redirect_to conversations_path, alert: '相互フォローのみメッセージ可能です。'
        end
    end
end
