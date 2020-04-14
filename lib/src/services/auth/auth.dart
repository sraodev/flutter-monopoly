import 'package:meta/meta.dart';

abstract class IBaseAuth {
  Future<AuthenticatedUser> getCurrentUser(bool refreshToken);

  Future<AuthenticatedUser> signIn();

  Future<AuthenticatedUser> autoSignIn();

  Future<bool> autoSignOut();

  Future<String> createUser(String email, String password);

  Future<void> signOut();
}

class AuthenticatedUser {
  AuthenticatedUser(
      {@required this.providerId,
      @required this.uid,
      @required this.displayName,
      @required this.photoUrl,
      @required this.emailId,
      @required this.idToken});

  String providerId;
  String uid;
  String displayName;
  String photoUrl;
  String emailId;
  String idToken;
}
