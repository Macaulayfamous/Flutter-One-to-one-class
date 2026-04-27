
import 'package:flutter/material.dart';
import 'package:multi_app/controllers/product_controller.dart';
import 'package:multi_app/models/product_model.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final ProductController _productController = ProductController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(future: _productController.getProducts(),
     builder: (context, snapshot){
      if(snapshot.connectionState ==ConnectionState.waiting){
        return SizedBox(
          height: 180,
          child: Center(child: CircularProgressIndicator(),),
        );

         
      }

      if(snapshot.hasError){
        return Center(child: Text(snapshot.error.toString()),);
      }
      final products = snapshot.data ?? [];
      if(products.isEmpty){
        return Center(child: Text('No products found'),);
      }

      return GridView.builder(
        itemCount: products.length,
        gridDelegate:
       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (_, index){
        final product = products[index];

        return Card(
          elevation: 1,
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        );
       });
     });
  }
}