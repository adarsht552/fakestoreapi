import 'package:assingment/provider/cart_provider.dart';
import 'package:assingment/screens/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return GridTile(
      child: GestureDetector(
        onTap: () {
          cart.addItem(product.id.toString(), product.price, product.title);
        },
        child: Image.network(
          product.image,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            cart.addItem(product.id.toString(), product.price, product.title);
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Added item to cart!'),
            //     duration: Duration(seconds: 2),
            //     action: SnackBarAction(
            //       label: 'UNDO',
            //       onPressed: () {
            //         cart.removeItem(product.id.toString());
            //       },
            //     ),
            //   ),
            // );
          },
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
