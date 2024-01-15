import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concept/data/cart_items.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartProductRemovedCartActionState());
    emit(CartSuccessState(cartItems: cartItems));

    //run a function to remove that product model from that cartItems
    //emit cartItemRemovedState
  }
}
