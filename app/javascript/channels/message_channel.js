import consumer from "channels/consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // サーバーとのWebSocket接続が成功したときに実行される
    console.log("Connected to MessageChannel");
  },

  disconnected() {
    // サーバーとのWebSocket接続が切れたときに実行される
    console.log("Disconnected from MessageChannel");
  },

  received(data) {
    // サーバーからデータを受信したときに実行される
    console.log("Received data:", data);

    // メッセージを表示する要素を取得
    const messagesContainer = document.getElementById("messages");
    if (messagesContainer) {
      // メッセージをリアルタイムでチャット画面に追加
      messagesContainer.insertAdjacentHTML("beforeend", this.renderMessage(data));
    }
  },

  renderMessage(data) {
    // サーバーから受信したデータを元にHTMLを生成
    return `
      <div class="message">
        <p><strong>User ${data.user_id}:</strong> ${data.message}</p>
        <small>${data.created_at}</small>
      </div>
    `;
  }
});

