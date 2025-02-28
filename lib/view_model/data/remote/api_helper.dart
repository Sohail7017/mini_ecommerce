

import 'dart:convert';
import 'dart:io';


import 'package:ecommerce_task/view_model/data/remote/app_exception.dart';
import 'package:http/http.dart' as http;







class ApiHelper{
  Future<dynamic> getProductApi({required String url}) async{
    var uri = Uri.parse(url);

    try{
      var res = await http.get(uri);
      return returnJsonResponse(res);
    }on SocketException catch(e){
      throw (FetchDataException(errMsg:  "No Internet!!"));
    }
  }

  dynamic returnJsonResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        {
          var mData =jsonDecode(response.body);
          return mData;
        }
      case 400:
        throw BadRequestException(errMsg: response.body.toString());
      case 401:
      case 403:
        throw UnAuthorisedException(errMsg: response.body.toString());
      case 500:
      default:
        throw FetchDataException(errMsg: 'Error occurred while communication with server with statusCode : ${response.statusCode}');
    }
  }


}