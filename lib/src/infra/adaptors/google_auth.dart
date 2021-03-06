


import 'package:async/src/result/result.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credentials.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth implements IAuthService{
final IAuthApi _iAuthApi;
GoogleSignIn? _googleSignIn;
GoogleSignInAccount? _currentUser;

GoogleAuth(this._iAuthApi ,
[GoogleSignIn? googleSignIn]):
this._googleSignIn = googleSignIn 
??GoogleSignIn(scopes: ['email' , 'profile']);

_handleGoogleSignIn() async {
  try{
    _currentUser = await _googleSignIn!.signIn();

  }catch(err){
    return ;

  }
}


  @override
  Future<Result<Token>> signin() async{

    await _handleGoogleSignIn();
    if(_currentUser == null) return Result.error("Fails To signin with Google");

    Credentials credential = Credentials(type: AuthType.google, email: _currentUser!.email ,name: _currentUser!.displayName);

    var result = await _iAuthApi.signin(credential);

    if(result.isError) {
      return Result.error(result);
    }

    return Result.value(Token(result.asValue!.value));


  }

  @override
  Future<void> signout() async{
     _googleSignIn!.disconnect();
  }

}