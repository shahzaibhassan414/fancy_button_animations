import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fancy_button_animations/fancy_button_animations.dart';

void main() {
  testWidgets('FancyButton renders correctly and responds to tap',
      (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FancyButton(
            onPressed: () => pressed = true,
            child: const Text('Test Button'),
          ),
        ),
      ),
    );

    // Verify button renders text
    expect(find.text('Test Button'), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(FancyButton));
    await tester.pumpAndSettle();

    // Verify onPressed was called
    expect(pressed, true);
  });

  testWidgets('FancyButton scale animation works on tap down',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: FancyButton(
              style: FancyButtonStyle.scale,
              // Must provide onPressed for the animation logic to trigger
              onPressed: _dummyAction,
              child: Text('Scale'),
            ),
          ),
        ),
      ),
    );

    final Finder scaleFinder = find.descendant(
      of: find.byType(FancyButton),
      matching: find.byType(ScaleTransition),
    );

    // Initially scale is 1.0
    double getScale() {
      final ScaleTransition widget = tester.widget<ScaleTransition>(scaleFinder);
      return widget.scale.value;
    }

    expect(getScale(), 1.0);

    // Simulate tap down
    final gesture = await tester.startGesture(tester.getCenter(find.byType(FancyButton)));
    
    // We need to pump multiple times to let the animation progress
    await tester.pump(); 
    await tester.pump(const Duration(milliseconds: 50));

    // Scale should have decreased
    expect(getScale(), lessThan(1.0));

    await gesture.up();
    await tester.pumpAndSettle();
  });
}

void _dummyAction() {}
