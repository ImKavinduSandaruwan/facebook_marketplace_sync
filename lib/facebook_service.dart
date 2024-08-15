import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FacebookService {
  static Future<String?> getFacebookAccessToken() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['catalog_management'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        return accessToken.token;
      }
    } catch (e) {
      print('Error getting Facebook access token: $e');
    }
    return null;
  }

  static Future<bool> addProductToFacebookMarketplace(String accessToken, Map<String, dynamic> product) async {
    final url = 'https://graph.facebook.com/v16.0/me/products';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(product),
      );

      if (response.statusCode == 200) {
        print('Product added successfully');
        return true;
      } else {
        print('Failed to add product: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error adding product to Facebook Marketplace: $e');
      return false;
    }
  }

  static Future<List<dynamic>> getFacebookMarketplaceProducts(String accessToken) async {
    final url = 'https://graph.facebook.com/v16.0/me/products';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      } else {
        print('Failed to fetch products: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching Facebook Marketplace products: $e');
      return [];
    }
  }
}