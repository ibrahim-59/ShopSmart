import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/viewed_prod_provider.dart';
import 'package:e_commerce/screens/inner_screens/product_details.dart';
import 'package:e_commerce/widgets/heart_btn.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestProducts extends StatelessWidget {
  const LatestProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productModelProvider = Provider.of<ProductModel>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addProductToHistory(
              productId: productModelProvider.productId);
          await Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: productModelProvider.productId);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FancyShimmerImage(
                    imageUrl: productModelProvider.productImage,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModelProvider.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            HeartBottonWidget(
                              productId: productModelProvider.productId,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.add_shopping_cart_outlined)),
                          ],
                        ),
                      ),
                      FittedBox(
                          child: SubTitlewidget(
                        title: '${productModelProvider.productPrice}\$',
                        color: Colors.blue,
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
