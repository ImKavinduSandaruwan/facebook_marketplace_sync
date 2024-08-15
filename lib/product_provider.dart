import 'package:flutter/foundation.dart';
import 'product_model.dart';
import 'facebook_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  String? _facebookAccessToken;

  List<Product> get products => _products;

  Future<void> addProduct(Product product) async {
    _products.add(product);
    notifyListeners();

    if (_facebookAccessToken != null) {
      bool success = await FacebookService.addProductToFacebookMarketplace(
        _facebookAccessToken!,
        product.toJson(),
      );
      if (success) {
        print('Product synced with Facebook Marketplace');
      } else {
        print('Failed to sync product with Facebook Marketplace');
      }
    }
  }

  Future<void> initializeFacebook() async {
    _facebookAccessToken = await FacebookService.getFacebookAccessToken();
    if (_facebookAccessToken != null) {
      await fetchFacebookProducts();
    }
  }

  Future<void> fetchFacebookProducts() async {
    if (_facebookAccessToken == null) return;

    List<dynamic> facebookProducts = await FacebookService.getFacebookMarketplaceProducts(_facebookAccessToken!);
    _products = facebookProducts.map((json) => Product.fromJson(json)).toList();
    notifyListeners();
  }
}