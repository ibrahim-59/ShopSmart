import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/services/my_app_methods.dart';
import 'package:e_commerce/widgets/empty_bage.dart';
import 'package:e_commerce/widgets/title_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/product/product_widget.dart';

class WishListtScreen extends StatelessWidget {
  const WishListtScreen({super.key});
  static const routName = '/WishListtScreen';
  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    // Size size = MediaQuery.of(context).size;
    return wishlistProvider.getWishListItems.isEmpty
        ? Scaffold(
            body: EmptyBagScreen(
            subtitle:
                'looks like you don\'t anything yet to your cart \ngo ahead and start shopping now ',
            title: 'Your Wishlist is empty',
            image: AssetsManager.bagWish,
            textbutton: 'Shop now',
          ))
        : Scaffold(
            appBar: AppBar(
              title: TitleWidget(
                  title:
                      'Wishlist (${wishlistProvider.getWishListItems.length})'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      MyAppMethods.showErrorOrWaringDialog(
                        context: context,
                        subTitle: 'Remove Items',
                        ftc: () {
                          wishlistProvider.ClearWishlist();
                        },
                        isError: false,
                      );
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishListItems.length,
              crossAxisCount: 2,
              builder: (context, index) {
                return ProductWidget(
                  productId: wishlistProvider.getWishListItems.values
                      .toList()[index]
                      .productId,
                );
              },
            ));
  }
}
