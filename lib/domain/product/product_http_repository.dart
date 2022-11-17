import 'dart:convert';

import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final productHttpRepository = Provider<ProductHttpRepository>((ref){
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {

  Ref _ref;
  ProductHttpRepository(this._ref);

  Product findById(int id){
    // http 통신 코드 (API 문서 보고 작성 해야 함)
    Product product = [].singleWhere((product) => product.id == id);
    return product;
  }

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    List<dynamic> dataList = jsonDecode(response.body)["data"];
    return dataList.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> insert(Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
    await _ref.read(httpConnector).post("/api/product", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  Future<int> deleteById(int id) async {
    Response response = await _ref.read(httpConnector).delete("/api/product/${id}");
    return jsonDecode(response.body)['code']; // 1 성공
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

}