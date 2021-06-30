


import 'dart:convert';

import 'package:auth/src/domain/token.dart';
import 'package:auth/src/domain/credentials.dart';
import 'package:async/src/result/result.dart';
import 'package:auth/src/infra/api/mapper.dart';
import 'package:http/http.dart'as http;
import 'package:auth/src/infra/api/auth_api_contract.dart';

class AuthApi implements IAuthApi{
  final http.Client _client;
  String baseUrl;
  AuthApi(this._client , this.baseUrl);

//  Future<Result<String>> _postCredentials(String endpoint , Credentials credentials) async {
    
//  }



 
  @override
  Future<Result<Token>> signin(Credentials credentials) async{
      var endpoint = baseUrl + '/auth/signin';
     var response = await _client.post(Uri.parse(endpoint) , body:Mapper.toJson(credentials)); 
    
    if(response.statusCode != 200) return Result.error('Server Error');
    
    
    var json = jsonDecode(response.body);
    return json['auth_token'] != null 
    ? Result.value(json['auth_token'])
    :Result.error(json['message']);
 
    }
  
    @override
    Future<Result<Token>> signup(Credentials credentials) async{

    var endpoint = baseUrl + '/auth/signup';
    var response = await _client.post(Uri.parse(endpoint) , body:Mapper.toJson(credentials));     
    if(response.statusCode != 200) return Result.error('Server Error');
    var json = jsonDecode(response.body);
    return json['auth_token'] != null 
    ? Result.value(json['auth_token'])
    :Result.error(json['message']);
 
  }

}