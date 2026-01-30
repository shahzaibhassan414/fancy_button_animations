import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'button_styles.dart';

/// A highly customizable button with built-in animations.
///
/// Use [FancyButton] to add effects like scale, pulse, or glow to any widget.
class FancyButton extends StatefulWidget {
  /// The widget to be displayed inside the button.
  final Widget child;

  /// Callback function when the button is pressed.
  final VoidCallback? onPressed;

  /// The animation style to apply (default: [FancyButtonStyle.scale]).
  final FancyButtonStyle style;

  /// Configuration for animation timing and factors.
  final FancyButtonConfig config;

  /// The padding inside the button.
  final EdgeInsetsGeometry padding;

  /// The background color of the button.
  final Color? color;

  /// The border radius of the button.
  final BorderRadius? borderRadius;

  /// Creates a [FancyButton] widget.
  const FancyButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style = FancyButtonStyle.scale,
    this.config = const FancyButtonConfig(),
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.color,
    this.borderRadius,
  });

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.config.duration,
    );

    _setupAnimation();
  }

  void _setupAnimation() {
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.config.curve,
    ));

    switch (widget.style) {
      case FancyButtonStyle.pulse:
        _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _controller.repeat(reverse: true);
        break;
      case FancyButtonStyle.bounce:
        _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
        );
        break;
      case FancyButtonStyle.rotate:
        _animation = Tween<double>(begin: 0.0, end: widget.config.rotateAngle).animate(
          CurvedAnimation(parent: _controller, curve: widget.config.curve),
        );
        break;
      case FancyButtonStyle.shake:
        _animation = TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: widget.config.shakeOffset), weight: 1),
          TweenSequenceItem(tween: Tween(begin: widget.config.shakeOffset, end: -widget.config.shakeOffset), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -widget.config.shakeOffset, end: 0.0), weight: 1),
        ]).animate(CurvedAnimation(parent: _controller, curve: widget.config.curve));
        break;
      default: // scale and glow
        _animation = Tween<double>(begin: 1.0, end: widget.config.scaleFactor).animate(
          CurvedAnimation(parent: _controller, curve: widget.config.curve),
        );
    }
  }

  @override
  void didUpdateWidget(FancyButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style) {
      _controller.stop();
      _controller.reset();
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && widget.style != FancyButtonStyle.pulse) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && widget.style != FancyButtonStyle.pulse) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && widget.style != FancyButtonStyle.pulse) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final buttonColor = widget.color ?? Theme.of(context).primaryColor;

        Widget result = Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            boxShadow: widget.style == FancyButtonStyle.glow
                ? [
                    BoxShadow(
                      color: buttonColor.withValues(alpha: 0.5),
                      blurRadius: _glowAnimation.value,
                      spreadRadius: _glowAnimation.value / 4,
                    )
                  ]
                : null,
          ),
          child: widget.child,
        );

        switch (widget.style) {
          case FancyButtonStyle.rotate:
            result = Transform.rotate(
              angle: _animation.value * math.pi,
              child: result,
            );
            break;
          case FancyButtonStyle.shake:
            result = Transform.translate(
              offset: Offset(_animation.value, 0),
              child: result,
            );
            break;
          case FancyButtonStyle.bounce:
          case FancyButtonStyle.pulse:
          case FancyButtonStyle.scale:
            result = ScaleTransition(
              scale: _animation,
              child: result,
            );
            break;
          case FancyButtonStyle.glow:
            result = ScaleTransition(
              scale: _animation,
              child: result,
            );
            break;
        }

        return GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.onPressed,
          child: result,
        );
      },
    );
  }
}
