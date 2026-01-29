import 'package:flutter/material.dart';
import 'button_styles.dart';

class FancyButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final FancyButtonStyle style;
  final FancyButtonConfig config;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final BorderRadius? borderRadius;

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
    if (widget.style == FancyButtonStyle.pulse) {
      _animation = Tween<double>(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.repeat(reverse: true);
    } else {
      _animation = Tween<double>(
        begin: 1.0,
        end: widget.config.scaleFactor,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.config.curve,
      ));
    }
  }

  @override
  void didUpdateWidget(FancyButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style) {
      _controller.stop();
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && widget.style == FancyButtonStyle.scale) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && widget.style == FancyButtonStyle.scale) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && widget.style == FancyButtonStyle.scale) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color ?? Theme.of(context).primaryColor,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        boxShadow: widget.style == FancyButtonStyle.glow
            ? [
                BoxShadow(
                  color: (widget.color ?? Theme.of(context).primaryColor)
                      .withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: widget.child,
    );

    if (widget.style == FancyButtonStyle.scale ||
        widget.style == FancyButtonStyle.pulse) {
      result = ScaleTransition(
        scale: _animation,
        child: result,
      );
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: result,
    );
  }
}
