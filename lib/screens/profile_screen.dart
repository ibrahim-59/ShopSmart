import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/screens/inner_screens/viewed_recently_screen.dart';
import 'package:e_commerce/screens/inner_screens/wishlist_scree.dart';
import 'package:e_commerce/screens/orders/order_page.dart';
import 'package:e_commerce/widgets/app_name_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../services/my_app_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const AppNameWidget(),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Visibility(
                visible: false,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child: TitleWidget(
                          title: 'Pls Login to have ultimate access ')),
                ),
              ),
              ListTile(
                title: const Text('Ibrahim Abdullah'),
                subtitle: const Text('email@gmail.com'),
                trailing: const Icon(Icons.edit),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWidget(title: 'General'),
                    const SizedBox(
                      height: 15,
                    ),
                    customListTile(
                        label: 'All Orders',
                        ImagePath: AssetsManager.orderSvg,
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrdersScreenFree.routeName);
                        }),
                    customListTile(
                        label: 'WishList',
                        ImagePath: AssetsManager.wishlistSvg,
                        onTap: () async {
                          await Navigator.pushNamed(
                              context, WishListtScreen.routName);
                        }),
                    customListTile(
                        label: 'Viewed recently',
                        ImagePath: AssetsManager.recent,
                        onTap: () async {
                          await Navigator.pushNamed(
                              context, ViewedRecentlyScreen.routName);
                        }),
                    customListTile(
                        label: 'Address',
                        ImagePath: AssetsManager.address,
                        onTap: () {}),
                    const Divider(
                      thickness: 1,
                    ),
                    const TitleWidget(title: 'Settings'),
                    const SizedBox(
                      height: 15,
                    ),
                    SwitchListTile(
                        secondary: Image.asset(
                          AssetsManager.theme,
                          height: 30,
                        ),
                        title: Text(themeProvider.getIsDarkTheme
                            ? 'Dark mode'
                            : ' Light mode'),
                        value: themeProvider.getIsDarkTheme,
                        onChanged: (value) {
                          themeProvider.setDarkTheme(themeValue: value);
                        }),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      if (user == null) {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      } else {
                        await MyAppMethods.showErrorOrWaringDialog(
                          context: context,
                          subTitle: 'Are you sure ?',
                          ftc: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          isError: false,
                        );
                      }

                      // await MyAppMethods.showErrorOrWaringDialog(
                      //   context: context,
                      //   subTitle: 'Are you sure ?',
                      //   ftc: () {},
                      //   isError: false,
                      // );
                    },
                    icon: Icon(
                        user == null ? Icons.login_outlined : Icons.logout),
                    label: Text(user == null ? 'Login' : 'Logout'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget customListTile(
      {required String label,
      required String ImagePath,
      required Function onTap}) {
    return ListTile(
      onTap: () {
        onTap();
      },
      title: TitleWidget(title: label),
      leading: Image.asset(
        ImagePath,
        height: 30,
      ),
      trailing: const Icon(IconlyLight.arrow_right_2),
    );
  }
}
