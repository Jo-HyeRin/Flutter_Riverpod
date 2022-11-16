import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider에 ProductController를 등록하는 것.
// 필요할 때마다 창고에서 꺼내 사용할 수 있게 된다.
final productController = Provider<ProductController>((ref){
  return ProductController(ref);
});

// View는 Controller 에 요청한다.
class ProductController {

  final Ref _ref;
  ProductController(this._ref);

  void findAll(){
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  void insert(Product productReqDto){
    Product productRespDto = _ref.read(productHttpRepository).insert(productReqDto);
    _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  }

}