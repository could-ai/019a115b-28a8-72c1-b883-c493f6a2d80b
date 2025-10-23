import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teen Social App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF8338EC),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8338EC),
          brightness: Brightness.dark,
          secondary: const Color(0xFFFB5607),
          tertiary: const Color(0xFFFFBE0B),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;
  static const double _fabDimension = 56.0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const ChatScreen(),
    const DiscoverScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onIconTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _screens[_currentIndex],
          Positioned(
            bottom: 30.0,
            left: MediaQuery.of(context).size.width / 2 - _fabDimension / 2,
            child: _buildCircularNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularNavigation() {
    final icons = [
      {'icon': Icons.dynamic_feed, 'label': 'Feed'},
      {'icon': Icons.chat_bubble, 'label': 'Chat'},
      {'icon': Icons.explore, 'label': 'Discover'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ...List.generate(icons.length, (index) {
            final angle = (index * (360 / icons.length) - 90) * (math.pi / 180);
            return Flow(
              delegate: FlowMenuDelegate(controller: _controller),
              children: [
                Transform.translate(
                  offset: Offset(
                    math.cos(angle) * 80,
                    math.sin(angle) * 80,
                  ),
                  child: GestureDetector(
                    onTap: () => _onIconTapped(index),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        icons[index]['icon'] as IconData,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  FlowMenuDelegate({required this.controller}) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (controller.value == 0) return;
    for (int i = 0; i < context.childCount; i++) {
      final size = context.getChildSize(i)!;
      final x = (size.width / 2) * (1 - controller.value);
      final y = (size.height / 2) * (1 - controller.value);
      context.paintChild(i, transform: Matrix4.translationValues(-x, -y, 0)
        ..scale(controller.value));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => controller != oldDelegate.controller;
}

// Placeholder Screens
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A1A), const Color(0xFF2C2C2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dynamic_feed, size: 80, color: Colors.white70),
            SizedBox(height: 20),
            Text('Visual & Video Feed', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            Text('Photos, short videos, and challenges', style: TextStyle(fontSize: 16, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A1A), const Color(0xFF2C2C2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble, size: 80, color: Colors.white70),
            SizedBox(height: 20),
            Text('Instant Messaging', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            Text('Real-time chat with emojis and 3D avatars', style: TextStyle(fontSize: 16, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A1A), const Color(0xFF2C2C2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore, size: 80, color: Colors.white70),
            SizedBox(height: 20),
            Text('Discover', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            Text('Interest-based recommendations', style: TextStyle(fontSize: 16, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1A1A1A), const Color(0xFF2C2C2C)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.white70),
            SizedBox(height: 20),
            Text('Profile', style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            Text('Your personal space with videos and challenges', style: TextStyle(fontSize: 16, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
