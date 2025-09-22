import 'package:flutter/material.dart';
import 'package:shopping_cart/models/products_models.dart';
import 'package:shopping_cart/services/products_service.dart';
import 'package:shopping_cart/services/produtcs_sqlite.dart';

class ProductListProvider extends ChangeNotifier {
  List<ProductModels> _product = [];
  List<ProductModels> _productSQLite = [];
  ProdutcsSqlite? _service;

  List<ProductModels> get product => _product;
  List<ProductModels> get productSQLite => _productSQLite;

  void setService(ProdutcsSqlite service) {
    _service = service;
  }

  Future<void> getProducts() async {
    final List<ProductModels> _products = await ProductsService().getProduct();
    _product = _products;
    notifyListeners();
  }

  Future<void> SqLiteGetProducts() async {
    if (_service == null) return;
    List<ProductModels> _produtcsSQ = await _service!.getProducts();
    _productSQLite = _produtcsSQ;
    notifyListeners();
  }
}
