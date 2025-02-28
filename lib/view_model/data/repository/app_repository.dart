import 'package:ecommerce_task/view_model/data/remote/api_helper.dart';
import 'package:ecommerce_task/view_model/data/remote/urls.dart';

class AppRepository{
ApiHelper apiHelper;
AppRepository({required this.apiHelper});


Future<dynamic> getProduct() async{

  try{
    var responseBody = await apiHelper.getProductApi(url: Urls.PRODUCT_URL);
    return responseBody;
  }catch (e){
    rethrow;
  }

}


}