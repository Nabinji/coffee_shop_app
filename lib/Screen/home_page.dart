import 'dart:math';
import 'package:flutter/material.dart';

import '../Utils/colors.dart';
import '../models/product_model.dart';
import '../widgets/background.dart';
import '../widgets/category_item.dart';
import '../widgets/product_image.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentCategory = 0;
  int currentProduct = 0;
  PageController? controller;
  double viewPortFraction = 0.5;
  double? pageOffset = 1;
  @override
  void initState() {
    super.initState();
    controller =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = controller!.page;
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> dataProducts = products
        .where((element) => element.category == categories[currentCategory])
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "images/coffee-cup.png",
              height: 30,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qahwa',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Space',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
        actions: [
          Center(
            child: Stack(
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.amber,
                ),
                Positioned(
                  right: 3,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: firstColor, shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
      body: Stack(
        children: [
          const Background(),
          const Positioned(
            top: 30,
            left: 40,
            child: Text(
              'Smooth Out\nYour Everyday',
              style: TextStyle(
                  color: Colors.black,
                  height: 1.2,
                  fontSize: 35,
                  fontWeight: FontWeight.w900),
            ),
          ),
          // for selected items
          Positioned(
            top: 120,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                color: firstColor,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => Container(
                      height: 190,
                      width: 107,
                      color: currentCategory == index
                          ? Colors.amberAccent
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // for category items display
          Positioned(
            top: 125,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                color: firstColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(categories.length, (index) {
                      int decrease = 0;
                      int max = 1;
                      int bottomPadding = 1;
                      // for items display in curve shape
                      for (var i = 0; i < categories.length; i++) {
                        bottomPadding =
                            index > max ? index - decrease++ : index;
                      }
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentCategory = index;
                            dataProducts = products
                                .where((element) =>
                                    element.category ==
                                    categories[currentCategory])
                                .toList();
                          
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: bottomPadding.abs() * 75),
                          child: CategoryItem(
                            category: categories[index],
                          ),
                        ),
                      );
                    })),
              ),
            ),
          ),
          // for selected category items display on
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: Clip(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.58,
                width: MediaQuery.of(context).size.width,
                color: secondColor,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipPath(
                  clipper: Clip(),
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.58,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        setState(() {
                          currentProduct = value % dataProducts.length;
                        });
                      },
                      itemBuilder: (context, index) {
                        double scale = max(
                            viewPortFraction,
                            (1 -
                                (pageOffset! - index).abs() +
                                viewPortFraction));
                        double angle = 0.0;
                        final items = dataProducts[index % dataProducts.length];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(product: items),
                              ),
                            );
                          },
                          child: Hero(
                            tag: items.name,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 200 - (scale / 1.6 * 170)),
                              child: Transform.rotate(
                                angle: angle * pi,
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    ProductImage(
                                      product: items,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dataProducts[currentProduct % dataProducts.length]
                                .name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${dataProducts[currentProduct % dataProducts.length].price}0',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        dataProducts.length,
                        (index) => indicator(index),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer indicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: 3,
            color: index == currentProduct
                ? Colors.amberAccent
                : Colors.transparent),
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: index == currentProduct
              ? Colors.white
              : Colors.white60,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 100);
    path.quadraticBezierTo(size.width / 2, -40, 0, 100);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
