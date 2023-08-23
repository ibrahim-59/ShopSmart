import 'package:e_commerce/models/viwed_prod_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _ViewedProdItems = {};

  Map<String, ViewedProdModel> get getViewedProdItems => _ViewedProdItems;

  void addProductToHistory({required String productId}) {
    _ViewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(id: const Uuid().v4(), productId: productId),
    );

    notifyListeners();
  }
}
