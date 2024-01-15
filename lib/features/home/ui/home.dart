import 'package:bloc_concept/features/cart/ui/cart.dart';
import 'package:bloc_concept/features/home/bloc/home_bloc.dart';
import 'package:bloc_concept/features/home/ui/product_tile_widget.dart';
import 'package:bloc_concept/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Wishlist(),
            ),
          );
        } else if (state is HomeProductAddedCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Item Added")));
        } else if (state is HomeProductAddedWishlistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item Wishlisted")));

        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return _homeLoadingWidget();
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return _homeLoadedSuccess(successState);
          case HomeErrorState:
            return _homeErrorWidget();
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _homeLoadingWidget() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _homeLoadedSuccess(HomeLoadedSuccessState successState) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Grocery App',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              homeBloc.add(
                HomeWishlistButtonNavigateEvent(),
              );
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              homeBloc.add(HomeCartButtonNavigateEvent());
            },
            icon: const Icon(
              Icons.shopping_basket_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: successState.products.length,
          itemBuilder: (context, index) {
            return ProductTileWidget(
                productDataModel: successState.products[index],homeBloc: homeBloc,);
          }),
    );
  }
}

Widget _homeErrorWidget() {
  return const Scaffold(
    body: Center(
      child: Text('Error'),
    ),
  );
}
