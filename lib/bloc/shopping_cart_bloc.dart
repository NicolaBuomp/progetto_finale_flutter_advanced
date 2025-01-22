import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progetto_finale_flutter_advanced/model/product_model.dart';

class ShoppingCartBloc
    extends Bloc<ShoppingCartBlocEvent, ShoppingCartBlocState> {
  ShoppingCartBloc() : super(ShoppingCartBlocStateLoading()) {
    on<ShoppingCartBlocEventInit>((event, emit) async {
      emit(ShoppingCartBlocStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      // final products = <ProductModel>[];
      emit(ShoppingCartBlocStateLoaded(products));
    });

    on<ShoppingCartBlocEvenProductToggle>((event, emit) {
      (state as ShoppingCartBlocStateLoaded).products;

      final product =
          products.firstWhere((it) => it.name == event.product.name);
      product.inShoppingCart = !product.inShoppingCart;

      emit(ShoppingCartBlocStateLoaded(products));
    });
  }
}

abstract class ShoppingCartBlocEvent {}

class ShoppingCartBlocEventInit extends ShoppingCartBlocEvent {}

class ShoppingCartBlocEvenProductToggle extends ShoppingCartBlocEvent {
  final ProductModel product;
  ShoppingCartBlocEvenProductToggle(this.product);
}

abstract class ShoppingCartBlocState {}

class ShoppingCartBlocStateLoading extends ShoppingCartBlocState {}

class ShoppingCartBlocStateLoaded extends ShoppingCartBlocState {
  List<ProductModel> products;
  ShoppingCartBlocStateLoaded(this.products);
}
