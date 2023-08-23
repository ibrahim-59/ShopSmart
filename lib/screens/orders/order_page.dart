import 'package:e_commerce/screens/orders/orders_widget.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/widgets/empty_bage.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({Key? key}) : super(key: key);

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleWidget(
            title: 'Placed orders',
          ),
        ),
        body: isEmptyOrders
            ? EmptyBagScreen(
                image: AssetsManager.orderBag,
                title: "No orders has been placed yet",
                subtitle: "",
                textbutton: "Shop now")
            : ListView.separated(
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
