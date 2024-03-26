import 'package:flutter/material.dart';

import '../Utils/colors.dart';
import '../models/product_model.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  const ProductImage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        return SizedBox(
          height: constrain.maxWidth * 1.25,
          width: constrain.maxWidth,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                width: constrain.maxWidth,
                height: constrain.maxWidth*0.9,
                decoration:
                    const BoxDecoration(color: thirdColor, shape: BoxShape.circle),
              ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(constrain.maxWidth * 0.45)),
                child: SizedBox(
                  width: constrain.maxWidth * 0.9,
                  height: constrain.maxWidth * 2,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Positioned(
                        bottom: -60,
                        width: constrain.maxWidth * 0.9,
                        height: constrain.maxWidth * 1.5,
                        child: Image.asset(
                          'images/${product.image}',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
