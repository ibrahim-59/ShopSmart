import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/cart/bottom_checkout.dart';
import 'package:e_commerce/screens/cart/cart_widget.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/services/my_app_methods.dart';
import 'package:e_commerce/widgets/empty_bage.dart';
import 'package:e_commerce/widgets/title_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // Size size = MediaQuery.of(context).size;
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBagScreen(
            subtitle:
                'looks like you don\'t anything yet to your cart \ngo ahead and start shopping now ',
            title: 'Your cart is empty',
            image: AssetsManager.shoppingCart,
            textbutton: 'Shop now',
          ))
        : Scaffold(
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title: TitleWidget(
                  title: 'Cart(${cartProvider.getCartItems.length})'),
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
                          cartProvider.ClearCart();
                        },
                        isError: false,
                      );
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            body: ListView.builder(
                itemCount: cartProvider.getCartItems.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values
                          .toList()
                          .reversed
                          .toList()[index],
                      child: const CartWidget());
                }),
          );
  }
}
