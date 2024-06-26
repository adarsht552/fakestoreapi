import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assingment/provider/product_provider.dart';
import 'package:assingment/screens/cart_screen.dart';
import 'package:assingment/widgets/product_item.dart';
import 'package:assingment/widgets/search_bar.dart';
import 'package:assingment/provider/cart_provider.dart'; // Import CartProvider

class ProductListingScreen extends StatefulWidget {
  static const routeName = '/products';

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String _sort = 'asc';
  String _category = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts({String query = ''}) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchProducts(_sort, _category, query: query);
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    final cart = Provider.of<CartProvider>(context); // Access CartProvider

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child:  Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SearchBarp(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              // Display cart item count here
              cart.itemCount == 0
                  ? Container()
                  : Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Text(
                          cart.itemCount.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(width: 16.0),
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _sort,
                  items: const [
                    DropdownMenuItem(value: 'asc', child: Text('Price: Low to High')),
                    DropdownMenuItem(value: 'desc', child: Text('Price: High to Low')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _sort = value!;
                      _fetchProducts();
                    });
                  },
                ),
                const SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _category,
                  items: const [
                    DropdownMenuItem(value: '', child: Text('All Categories')),
                    DropdownMenuItem(value: 'electronics', child: Text('Electronics')),
                    DropdownMenuItem(value: 'jewelry', child: Text('Jewelry')),
                    DropdownMenuItem(value: 'men\'s clothing', child: Text('Men\'s Clothing')),
                    DropdownMenuItem(value: 'women\'s clothing', child: Text('Women\'s Clothing')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                      _fetchProducts();
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
        Expanded(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemBuilder: (ctx, index) {
        return ProductItem(products[index]);
      },
    ),
  ),
),

        ],
      ),
    );
  }
}
