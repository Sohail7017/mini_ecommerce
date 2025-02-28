class AppException implements Exception{
  String title;
  String msg;

  AppException({required this.title,required this.msg});

  String toErrorMsg(){
    return "$title: $msg";
  }
}

class FetchDataException extends AppException{
  FetchDataException({required String errMsg}) : super(title: 'Network Error:',msg: errMsg );
}

class BadRequestException extends AppException{
  BadRequestException({required String errMsg}) : super(title: 'Invalid Request',msg: errMsg );
}

class UnAuthorisedException extends AppException{
  UnAuthorisedException({required String errMsg}) : super(title: 'Unauthorised',msg: errMsg );
}

class InvalidInputException extends AppException{
  InvalidInputException({required String errMsg}) : super(title: 'Invalid Input',msg: errMsg );
}