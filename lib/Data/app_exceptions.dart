class AppExceptions implements Exception {
  
  final _message;
  final _prefix;

  AppExceptions([this._message , this._prefix]);

  String myException(){
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message , 'Error During Communications');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message , 'Invalid Request');
}

class UnAuthorisedException extends AppExceptions{
  UnAuthorisedException([String? message]) : super(message , 'Unauthorised Access');
  
}

class InvalidInput extends AppExceptions {
  InvalidInput([String? message]) : super(message, 'Invalid Input');
}