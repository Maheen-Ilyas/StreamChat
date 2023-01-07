import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchatnorm/views/channellist.dart';
import 'package:streamchatnorm/views/channelpage.dart';

Future<void> main() async {
  const apiKey = "7xk42ut8stu8";
  const userToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic29mdC1tb3JuaW5nLTgifQ.opCvYG7tMzVeWH5ZRoe4DvcnA_CXT7_kir1eBVShBsk";

  // Initialize the client
  final client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );

  await client.connectUser(
    User(
      id: 'soft-morning-8',
      online: true,
      lastActive: DateTime.now(),
      image:
          "https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png",
    ),
    userToken,
  );

  // Create channel
  final channel1 = client.channel(
    'messaging',
    id: 'soft-morning-8',
    extraData: {
      "name": "Student media",
      "image":
          "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg",
    },
  );

  // Create the channel and watch and listen on it
  await channel1.watch();

  runApp(
    MyApp(
      client: client,
      channel: channel1,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.client,
    required this.channel,
  }) : super(key: key);

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return StreamChat(
          client: client,
          child: StreamChannel(
            channel: channel,
            child: ChannelList(
              client: client,
            ),
          ),
        );
      },
    );
  }
}
