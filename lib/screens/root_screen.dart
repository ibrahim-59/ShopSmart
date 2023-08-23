import 'package:e_commerce/screens/cart/cart_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/profile_screen.dart';
import 'package:e_commerce/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/RootScreen';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentPage = 0;
  late PageController controller;
  List<Widget> Screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: Screens,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (value) {
          setState(() {
            _currentPage = value;
          });
          controller.jumpToPage(_currentPage);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag_2),
            icon: Badge(
                backgroundColor: Colors.blue,
                label: Text(cartProvider.getCartItems.length.toString()),
                child: const Icon(IconlyLight.bag_2)),
            label: 'Cart',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
