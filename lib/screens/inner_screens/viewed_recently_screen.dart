import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/widgets/empty_bage.dart';
import 'package:e_commerce/widgets/title_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/viewed_prod_provider.dart';
import '../../widgets/product/product_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});
  static const routName = '/ViewedRecentlyScreen';
  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    // Size size = MediaQuery.of(context).size;
    return viewedProdProvider.getViewedProdItems.isEmpty
        ? Scaffold(
            body: EmptyBagScreen(
            subtitle:
                'looks like you don\'t anything yet to your cart \ngo ahead and start shopping now ',
            title: 'Your Viewd Recently is empty',
            image: AssetsManager.recent,
            textbutton: 'Shop now',
          ))
        : Scaffold(
            appBar: AppBar(
              title: TitleWidget(
                  title:
                      'Viewd Recently (${viewedProdProvider.getViewedProdItems.length})'),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              // actions: [
              //   IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              // ],
            ),
            body: DynamicHeightGridView(
              itemCount: viewedProdProvider.getViewedProdItems.length,
              crossAxisCount: 2,
              builder: (context, index) {
                return ProductWidget(
                  productId: viewedProdProvider.getViewedProdItems.values
                      .toList()[index]
                      .productId,
                );
              },
            ));
  }
}
