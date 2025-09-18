import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/models/products_models.dart';
import 'package:shopping_cart/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                _cartProvider.sharedSil();
              },
              icon: Icon(Icons.delete),
            ),
          ],
          title: Text(
            'Sepetteki Ürün Sayısı: (${_cartProvider.cartlist.length})',
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartProvider.cartlist.length,
                itemBuilder: (context, index) {
                  final item = _cartProvider.cartlist[index];
                  return Stack(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(66.r),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 55.w,
                          vertical: 25.h,
                        ),
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text('${item.price * item.quantity} USD'),
                        ),
                      ),
                      Positioned(
                        right: 120.r,
                        bottom: 100.r,
                        child: Text(item.quantity.toString()),
                      ),
                      Positioned(
                        right: 305.r,
                        bottom: 6.r,
                        child: IconButton(
                          onPressed: () {
                            _cartProvider.sayacArtir(index);
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                      ),
                      Positioned(
                        right: 200.r,
                        bottom: 6.r,
                        child: IconButton(
                          onPressed: () {
                            _cartProvider.sayacAzalt(index);
                          },
                          icon: Icon(Icons.remove_circle_outline),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100.r),
              child: Text(
                ' Toplam: ${_cartProvider.toplamHesapla().toStringAsFixed(2)} USD ',
                style: TextStyle(fontSize: 65.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
