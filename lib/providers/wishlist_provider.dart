import 'package:e_commerce/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishListItems => _wishlistItems;

  bool isProductOnWishlist({required String productID}) {
    return _wishlistItems.containsKey(productID);
  }

  void addOrRemoveFromWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      _wishlistItems.remove(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(id: const Uuid().v4(), productId: productId),
      );
    }

    notifyListeners();
  }

  void ClearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
