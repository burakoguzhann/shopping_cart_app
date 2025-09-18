import 'package:flutter/material.dart';
import 'package:shopping_cart/models/products_models.dart';
import 'package:shopping_cart/services/products_service.dart';

class ProductListProvider extends ChangeNotifier {
  List<ProductModels> _product = [];

  List<ProductModels> get product => _product;

  void getProducts() async {
    List<ProductModels> productsdata = await ProductsService().getProduct();
    _product = productsdata;
    notifyListeners();
  }
}
