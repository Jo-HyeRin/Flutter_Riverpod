import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
StateNotifierProvider<ProductListViewStore, List<Product>>((ref){
  // ref.read(productHttpRepository).findAll(); // await/async 가 필요하므로 여기서 이용 불가능.
  return ProductListViewStore([],ref)..initViewModel(); // 1. 초기화는 빈 배열을 넣고 ref를 넣어 창고에 접근가능하게 한다.
});

// 해당 화면에 필요한 모든 데이터는 이 뷰 모델에 있어야 한다.
class ProductListViewStore extends StateNotifier<List<Product>>{
  Ref _ref;
  ProductListViewStore(super.state, this._ref); // 2. 상태에는 빈배열 넣고(ProductHttpRepository 사용하기 위해), ref도 넣어준다.

  void initViewModel() async {
    List<Product> productList = await _ref.read(productHttpRepository).findAll();
    state = productList;
  }

  // 데이터 갱신
  void onRefresh(List<Product> productList){
    state = productList;
  }

  void addProduct(Product productRespDto) {
    // 깊은 복사로 새 객체 생성 = 레퍼런트 주소 달라짐
    // 변경된 값이 아니라 변경된 레퍼런트 주소를 통해 변경 감지를 위해 깊은 복사가 필요.
    // 변경 감지 후 둘을 비교해 변경된 객체를 적용하게 된다.
    state = [...state, productRespDto];
  }

  void removeProduct(int id) {
    // 깊은 복사로 id가 같지 않은 데이터만으로 새 리스트 생성.
    state = state.where((product) => product.id != id).toList();
  }

  void updateProduct(int id, Product productRespDto) {
    state = state.map<Product>((product){
      if(product.id == productRespDto.id){
        return productRespDto;
      }else{
        return product;
      }
    }).toList();
  }

}