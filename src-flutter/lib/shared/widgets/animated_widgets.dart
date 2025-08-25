import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Animated page transitions
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  SlidePageRoute({
    required this.child,
    this.direction = AxisDirection.left,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Offset begin;
            switch (direction) {
              case AxisDirection.left:
                begin = const Offset(1.0, 0.0);
                break;
              case AxisDirection.right:
                begin = const Offset(-1.0, 0.0);
                break;
              case AxisDirection.up:
                begin = const Offset(0.0, 1.0);
                break;
              case AxisDirection.down:
                begin = const Offset(0.0, -1.0);
                break;
            }
            
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

  final Widget child;
  final AxisDirection direction;
  final Duration duration;
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  FadePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );

  final Widget child;
  final Duration duration;
}

// Animated containers
class AnimatedCard extends StatefulWidget {
  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.animateOnHover = true,
    this.duration = const Duration(milliseconds: 200),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final bool animateOnHover;
  final Duration duration;

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.animateOnHover ? (_) => _setHovered(true) : null,
      onExit: widget.animateOnHover ? (_) => _setHovered(false) : null,
      child: AnimatedContainer(
        duration: widget.duration,
        margin: widget.margin,
        transform: _isHovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity(),
        child: Material(
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          elevation: _isHovered ? widget.elevation + 2 : widget.elevation,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Padding(
              padding: widget.padding ?? const EdgeInsets.all(16),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  void _setHovered(bool hovered) {
    if (mounted) {
      setState(() => _isHovered = hovered);
    }
  }
}

// Staggered list animations
class StaggeredList extends StatelessWidget {
  const StaggeredList({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.animationDuration = const Duration(milliseconds: 300),
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
  });

  final List<Widget> children;
  final Duration staggerDelay;
  final Duration animationDuration;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index]
            .animate(
              delay: staggerDelay * index,
            )
            .slideX(
              begin: scrollDirection == Axis.vertical ? 0 : -0.3,
              duration: animationDuration,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: scrollDirection == Axis.vertical ? -0.3 : 0,
              duration: animationDuration,
              curve: Curves.easeOutCubic,
            )
            .fadeIn(
              duration: animationDuration,
              curve: Curves.easeOut,
            );
      },
    );
  }
}

// Loading animations
class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 2.0,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).colorScheme.primary,
        strokeWidth: strokeWidth,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .rotate(duration: 1000.ms);
  }
}

class PulseAnimation extends StatelessWidget {
  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.minScale = 0.95,
    this.maxScale = 1.05,
  });

  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: Offset(minScale, minScale),
          end: Offset(maxScale, maxScale),
          duration: duration,
        );
  }
}

// Entrance animations
class SlideInAnimation extends StatelessWidget {
  const SlideInAnimation({
    super.key,
    required this.child,
    this.direction = SlideDirection.left,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;
  final SlideDirection direction;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case SlideDirection.left:
        return child
            .animate(delay: delay)
            .slideX(begin: -0.5, duration: duration, curve: curve)
            .fadeIn(duration: duration, curve: curve);
      case SlideDirection.right:
        return child
            .animate(delay: delay)
            .slideX(begin: 0.5, duration: duration, curve: curve)
            .fadeIn(duration: duration, curve: curve);
      case SlideDirection.up:
        return child
            .animate(delay: delay)
            .slideY(begin: -0.5, duration: duration, curve: curve)
            .fadeIn(duration: duration, curve: curve);
      case SlideDirection.down:
        return child
            .animate(delay: delay)
            .slideY(begin: 0.5, duration: duration, curve: curve)
            .fadeIn(duration: duration, curve: curve);
    }
  }
}

enum SlideDirection {
  left,
  right,
  up,
  down,
}

class FadeInAnimation extends StatelessWidget {
  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: curve);
  }
}

class ScaleInAnimation extends StatelessWidget {
  const ScaleInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.curve = Curves.easeOutBack,
    this.beginScale = 0.0,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double beginScale;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .scale(begin: Offset(beginScale, beginScale), duration: duration, curve: curve)
        .fadeIn(duration: duration);
  }
}

// Button press animation
class PressableWidget extends StatefulWidget {
  const PressableWidget({
    super.key,
    required this.child,
    this.onPressed,
    this.scaleDown = 0.95,
    this.duration = const Duration(milliseconds: 100),
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double scaleDown;
  final Duration duration;

  @override
  State<PressableWidget> createState() => _PressableWidgetState();
}

class _PressableWidgetState extends State<PressableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleDown,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}