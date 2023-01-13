import 'package:flutter/material.dart';

class BounceOutBottomBarAnimation extends StatefulWidget {
  const BounceOutBottomBarAnimation({super.key});

  @override
  State<BounceOutBottomBarAnimation> createState() =>
      _BounceOutBottomBarAnimationState();
}

class _BounceOutBottomBarAnimationState
    extends State<BounceOutBottomBarAnimation> {
  var currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Bounce out bottom bar animation'),
      ),
      extendBody: true,
      body: IndexedStack(index: currentIndex, children: [
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.amber,
        ),
      ]),
      bottomNavigationBar: BounceOutBottomBar(
        initialIndex: currentIndex,
        items: const [
          Icons.home,
          Icons.search,
          Icons.person,
          Icons.settings,
        ],
        onIndexChanged: (value) => setState(() {
          currentIndex = value;
        }),
      ),
    );
  }
}

class BounceOutBottomBar extends StatefulWidget {
  final List<IconData> items;
  final Color backgroundColor, foregroundColor;
  final int initialIndex;
  final ValueChanged<int> onIndexChanged;
  final double? width;
  const BounceOutBottomBar({
    super.key,
    required this.items,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black,
    this.initialIndex = 0,
    required this.onIndexChanged,
    this.width,
  });

  @override
  State<BounceOutBottomBar> createState() => _BounceOutBottomBarState();
}

class _BounceOutBottomBarState extends State<BounceOutBottomBar>
    with SingleTickerProviderStateMixin {
  late int currentIndex;
  late Color _backgroundColor, _foregroundColor;
  late AnimationController _controller;
  late Animation _animateIn,
      _animateOut,
      _circleAnimateItem,
      _elevAnimationOut,
      _elevAnimationIn;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _backgroundColor = widget.backgroundColor;
    _foregroundColor = widget.foregroundColor;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animateIn = CurveTween(
      curve: const Interval(
        0.1,
        0.6,
        curve: Curves.decelerate,
      ),
    ).animate(_controller);
    _animateOut = CurveTween(
      curve: const Interval(
        0.6,
        1.0,
        curve: Curves.bounceOut,
      ),
    ).animate(_controller);

    _elevAnimationIn = CurveTween(
      curve: const Interval(
        0.1,
        0.4,
        curve: Curves.decelerate,
      ),
    ).animate(_controller);
    _elevAnimationOut = CurveTween(
      curve: const Interval(
        0.45,
        1.0,
        curve: Curves.bounceOut,
      ),
    ).animate(_controller);

    _circleAnimateItem = CurveTween(
      curve: const Interval(
        0.1,
        0.4,
        curve: Curves.linear,
      ),
    ).animate(_controller);
    _controller.forward(from: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _movement = 100.0;
  final _elevation = 70.0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var currentWidth = width;
    var currentElevation = 0.0;

    return SizedBox(
        height: kBottomNavigationBarHeight,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              currentWidth = width -
                  (_movement * _animateIn.value) +
                  (_movement * _animateOut.value);

              currentElevation = (-_elevation * _elevAnimationIn.value) +
                  (_elevation / 1.4 * _elevAnimationOut.value);

              List<Widget> items = widget.items.asMap().entries.map((e) {
                var innerChild = CircleAvatar(
                  backgroundColor: _backgroundColor,
                  foregroundColor: _foregroundColor,
                  child: Icon(e.value),
                );
                if (e.key == currentIndex) {
                  return Expanded(
                    child: CustomPaint(
                      painter: _CustomCirclePainter(
                        progress: _circleAnimateItem.value,
                        color: _foregroundColor,
                      ),
                      child: Transform.translate(
                        offset: Offset(0.0, currentElevation),
                        child: innerChild,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _controller.forward(from: 0.0);
                      widget.onIndexChanged(e.key);
                      setState(() {
                        currentIndex = e.key;
                      });
                    },
                    child: innerChild,
                  ),
                );
              }).toList();

              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    color: _backgroundColor,
                  ),
                  width: currentWidth,
                  height: kBottomNavigationBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: items,
                  ),
                ),
              );
            }));
  }
}

class _CustomCirclePainter extends CustomPainter {
  final double progress;
  final Color color;

  _CustomCirclePainter({required this.progress, this.color = Colors.black});

  var stroke = 10.0;
  var radius = 20.0;
  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    var currentRadius = radius * progress;
    var currentStroke = stroke * (1 - progress);
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = currentStroke;
    if (progress < 1) {
      canvas.drawCircle(center, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(_CustomCirclePainter oldDelegate) {
    return true;
  }
}
