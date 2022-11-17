import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final pm = ref.watch(productListViewStore);
    final pc = ref.read(productController);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          //pc.insert(Product(4,'호박',2000));
        },
      ),
      appBar: AppBar(title: Text("product_list_page")),
      body: _buildListView(pm),
    );
  }

  Widget _buildListView(List<Product> pm) {

    if(!(pm.length>0)){ // 0보다 크지 않다면 = 통신이 끝나지 않았다면
      return Center(child: Image.asset('assets/image/loading.gif'));
    }else{

    }

    return ListView.builder(
      itemCount: pm.length,
      itemBuilder: (context, index) => ListTile(
        key: ValueKey(pm[index].id),
        onTap: (){
            //pc.deleteById(pm[index].id);
        },
        onLongPress: (){
          //pc.updateById(pm[index].id, Product(pm[index].id, pm[index].name, 20000));
        },
        leading: Icon(Icons.account_balance_wallet),
        title: Text("${pm[index].name}", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${pm[index].price}"),
      ),
    );
  }
}
