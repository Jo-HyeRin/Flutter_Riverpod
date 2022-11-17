import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider에 ProductController를 등록하는 것.
// 필요할 때마다 창고에서 꺼내 사용할 수 있게 된다.
final productController = Provider<ProductController>((ref){
  return ProductController(ref);
});

/**
 * 컨트롤러 : 비지니스 로직 담당
 */
class ProductController {

  final context = navigatorKey.currentContext!; // main에 선언한 글로벌 키
  final Ref _ref;
  ProductController(this._ref);

  void findAll() async {
    List<Product> productList = await _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  void insert(Product productReqDto){
    Product productRespDto = _ref.read(productHttpRepository).insert(productReqDto);
    _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  }

  void deleteById(int id) {
    if(id != 4){
      int result = _ref.read(productHttpRepository).deleteById(id);
      if(result == 1){
        _ref.read(productListViewStore.notifier).removeProduct(id);
      }
    }else{
      showCupertinoDialog(context: context, builder: (context) => MyAlertDialog(msg: "삭제실패"));
    }
  }

  void updateById(int id, Product productReqDto) {
    Product productRespDto = _ref.read(productHttpRepository).updateById(id, productReqDto);
    _ref.read(productListViewStore.notifier).updateProduct(id, productRespDto);
  }

}