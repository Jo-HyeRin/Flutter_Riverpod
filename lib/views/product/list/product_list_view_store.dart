import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
StateNotifierProvider<ProductListViewStore, List<Product>>((ref){
  return ProductListViewStore(ref.read(productHttpRepository).findAll());
});

// 해당 화면에 필요한 모든 데이터는 이 뷰 모델에 있어야 한다.
class ProductListViewStore extends StateNotifier<List<Product>>{
  ProductListViewStore(super.state);

  // 데이터 갱신
  void onRefresh(List<Product> products){
    state = products;
  }

}