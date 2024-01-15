import 'package:bloc_concept/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_concept/features/home/bloc/home_bloc.dart';
import 'package:bloc_concept/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class CartTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const CartTileWidget({super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(productDataModel.imageUrl))),
                height: 200,
                width: double.maxFinite,
              ),
              Text(
                productDataModel.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(productDataModel.description),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'P ' + productDataModel.price.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // cartBloc.add(
                          //   HomeProductWishlistButtonClickedEvent(
                          //     clickedProduct: productDataModel
                          //   ),
                          //  );
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartBloc.add(CartRemoveFromCartEvent(productDataModel: productDataModel));
                        },
                        icon: const Icon(
                          Icons.shopping_basket,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
