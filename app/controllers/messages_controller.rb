class MessagesController < ApplicationController
        def create
          @conversation = Conversation.find(params[:conversation_id])
          @message = @conversation.messages.build(message_params.merge(user: current_user))
      
          if @message.save
            ActionCable.server.broadcast "conversation_#{@conversation.id}", {
              message: @message.body,
              user_id: @message.user.id,
              read: @message.read
            }
            redirect_to conversation_path(@conversation)
          else
            flash[:alert] = @message.errors.full_messages.join(', ')
            redirect_to conversation_path(@conversation)
          end
        end
      
        def mark_as_read
          @message = Message.find(params[:id])
          @message.update(read: true)
          head :ok
        end
      
        private
      
        def message_params
          params.require(:message).permit(:body)
        end
end
