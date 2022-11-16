import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
StateNotifierProvider<ProductListViewStore, List<Product>>((ref){
  List<Product> productList = ref.read(productHttpRepository).findAll();
  return ProductListViewStore(productList);
});

// 해당 화면에 필요한 모든 데이터는 이 뷰 모델에 있어야 한다.
class ProductListViewStore extends StateNotifier<List<Product>>{
  ProductListViewStore(super.state);

  // 데이터 갱신
  void onRefresh(List<Product> products){
    state = products;
  }

  void addProduct(Product productRespDto) {
    // 깊은 복사로 새 객체 생성 = 레퍼런트 주소 달라짐
    // 변경된 값이 아니라 변경된 레퍼런트 주소를 통해 변경 감지를 위해 깊은 복사가 필요.
    // 변경 감지 후 둘을 비교해 변경된 객체를 적용하게 된다.
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    // 깊은 복사로 id가 같지 않은 것을 걸러내고 새 리스트를 만들어주면 된다.
    state = state.where((product) => product.id != id).toList();
  }

}