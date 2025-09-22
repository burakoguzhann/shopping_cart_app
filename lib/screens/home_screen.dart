import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/models/products_models.dart';
import 'package:shopping_cart/providers/cart_provider.dart';
import 'package:shopping_cart/providers/product_list_provider.dart';
import 'package:shopping_cart/screens/cart_screen.dart';
import 'package:shopping_cart/services/produtcs_sqlite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _productsSQService = ProdutcsSqlite();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _productsSQService.OpenDatabaseProduct();
      Provider.of<ProductListProvider>(context, listen: false)
          .setService(_productsSQService);
      Provider.of<CartProvider>(context, listen: false).sharedOku();
      Provider.of<CartProvider>(context, listen: false).sharedOkuSQLite();
      await Provider.of<ProductListProvider>(context, listen: false).getProducts();
      await Provider.of<ProductListProvider>(context, listen: false).SqLiteGetProducts();
    });
  }

  Future<void> handleInsertProducts() async {
    final productModel = ProductModels(
      title: _titleController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      quantity: 1, // Default quantity
    );

    await _productsSQService.insertProducts(productModel);

    _titleController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductListProvider>(context);
    final _providerSQ = Provider.of<ProductListProvider>(context).productSQLite;
    final _providerCart = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 40.r),
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
          title: TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  final mediaQuery = MediaQuery.of(context);
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 24,
                        bottom: mediaQuery.viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          height: 350,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  labelText: 'Başlık',
                                ),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                controller: _priceController,
                                decoration: InputDecoration(labelText: 'Fiyat'),
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  await handleInsertProducts();
                                  await Provider.of<ProductListProvider>(context, listen: false)
                                      .SqLiteGetProducts();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Ürün eklenmiştir')),
                                  );
                                },
                                child: Text('Ekle'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('Ürün Ekle'),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _provider.product.length,
                itemBuilder: (context, index) {
                  final _item = _provider.product[index];
                  return Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.r),
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
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: _providerSQ.length,
                itemBuilder: (context, index) {
                  final _item2 = _providerSQ[index];
                  return Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.r),
                        ),
                        elevation: 4,
                        margin: EdgeInsets.symmetric(
                          horizontal: 50.w,
                          vertical: 25.h,
                        ),
                        child: ListTile(
                          title: Text(_item2.title),
                          subtitle: Text('${_item2.price.toString()} USD'),
                        ),
                      ),
                      Positioned(
                        right: 55.r,
                        bottom: 5.r,
                        child: TextButton(
                          onPressed: () {
                            _providerCart.sepeteEkleSQLite(_item2);
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
          ],
        ),
      ),
    );
  }
}
