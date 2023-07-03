part of 'widget.dart';

class AnimatedBottomToTopSliding extends StatefulWidget {
  const AnimatedBottomToTopSliding({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  State<AnimatedBottomToTopSliding> createState() =>
      _AnimatedBottomToTopSlidingState();
}

class _AnimatedBottomToTopSlidingState
    extends State<AnimatedBottomToTopSliding> {
  late Animation<double> slideAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    slideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeInOutCubic,
      ),
    );

    opacityAnimation = widget.animation;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: Transform.translate(
        offset: Offset(0, slideAnimation.value),
        child: widget.child,
      ),
    );
  }
}
