import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/viewed_prod_provider.dart';
import 'package:e_commerce/screens/inner_screens/product_details.dart';
import 'package:e_commerce/widgets/heart_btn.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final String productId;
  const ProductWidget({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrentProduct = productProvider.findBuyProductId(productId);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                viewedProdProvider.addProductToHistory(
                    productId: getCurrentProduct.productId);
                await Navigator.pushNamed(context, ProductDetails.routeName,
                    arguments: getCurrentProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      width: double.infinity,
                      height: size.height * 0.22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 5,
                          child: TitleWidget(
                            title: getCurrentProduct.productTitle,
                            maxLines: 2,
                            fontsize: 18,
                          )),
                      Flexible(
                        flex: 2,
                        child: HeartBottonWidget(
                          productId: getCurrentProduct.productId,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: SubTitlewidget(
                                title: '${getCurrentProduct.productPrice}\$')),
                        Material(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.lightBlue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: Colors.red,
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                if (cartProvider.isProductOnCart(
                                    productID: getCurrentProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                  productId: getCurrentProduct.productId,
                                );
                              },
                              child: Icon(cartProvider.isProductOnCart(
                                      productID: getCurrentProduct.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
  }
}
