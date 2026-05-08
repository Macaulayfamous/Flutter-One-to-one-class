import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_app/models/cart_model.dart';
import 'package:multi_app/models/product_model.dart';
import 'package:multi_app/provider/cart_notifier.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartPro = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Text(
                widget.product.productName,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                '\$${widget.product.productPrice}',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Center(
                child: Text(
                  'About',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                ),
              ),

              Text(
                widget.product.description,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(8),
          ),

          child: Center(
            child: InkWell(
              onTap: () {
                cartPro.addProduct(
                  CartModel(
                    id: widget.product.id,
                    productName: widget.product.productName,
                    category: widget.product.category,
                    productPrice: widget.product.productPrice,
                    imageUrl: widget.product.imageUrl,
                    description: widget.product.description,
                    vendor: widget.product.vendor,
                    quantity: 1
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Product Added ${widget.product.productName}",
                    ),
                  ),
                );
              },
              child: Text(
                'ADD TO CART',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
