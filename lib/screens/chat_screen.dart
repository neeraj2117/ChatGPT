import 'package:ChatGPT/providers/active_theme_provider.dart';
import 'package:ChatGPT/screens/login.dart';
import 'package:ChatGPT/widgets/theme_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chats_provider.dart';
import '../widgets/chat_item.dart';
import '../widgets/text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _loggingOut = false;

  void _logout() {
    setState(() {
      _loggingOut = true;
    });

    Future.delayed(
      Duration(seconds: 1),
      () async {
        await FirebaseAuth.instance.signOut();
        setState(() {
          _loggingOut = false;
        });

        // Show snackbar after logout
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You have been successfully logged out."),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigate to login page
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => const Login(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Chat-GPT',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 23,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu_sharp,
            size: 30,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          Row(
            children: [
              Consumer(
                builder: (context, ref, child) => Icon(
                  ref.watch(activeThemeProvider) == Themes.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              ),
              const SizedBox(width: 8),
              const ThemeSwitch(),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 32,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 17),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 8.0),
              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("About App"),
                        content: const Text(
                            "This is a ChatGPT clone made in flutter and using OpenAi API key.\n\nMade by Neeraj ❤️"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // logout
            Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 8.0),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'LogOut',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                onTap: _loggingOut ? null : _logout,
              ),
            ),
            if (_loggingOut)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 7),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) =>
                  //         const ChatHistoryPage(),
                  //   ),
                  // );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.history,
                    size: 28,
                  ),
                  title: Text(
                    'History',
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final chats = ref.watch(chatsProvider).reversed.toList();
              return ListView.builder(
                reverse: true,
                itemCount: chats.length,
                itemBuilder: (context, index) => ChatItem(
                  text: chats[index].message,
                  isMe: chats[index].isMe,
                ),
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: TextAndVoiceField(),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
