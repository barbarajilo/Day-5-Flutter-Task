import 'dart:convert';

import 'package:web_socket_channel/io.dart';
//import 'package:web_socket_channel/status.dart' as status;

void main() {
  //to establish connection to API
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    final serverTimeAsEpoch = decodedMessage['tick']['epoch'];
    final price = decodedMessage['tick']['quote'];
    final name = decodedMessage['tick']['symbol'];
    final serverTime =
        DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);
        
    //final activeSymbolArray = decodedMessage['active_symbols'];

    print('Name: $name, Price: $price, Date : $serverTime');

    //channel.sink.close();
  });

  channel.sink.add('{"ticks":"frxAUDCAD", "subscribe": 1}');
}
