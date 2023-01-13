import 'package:flutter/material.dart';

class SocialButtonShareAnimation extends StatelessWidget {
  const SocialButtonShareAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: const GradientRotation(0.5),
            colors: [
              Colors.blue,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: const Center(
          child: SocialShareButton(),
        ),
      ),
    );
  }
}

class SocialShareButton extends StatefulWidget {
  const SocialShareButton({super.key});

  @override
  State<SocialShareButton> createState() => _SocialShareButtonState();
}

class _SocialShareButtonState extends State<SocialShareButton> {
  bool _isExpanded = false;
  double get getWidth => 250;
  double get getHeight => 110;
  @override
  Widget build(BuildContext context) {
    final movement = getHeight / 4;
    return SizedBox(
      width: getWidth,
      height: getHeight,
      child: TweenAnimationBuilder(
          tween: _isExpanded
              ? Tween(begin: 0.0, end: 1.0)
              : Tween(begin: 1.0, end: 0.0),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, movement * value),
                  child: _widgetTop(),
                ),
                Transform.translate(
                  offset: Offset(0, -movement * value),
                  child: _widgetBottom(),
                )
              ],
            );
          }),
    );
  }

  Material _widgetBottom() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Ink(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              "SHARE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _widgetTop() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      height: 50,
      width: getWidth * 0.9,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.whatsapp, color: Colors.green)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tiktok, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.facebook, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
