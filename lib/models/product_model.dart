import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productTitle,
      productId,
      productPrice,
      productCategory,
      productDescription,
      productImage,
      productQuantity;

  ProductModel({
    required this.productTitle,
    required this.productId,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
  });
}
