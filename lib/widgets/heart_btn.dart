import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class HeartBottonWidget extends StatefulWidget {
  const HeartBottonWidget({
    super.key,
    this.size = 22,
    this.color = Colors.transparent,
    required this.productId,
  });
  final double size;
  final Color? color;
  final String productId;
  @override
  State<HeartBottonWidget> createState() => _HeartBottonWidgetState();
}

class _HeartBottonWidgetState extends State<HeartBottonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishlistProvider>(context);
    return Material(
      color: widget.color,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: () {
          wishListProvider.addOrRemoveFromWishlist(productId: widget.productId);
        },
        icon: Icon(
          wishListProvider.isProductOnWishlist(productID: widget.productId)
              ? IconlyBold.heart
              : IconlyLight.heart,
          size: widget.size,
          color:
              wishListProvider.isProductOnWishlist(productID: widget.productId)
                  ? Colors.red
                  : Colors.grey,
        ),
      ),
    );
  }
}
