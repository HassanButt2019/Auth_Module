import 'package:async/async.dart';
import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/domain/token.dart';



abstract class IAuthApi{
  Future<Result<Token>> signin(Credentials credentials);
  Future<Result<Token>> signup(Credentials credentials);

}