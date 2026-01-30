import 'package:flutter/material.dart';
import 'package:fancy_button_animations/fancy_button_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Button Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fancy Button Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tap buttons to see animations:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            // Scale Animation
            FancyButton(
              style: FancyButtonStyle.scale,
              onPressed: () => _showSnackBar(context, 'Scale Button Pressed'),
              child: const Text('Scale Animation', 
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),

            // Pulse Animation
            FancyButton(
              style: FancyButtonStyle.pulse,
              color: Colors.purple,
              onPressed: () => _showSnackBar(context, 'Pulse Button Pressed'),
              child: const Text('Pulse Animation', 
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),

            // Glow Animation
            FancyButton(
              style: FancyButtonStyle.glow,
              color: Colors.orange,
              onPressed: () => _showSnackBar(context, 'Glow Button Pressed'),
              child: const Text('Glow Animation', 
                  style: TextStyle(color: Colors.white)),
            ),

            // Bounce Style
            FancyButton(
              style: FancyButtonStyle.bounce,
              color: Colors.green,
              onPressed: () {},
              child: const Text("Bounce Me", style: TextStyle(color: Colors.white)),
            ),

// Shake Style
            FancyButton(
              style: FancyButtonStyle.shake,
              color: Colors.red,
              onPressed: () {},
              child: const Text("Shake Me", style: TextStyle(color: Colors.white)),
            ),

// Rotate Style
            FancyButton(
              style: FancyButtonStyle.rotate,
              color: Colors.teal,
              onPressed: () {},
              child: const Text("Rotate Me", style: TextStyle(color: Colors.white)),
            ),

          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}
