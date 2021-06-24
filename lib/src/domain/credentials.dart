import 'package:flutter/foundation.dart';

class Credentials{
  final String? name;
  final String? email;
  final String? password;
  final AuthType? type;

  Credentials(
{
  @required this.type,
  this.name,
  @required this.email,
 this.password 
}
  );
}

enum AuthType {email , google}