import 'package:e_commerce/const/theme_data.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/providers/theme_provider.dart';
import 'package:e_commerce/providers/viewed_prod_provider.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/screens/auth/forget_pass_screen.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/auth/sign_up_screen.dart';
import 'package:e_commerce/screens/inner_screens/product_details.dart';
import 'package:e_commerce/screens/inner_screens/viewed_recently_screen.dart';
import 'package:e_commerce/screens/inner_screens/wishlist_scree.dart';
import 'package:e_commerce/screens/orders/order_page.dart';
import 'package:e_commerce/screens/root_screen.dart';
import 'package:e_commerce/screens/search_screen.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            Scaffold(
              body: Center(
                child: TitleWidget(
                    title: 'An error has been occured ${snapshot.error}'),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) {
                  return ThemeProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return ProductProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return CartProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return WishlistProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return ViewedProdProvider();
                },
              ),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Styles.themeData(
                    isDarktheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const RootScreen(),
                // home: const LoginScreen(),
                routes: {
                  ProductDetails.routeName: (context) => const ProductDetails(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  WishListtScreen.routName: (context) =>
                      const WishListtScreen(),
                  SignupScreen.routeName: (context) => const SignupScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  RootScreen.routeName: (context) => const RootScreen(),
                },
              );
            }),
          );
        });
  }
}
