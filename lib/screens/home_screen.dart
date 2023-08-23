import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/const/app_const.dart';
import 'package:e_commerce/providers/product_provider.dart';

import 'package:e_commerce/widgets/app_name_widget.dart';
import 'package:e_commerce/widgets/product/ctg_rounded_widget.dart';
import 'package:e_commerce/widgets/product/latest_products.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const AppNameWidget(),
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('assets/images/bag/shopping_cart.png'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: size.height * 0.24,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          AppConstants.BannersImages[index],
                          fit: BoxFit.fill,
                        );
                      },
                      autoplay: true,
                      itemCount: AppConstants.BannersImages.length,
                      pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.grey, activeColor: Colors.red)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const TitleWidget(
                  title: 'Latest Arrival',
                  fontsize: 22,
                ),
                const SizedBox(
                  height: 14,
                ),
                SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productProvider.getProducts[index],
                            child: const LatestProducts());
                      }),
                ),
                const SizedBox(
                  height: 14,
                ),
                const TitleWidget(
                  title: 'Categories',
                  fontsize: 22,
                ),
                const SizedBox(
                  height: 14,
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children: List.generate(AppConstants.CategoriesList.length,
                        (index) {
                      return CategoriesRoundedWidget(
                          image: AppConstants.CategoriesList[index].image,
                          name: AppConstants.CategoriesList[index].name);
                    }))
              ],
            ),
          ),
        ));
  }
}
