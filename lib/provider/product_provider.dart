import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math'; // For random number generation

import 'package:assingment/screens/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts(String sort, String category, {required String query}) async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      List<Product> loadedProducts = [];
      final List<dynamic> extractedData = jsonDecode(response.body) as List<dynamic>;
      
      // Convert JSON data to Product objects
      loadedProducts = extractedData.map((productData) => Product.fromJson(productData)).toList();
      
      // Shuffle the list of products randomly
      loadedProducts.shuffle(Random());

      // Assign shuffled products to _products
      _products = loadedProducts;
      
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
