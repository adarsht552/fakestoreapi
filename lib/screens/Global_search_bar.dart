
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List searchResults = [];

  Future<void> searchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products?q=${_searchController.text}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        searchResults = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search products...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: searchProducts,
          ),
        ),
      ),
    );
  }
}
