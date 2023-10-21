import 'package:flutter/widgets.dart';

import 'animation_configurator.dart';

/// An animation that scales its child.
class ScaleAnimation extends StatelessWidget {
  /// The duration of the child animation.
  final Duration? duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The curve of the child animation. Defaults to [Curves.ease].
  final Curve curve;

  /// Scaling factor to apply at the start of the animation.
  final double scale;

  final bool scaleX;

  final bool scaleY;

  /// The child Widget to animate.
  final Widget child;

  /// Creates a scale animation that scales its child for its center.
  ///
  /// Default value for [scale] is 0.0.
  ///
  /// The [child] argument must not be null.
  const ScaleAnimation({
    Key? key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.scale = 0.0,
    this.scaleX = false,
    this.scaleY = false,
    required this.child,
  })  : assert(scale >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfigurator(
      duration: duration,
      delay: delay,
      animatedChildBuilder: _landingAnimation,
    );
  }

  Widget _landingAnimation(Animation<double> animation) {
    final _landingAnimation = Tween<double>(begin: scale, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, 1.0, curve: curve),
      ),
    );
    return Transform.scale(
      alignment: Alignment.centerLeft,
      scaleX: scaleX ? _landingAnimation.value : null,
      scaleY: scaleY ? _landingAnimation.value : null,
      scale:
          (scaleX == false && scaleY == false) ? _landingAnimation.value : null,
      child: child,
    );
  }
}
