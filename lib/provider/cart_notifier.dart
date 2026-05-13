
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_app/models/cart_model.dart';

class CartNotifier  extends Notifier<Map<String, CartModel>> {
  @override 
  Map<String,CartModel> build(){
    return {};
  }

 void addProduct (CartModel model){
   state = {...state, model.id:model };
 }

 void increment(String id){
  //Get the cart item
  final item = state[id];

  //increase the quantity by 1

  item!.quantity++;

  //update the state so the ui refreshes
  state = {...state};
 }

 void decrement(String id){
  final item = state[id];
  if(item!.quantity> 1){
     item.quantity--;
     state = {...state};
  }else{
    final newState = {...state};

    newState.remove(id);

    state = newState;
  }
 }


double getTotal(){
  double total = 0.0;
  for(var item in state.values){
    total += item.productPrice  * item.quantity;
  }

  return total;
}
}




final  cartProvider = NotifierProvider<CartNotifier,Map<String, CartModel>>(
  CartNotifier.new
);