


import 'dart:convert';

import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart'as http;
import 'package:async/async.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  MockClient? client;
  AuthApi? sut;


  setUp((){
client =MockClient();
sut = AuthApi( client! , 'http.baseUrl' );
  });


  group('signin',(){
    var credentials = Credentials(type: AuthType.email, email: 'email@gmail' , password: 'pass');

    test('should return error when status code is not 200' , () async{
      when(client!.post(Uri.parse('any') , body: anyNamed('body'))).thenAnswer((_) async => http.Response('{}' , 404));

      var result = await sut!.signin(credentials);

      expect(result, isA<ErrorResult>());
    });


    test('should return error when status code is 200 but malformed json' , () async{
      when(client!.post(Uri.parse('any'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('{}' , 200));

      var result = await sut!.signin(credentials);

      expect(result, isA<ErrorResult>());

    });

    
    test('should return token string when successful' , () async{
      var tokenstr = 'abcisc...wds';
      when(client!.post(Uri.parse('any'), body: anyNamed('body'))).thenAnswer((_) async => http.Response(jsonEncode(tokenstr) , 200));

      var result = await sut!.signin(credentials);

      expect(result.asValue!.value, tokenstr);

    });


  });
  
}