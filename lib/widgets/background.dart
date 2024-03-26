import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height,
      child: const Stack(children: [
        CoffeBean(degress: 190, right: 160, top: 90),
        CoffeBean(degress: 90, left: -50, top: 5),
        CoffeBean(degress: 10, left: -70, top: 140),
        CoffeBean(degress: 75, right: -20, top: 150),
        CoffeBean(degress: 100, right: -70, top: 300),
        CoffeBean(degress: 155, right: 70, top: 350),
      ]),
    );
  }
}

class CoffeBean extends StatelessWidget {
  final double? top, left, right, bottom, degress;
  const CoffeBean({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.degress,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.rotate(
        angle: degress! * pi / 190,
        child: SvgPicture.asset(
          'images/coffee-bean.svg',
          width: 150,
        ),
      ),
    );
  }
}
