import 'package:http/http.dart' as http;
import 'package:shopping_cart/models/products_models.dart';
import 'dart:convert';

class ProductsService {
  Future<List<ProductModels>> getProduct() async {
    final url = Uri.parse('https://fakestoreapi.com/products');

    final response = await http.get(url);

    if (response.statusCode== 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => ProductModels.fromJson(e)).toList();
    } else {
      throw Exception('Ürünler listelenirken hata oluştu!');
    }
  }
}
