import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Chat {
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final bool unread;
  const Chat({
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.unread = false,
  });
}

// Hardcoded chat, status, and call data
const List<Chat> _chats = [
  Chat(
    name: 'Alice',
    avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
    lastMessage: 'Hey, how are you?',
    time: '09:40',
    unread: true,
  ),
  Chat(
    name: 'Bob',
    avatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
    lastMessage: 'Let\'s meet tomorrow.',
    time: '08:22',
    unread: false,
  ),
  Chat(
    name: 'Charlie',
    avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    lastMessage: 'Sent the files!',
    time: 'Yesterday',
    unread: true,
  ),
  Chat(
    name: 'Diana',
    avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
    lastMessage: 'Thank you! 😊',
    time: 'Yesterday',
    unread: false,
  ),
  Chat(
    name: 'Erin',
    avatarUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
    lastMessage: 'Where are you?',
    time: 'Mon',
    unread: false,
  ),
];

class StatusUpdate {
  final String name;
  final String avatarUrl;
  final String updateText;
  final String time;
  const StatusUpdate({
    required this.name,
    required this.avatarUrl,
    required this.updateText,
    required this.time,
  });
}

const List<StatusUpdate> _statusUpdates = [
  StatusUpdate(
    name: 'Alice',
    avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
    updateText: 'Feeling great today!',
    time: '45 minutes ago',
  ),
  StatusUpdate(
    name: 'Bob',
    avatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
    updateText: 'Out for a walk.',
    time: '1 hour ago',
  ),
  StatusUpdate(
    name: 'Diana',
    avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
    updateText: 'Vacation mode ON!',
    time: 'Today, 08:20',
  ),
];

class CallInfo {
  final String name;
  final String avatarUrl;
  final String time;
  final bool isVideo;
  final bool isIncoming;
  const CallInfo({
    required this.name,
    required this.avatarUrl,
    required this.time,
    this.isVideo = false,
    this.isIncoming = true,
  });
}

const List<CallInfo> _calls = [
  CallInfo(
      name: 'Alice',
      avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      time: 'Today, 08:45',
      isVideo: true,
      isIncoming: false),
  CallInfo(
      name: 'Bob',
      avatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      time: 'Yesterday, 19:10',
      isVideo: false,
      isIncoming: true),
  CallInfo(
      name: 'Charlie',
      avatarUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      time: 'Yesterday, 08:02',
      isVideo: false,
      isIncoming: false),
  CallInfo(
    name: 'Diana',
    avatarUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
    time: 'Monday, 17:32',
    isVideo: true,
    isIncoming: true,
  )
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF075E54)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFECE5DD),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 21,
            letterSpacing: 0.2,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF25D366),
          foregroundColor: Colors.white,
        ),
      ),
      home: const WhatsAppHomeScreen(),
    );
  }
}


class WhatsAppHomeScreen extends StatefulWidget {
  const WhatsAppHomeScreen({super.key});
  @override
  State<WhatsAppHomeScreen> createState() => _WhatsAppHomeScreenState();
}

class _WhatsAppHomeScreenState extends State<WhatsAppHomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.8,
        title: const Text('WhatsApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'new_group', child: Text('New group')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFFD6D6D6),
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            letterSpacing: 0.1,
          ),
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          _ChatsTab(),
          _StatusTab(),
          _CallsTab(),
        ],
      ),
      floatingActionButton: _controller.index == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.chat),
              tooltip: 'New chat',
            )
          : null,
    );
  }
}

class _ChatsTab extends StatelessWidget {
  const _ChatsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _chats.length,
      separatorBuilder: (_, __) => const Divider(indent: 76, height: 0),
      itemBuilder: (context, i) {
        final chat = _chats[i];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(chat.avatarUrl),
            radius: 26,
          ),
          title: Text(
            chat.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          subtitle: Text(
            chat.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chat.time,
                style: TextStyle(
                  color: chat.unread ? const Color(0xFF25D366) : Colors.grey,
                  fontWeight:
                      chat.unread ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              if (chat.unread)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF25D366),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(chat: chat),
              ),
            );
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          minVerticalPadding: 0,
        );
      },
    );
  }
}

class _StatusTab extends StatelessWidget {
  const _StatusTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _statusUpdates.length,
      separatorBuilder: (_, __) => const Divider(indent: 76, height: 0),
      itemBuilder: (context, i) {
        final status = _statusUpdates[i];
        return ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFF25D366),
            child: CircleAvatar(
              backgroundImage: NetworkImage(status.avatarUrl),
              radius: 24,
            ),
          ),
          title: Text(
            status.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          subtitle: Text(
            status.updateText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            status.time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
    );
  }
}

class _CallsTab extends StatelessWidget {
  const _CallsTab();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _calls.length,
      separatorBuilder: (_, __) => const Divider(indent: 76, height: 0),
      itemBuilder: (context, i) {
        final call = _calls[i];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(call.avatarUrl),
            radius: 26,
          ),
          title: Text(
            call.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
          subtitle: Row(
            children: [
              Icon(
                call.isIncoming ? Icons.call_received : Icons.call_made,
                color: call.isIncoming ? Colors.red : Colors.green,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                call.time,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),
          trailing: Icon(
            call.isVideo ? Icons.videocam : Icons.call,
            color: const Color(0xFF075E54),
          ),
        );
      },
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;
  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'fromMe': false,
      'text': "Hey there!",
      'time': "09:38",
    },
    {
      'fromMe': true,
      'text': "Hi! How's it going?",
      'time': "09:39",
    },
    {
      'fromMe': false,
      'text': 'Great, just wanted to catch up. 😊',
      'time': "09:40",
    },
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final txt = _controller.text.trim();
    if (txt.isNotEmpty) {
      setState(() {
        _messages.add({
          'fromMe': true,
          'text': txt,
          'time': TimeOfDay.now().format(context),
        });
      });
      _controller.clear();
      // Optionally scroll to bottom, omitted for brevity
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.chat.avatarUrl)),
            const SizedBox(width: 10),
            Text(
              widget.chat.name,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final msg = _messages[i];
                final fromMe = msg['fromMe'] as bool;
                return Align(
                  alignment:
                      fromMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        vertical: 9, horizontal: 18),
                    decoration: BoxDecoration(
                      color: fromMe
                          ? const Color(0xFFDCF8C6)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12).subtract(
                        BorderRadius.only(
                            bottomLeft: Radius.circular(fromMe ? 10 : 0),
                            bottomRight: Radius.circular(fromMe ? 0 : 10)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(msg['text'], style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 3),
                        Text(
                          msg['time'],
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              color: const Color(0xFFF6F6F6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Colors.grey),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.small(
                    backgroundColor: const Color(0xFF25D366),
                    onPressed: _sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
