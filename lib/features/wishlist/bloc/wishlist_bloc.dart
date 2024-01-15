import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concept/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../../home/models/home_product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromCartEvent>(wishlistRemovedFromCartEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
  emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemovedFromCartEvent(WishlistRemoveFromCartEvent event, Emitter<WishlistState> emit) {
  wishlistItems.remove(event.productDataModel);
  emit(WishlistRemovedFromCartState());
  emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
