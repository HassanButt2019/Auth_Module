

import 'package:auth/src/domain/credentials.dart';

class Mapper{
  static Map<String , dynamic> toJson(Credentials credentials) =>{
    "type": credentials.type,
    "name": credentials.name,
    "email": credentials.email,
    "password": credentials.password,



  };
}