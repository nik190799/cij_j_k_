import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Hardcoded chat data for displaying in chat list
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
      home: const ChatListScreen(),
    );
  }
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
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
      ),
      body: ListView.separated(
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
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            minVerticalPadding: 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
        tooltip: 'New chat',
      ),
    );
  }
}
