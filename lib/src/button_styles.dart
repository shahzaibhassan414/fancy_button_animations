import 'package:flutter/material.dart';

enum FancyButtonStyle {
  scale,
  pulse,
  glow,
}

class FancyButtonConfig {
  final double scaleFactor;
  final Duration duration;
  final Curve curve;

  const FancyButtonConfig({
    this.scaleFactor = 0.95,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
  });
}
