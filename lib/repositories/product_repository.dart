import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/services/api_service.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> getProducts() async {
    final rawData = await _apiService.fetchProducts();
    return rawData.map((json) => Product.fromJson(json)).toList();
  }
}
