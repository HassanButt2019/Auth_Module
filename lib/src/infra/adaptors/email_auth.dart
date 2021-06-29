

import 'dart:html';
import 'package:async/async.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/domain/signup_service_contract.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter/cupertino.dart';

class EmailAuth implements IAuthService , ISignUpService{
  final IAuthApi _iAuthApi;

  Credentials? _credentials;

  EmailAuth(this._iAuthApi);

  void credential({
    @required String? email , @required String? password,
  }){
    _credentials = Credentials(type:AuthType.email , email:email , password:password);
  }
 

  @override
  Future<Result<Token>> signin() async{
    assert(_credentials != null);
    var result = await _iAuthApi.signin(_credentials!);
    if(result.isError) return result.asError!;
    return Result.value(Token(result.asValue!.value));



  }

  // @override
  // Future<void> signout() {



  // }

  @override
  Future<Result<Token>> signup(String name, String email, String password) async{
    Credentials credential = Credentials(type: AuthType.email, email: email , password: password , name: name);
    var result = await _iAuthApi.signin(credential);
    if(result.isError) return result.asError!;
    return Result.value(Token(result.asValue!.value));

  
  }

  @override
  Future<void> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

}