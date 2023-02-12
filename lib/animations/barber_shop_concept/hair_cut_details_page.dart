import 'package:flutter/material.dart';

import 'hair_cut.dart';

class HairCutDetailsPage extends StatelessWidget {
  final HairCut hairCut;
  const HairCutDetailsPage(this.hairCut, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: const FractionalOffset(0.5, 0.15),
            child: Hero(
              tag: "text_${hairCut.description}",
              child: Material(
                child: Text(
                  hairCut.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Hero(
                tag: "image_${hairCut.description}",
                child: Image.asset(hairCut.hairAsset)),
          ),
        ],
      ),
    );
  }
}
