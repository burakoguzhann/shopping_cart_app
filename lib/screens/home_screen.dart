import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/providers/cart_provider.dart';
import 'package:shopping_cart/providers/product_list_provider.dart';
import 'package:shopping_cart/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).sharedOku();
    Future.microtask(
      () => Provider.of<ProductListProvider>(
        context,
        listen: false,
      ).getProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListProvider>(context);
    final _providerCart = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsetsGeometry.only(right: 40.r),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_cart_outlined, size: 110.r),
              ),
            ),
          ],
          title: Text(
            'Ürünler',
          ),
        ),
        body: ListView.builder(
          itemCount: _provider.product.length,
          itemBuilder: (context, index) {
            final _item = _provider.product[index];
            return Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(45.r),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(
                    horizontal: 50.w,
                    vertical: 25.h,
                  ),
                  child: ListTile(
                    title: Text(_item.title),
                    subtitle: Text('${_item.price.toString()} USD'),
                  ),
                ),
                Positioned(
                  right: 55.r,
                  bottom: 5.r,
                  child: TextButton(
                    onPressed: () {
                      _providerCart.sepeteEkle(_item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ürün sepete eklendi!')),
                      );
                    },
                    child: Text('Sepete Ekle'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
