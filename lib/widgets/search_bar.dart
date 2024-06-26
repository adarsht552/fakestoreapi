import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assingment/provider/product_provider.dart';

class SearchBarp extends StatefulWidget {
  @override
  _SearchBarpState createState() => _SearchBarpState();
}

class _SearchBarpState extends State<SearchBarp> {
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchProducts(String query) async {
    if (query.isNotEmpty) {
      await Provider.of<ProductProvider>(context, listen: false).fetchProducts('', '', query: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            _searchProducts(value);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                _searchProducts('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
