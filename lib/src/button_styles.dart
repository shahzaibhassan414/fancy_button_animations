import 'package:flutter/material.dart';

/// Defines the available animation styles for [FancyButton].
enum FancyButtonStyle {
  /// Shrinks the button when pressed.
  scale,

  /// Continuously grows and shrinks the button.
  pulse,

  /// Adds a glowing shadow effect that grows when pressed.
  glow,

  /// A bouncy scaling effect using elastic curves.
  bounce,

  /// Vibrates the button horizontally.
  shake,

  /// Rotates the button slightly.
  rotate,
}

/// Configuration settings for [FancyButton] animations.
class FancyButtonConfig {
  /// The scale factor to apply when the button is pressed (default: 0.95).
  final double scaleFactor;

  /// The duration of the animation (default: 150ms).
  final Duration duration;

  /// The animation curve (default: [Curves.easeInOut]).
  final Curve curve;

  /// The angle in radians to rotate if [FancyButtonStyle.rotate] is used.
  final double rotateAngle;

  /// The pixel offset to shake if [FancyButtonStyle.shake] is used.
  final double shakeOffset;

  /// Creates a configuration for fancy button animations.
  const FancyButtonConfig({
    this.scaleFactor = 0.95,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.rotateAngle = 0.05,
    this.shakeOffset = 5.0,
  });
}
