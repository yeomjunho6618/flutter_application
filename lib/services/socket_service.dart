// dart
import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

// /// 소켓 받을 event
final String eventSink = jsonEncode({
  'type': 'SUBSCRIBE',
  'events': [
    {
      'type': 'tr',// rqc
      'filters': [
        ['C0100'],
        ['C0101']
      ]
    }
  ]
});

/// 웹 서버에 접속 시도  8월 18일이후 wss://wss1.bithumb.com/stream 로 변경.
const String wssPublic = 'wss://wss1.bithumb.com/public';

class WebSocketConnection {
  final String url;
  final String eventSink;
  final Completer<WebSocketChannel> _completer = Completer<WebSocketChannel>();
  late WebSocketChannel _webSocket;

  WebSocketConnection(this.url, this.eventSink);

  Future<WebSocketChannel> connect() {
    try {
      _webSocket = WebSocketChannel.connect(Uri.parse(url));
      _completer.complete(_webSocket);
    } catch (e) {
      _completer.completeError(e);
    }

    return _completer.future;
  }

  void send(String message) {
    _webSocket.sink.add(message);
  }

  void close() {
    _webSocket.sink.close();
  }
}
