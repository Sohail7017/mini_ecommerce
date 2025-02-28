import 'package:bloc/bloc.dart';
import 'package:ecommerce_task/models/product_model.dart';
import 'package:ecommerce_task/view_model/data/repository/app_repository.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  AppRepository appRepository;
  ProductBloc({required this.appRepository}) : super(ProductInitialState()) {

    /// VIEW PRODUCT DATA
    on<ViewProductEvent>((event, emit) async{
      emit(ProductLoadingState());
      try{
          var response = await appRepository.getProduct();
          List<ProductModel> productData = (response as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();;

          emit(ProductLoadedState(productModel: productData));
        
      }catch(e){
        emit(ProductErrorState(errorMsg: e.toString()));
      }
      
      
    });
  }
}
