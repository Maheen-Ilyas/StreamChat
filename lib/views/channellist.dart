import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchatnorm/views/channelpage.dart';

class ChannelList extends StatefulWidget {
  const ChannelList({
    Key? key,
    required this.client,
  }) : super(key: key);

  final StreamChatClient client;

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  late final _controller = StreamChannelListController(
    client: widget.client,
  );

  @override
  void initState() {
    _controller.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: const StreamChannelListHeader(),
            body: RefreshIndicator(
              onRefresh: _controller.refresh,
              child: StreamChannelListView(
                controller: _controller,
                onChannelTap: (channel) => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StreamChannel(
                        channel: channel,
                        child: const ChannelPage(),
                      ),
                    ),
                  ),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
