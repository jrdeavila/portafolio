import 'package:animation_examples/animations/barber_shop_concept/hair_cut_details_page.dart';
import 'package:flutter/material.dart';
import 'hair_cut.dart';

class BarberShopAnimation extends StatefulWidget {
  const BarberShopAnimation({super.key});

  @override
  State<BarberShopAnimation> createState() => _BarberShopAnimationState();
}

class _BarberShopAnimationState extends State<BarberShopAnimation> {
  late PageController _scrollController, _textController;
  double _currentPage = 0.0;
  double _textPage = 0.0;
  final Duration _duration = const Duration(milliseconds: 400);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = PageController(viewportFraction: 0.35);
    _textController = PageController();
    _scrollController.addListener(_scrollListener);
    _textController.addListener(_textScrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _textController.dispose();
  }

  void _scrollListener() {
    setState(() {
      _currentPage = _scrollController.page ?? 0.0;
    });
  }

  void _textScrollListener() {
    setState(() {
      _textPage = _textController.page ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            height: height * 0.3,
            left: 20,
            right: 20,
            bottom: -height * 0.2,
            child: const DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  offset: Offset.zero,
                  blurRadius: 90,
                  spreadRadius: 50,
                ),
              ]),
            ),
          ),
          PageView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemCount: hairCuts.length + 1,
            onPageChanged: ((value) {
              if (value < hairCuts.length) {
                _textController.animateToPage(
                  value,
                  duration: _duration,
                  curve: Curves.easeInOut,
                );
              }
            }),
            itemBuilder: (context, index) {
              if (index == 0) return const SizedBox.shrink();
              var item = hairCuts[index - 1];
              var result = _currentPage - index + 1;
              var value = -0.4 * result + 1;
              var opacity = value.clamp(0.0, 1.0);

              return Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(0.0, height / 2.6 * (1 - value).abs())
                  ..scale(value),
                child: Opacity(
                  opacity: opacity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                        onTap: () => Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    ((context, animation, secondaryAnimation) =>
                                        HairCutDetailsPage(item)),
                                transitionDuration: _duration,
                                transitionsBuilder: ((context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                }),
                              ),
                            ),
                        child: Hero(
                            tag: "image_${item.description}",
                            child: Image.asset(item.hairAsset))),
                  ),
                ),
              );
            },
          ),
          Positioned(
            height: height * 0.1,
            top: height * 0.15,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _textController,
                    itemCount: hairCuts.length,
                    itemBuilder: ((context, index) {
                      var opacity = 1.0 - (_textPage - index).abs().clamp(0, 1);
                      var item = hairCuts[index];
                      return Center(
                        child: Opacity(
                          opacity: opacity,
                          child: Hero(
                            tag: "text_${item.description}",
                            child: Material(
                              child: Text(
                                item.description,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                AnimatedSwitcher(
                  duration: _duration,
                  child: Text(
                    hairCuts[_currentPage.toInt().clamp(0, 2)].price,
                    key: ValueKey("key_${_currentPage.toInt()}"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
