import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/product_provider.dart';
// import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/widgets/app_name_widget.dart';
import 'package:e_commerce/widgets/product/product_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController SearchController = TextEditingController();
  @override
  void dispose() {
    SearchController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];

  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findBuyCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const AppNameWidget(),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/bag/shopping_cart.png'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: SearchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          SearchController.clear();
                          FocusScope.of(context).unfocus();
                        });
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      productListSearch = productProvider.searchQuery(
                        searchText: SearchController.text,
                        passedList: productList,
                      );
                    });
                  },
                  // onChanged: (value) {
                  //   setState(() {
                  //     productListSearch = productProvider.searchQuery(
                  //       searchText: SearchController.text,
                  //     );
                  //   });
                  // },
                ),
                const SizedBox(
                  height: 20,
                ),
                if (SearchController.text.isNotEmpty &&
                    productListSearch.isEmpty) ...[
                  const Center(
                    child: TitleWidget(
                      title: 'there is no items',
                      fontsize: 40,
                    ),
                  ),
                ],
                Expanded(
                  child: DynamicHeightGridView(
                    itemCount: SearchController.text.isNotEmpty
                        ? productListSearch.length
                        : productList.length,
                    crossAxisCount: 2,
                    builder: (context, index) {
                      return ProductWidget(
                        productId: SearchController.text.isNotEmpty
                            ? productListSearch[index].productId
                            : productList[index].productId,
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
