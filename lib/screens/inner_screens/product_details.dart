import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/widgets/app_name_widget.dart';
import 'package:e_commerce/widgets/heart_btn.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final currentProduct = productProvider.findBuyProductId(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameWidget(),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: currentProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  FancyShimmerImage(
                    imageUrl: currentProduct.productImage,
                    height: size.height * 0.38,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              currentProduct.productTitle,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          SubTitlewidget(
                            title: '${currentProduct.productPrice}\$',
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HeartBottonWidget(
                              productId: currentProduct.productId,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: kBottomNavigationBarHeight - 10,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: () {
                                    if (cartProvider.isProductOnCart(
                                        productID: currentProduct.productId)) {
                                      return;
                                    }
                                    cartProvider.addProductToCart(
                                      productId: currentProduct.productId,
                                    );
                                  },
                                  icon: Icon(cartProvider.isProductOnCart(
                                          productID: currentProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_outlined),
                                  label: Text(cartProvider.isProductOnCart(
                                          productID: currentProduct.productId)
                                      ? 'In Cart'
                                      : 'Add To Cart'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TitleWidget(title: 'About this item'),
                          SubTitlewidget(
                            title: 'In ${currentProduct.productCategory}',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SubTitlewidget(title: currentProduct.productDescription),
                    ],
                  )
                ]),
              ),
            ),
    );
  }
}
