// cart_provider.dart
import 'package:demod/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {

bool done=false;
bool removed=false;
  Future<void> addToCart(Cart cart) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/cart/addtocart');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $_token',
      },
      body: json.encode({
        'productId': cart.id,
        'userEmail':cart.email
      }),
    );

    if (response.statusCode == 202) {
      done=true;
       notifyListeners();
      // totalAdded=json.decode(response.body)['totalPrice'].toString();
     // _items.add(CartItem.fromJson(json.decode(response.body)));
     
    } else {
      throw Exception('Failed to add to cart');
    }
  }

  Future<void> removeFromCart(int productId,String email) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/cart/deletecart/$email/$productId');
    final response = await http.delete(
      url,
      // headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 410) {
      removed=true;
          notifyListeners();
    //  totalRemoved=json.decode(response.body)['numberOfPieces'].toString();
      
    } else {
      throw Exception('Failed to remove from cart');
    }

  }
}