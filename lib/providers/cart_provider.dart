import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/models/products_models.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModels> _cartList = [];
  List<ProductModels> get cartlist => _cartList;

  Future<void> sharedEkle() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartStringList = _cartList
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList('cart', cartStringList);
  }

  Future<void> sharedOku() async {
    final prefs = await SharedPreferences.getInstance();
    final cartStringList = prefs.getStringList('cart') ?? [];

    _cartList = cartStringList
        .map((item) => ProductModels.fromJson(jsonDecode(item)))
        .toList();
    notifyListeners();
  }

Future<void> sharedSil() async{
  _cartList.clear();
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('cart');
  notifyListeners();
}

  void sepeteEkle(ProductModels product) {
    for (var item in _cartList) {
      if (item.title == product.title) {
        item.quantity++;
        return;
      }
        sharedEkle();
        notifyListeners();
    }

    _cartList.add(product);
    sharedEkle();
    notifyListeners();
  }

  void sayacArtir(int index) {
    _cartList[index].quantity++;
    sharedEkle();
    notifyListeners();
  }

  void sayacAzalt(int index) {
    if(_cartList[index].quantity > 1){
      _cartList[index].quantity--;
    } else {
      _cartList.removeAt(index);
    }
    sharedEkle();
    notifyListeners();
  }

  double toplamHesapla() {
    double toplam = 0;
    for (var item in _cartList) {
      toplam += item.price * item.quantity;
    }
    return toplam;
  }

}
