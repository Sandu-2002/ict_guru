import 'package:flutter/material.dart';
import 'dart:async';

// 👉 TEMP HomeScreen (you can move this to another file later)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome to ICT Guru", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

// 👉 Your Loading Screen
class LoadingScreenPage extends StatefulWidget {
  const LoadingScreenPage({super.key});

  @override
  State<LoadingScreenPage> createState() => _LoadingScreenPageState();
}

class _LoadingScreenPageState extends State<LoadingScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return; // 🔥 FIX (important)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 10 : 8,
      height: active ? 10 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.deepPurple : Colors.deepPurple.shade200,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffECE9F1), Color(0xffD9D7F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 120,
              left: 40,
              child: Icon(
                Icons.rocket_launch_outlined,
                size: 35,
                color: Colors.deepPurple.shade200,
              ),
            ),

            Positioned(
              top: 140,
              right: 40,
              child: Icon(
                Icons.lightbulb_outline,
                size: 35,
                color: Colors.deepPurple.shade200,
              ),
            ),

            Positioned(
              bottom: 180,
              left: 30,
              child: Icon(
                Icons.wifi,
                size: 35,
                color: Colors.deepPurple.shade200,
              ),
            ),

            Positioned(
              bottom: 160,
              right: 30,
              child: Icon(
                Icons.school_outlined,
                size: 35,
                color: Colors.deepPurple.shade200,
              ),
            ),

            Positioned(
              bottom: 120,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: Icon(
                Icons.code,
                size: 35,
                color: Colors.deepPurple.shade200,
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: Image.asset("assets/images/ictguru.png", width: 110),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "ICT GURU",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [dot(true), dot(false), dot(false)],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
