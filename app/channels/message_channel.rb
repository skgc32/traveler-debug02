class MessageChannel < ApplicationCable::Channel
  def subscribed
    # 特定の会話に基づいてストリームを開始
    stream_from "conversation_#{params[:conversation_id]}"
  end

  def unsubscribed
    # チャンネルが解除されたときのクリーンアップ処理
    stop_all_streams
  end
end
