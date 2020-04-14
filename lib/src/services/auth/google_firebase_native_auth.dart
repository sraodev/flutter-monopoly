//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:meta/meta.dart';
//import 'auth.dart';
//
//class GoogleFireBaseNativeAuthentication implements IBaseAuth {
//  final FirebaseAuth fireBaseAuthHandle;
//  final GoogleSignIn googleSignInHandle;
//  final Future<SharedPreferences> sharedPreferenceHandle;
//  final String hostedDomain;
//
//  GoogleFireBaseNativeAuthentication(
//      {@required this.fireBaseAuthHandle,
//        @required this.googleSignInHandle,
//        @required this.sharedPreferenceHandle,
//        @required this.hostedDomain});
//
//  @override
//  Future<String> createUser(String email, String password) {
//    return null;
//  }
//
//  @override
//  Future<AuthenticatedUser> getCurrentUser(bool refreshToken) async {
//    AuthenticatedUser authenticatedUser;
//
//    FirebaseUser currentUser = await fireBaseAuthHandle.currentUser();
//
//    if (null == currentUser) {
//      return null;
//    }
//
//    IdTokenResult idTokenResult =
//    await currentUser.getIdToken(refresh: refreshToken);
//
//    print("Valid user and signed in.");
//
//    authenticatedUser = AuthenticatedUser(
//        providerId: currentUser.providerId,
//        uid: currentUser.uid,
//        displayName: currentUser.displayName,
//        photoUrl: currentUser.photoUrl,
//        emailId: currentUser.email,
//        idToken: idTokenResult.token);
//
//    return authenticatedUser;
//  }
//
//  bool _isValidUser(GoogleSignInAccount googleSignInAccount) {
//    //todo:remove this
//    if (googleSignInAccount.email.isEmpty ||
//        !googleSignInAccount.email.contains(hostedDomain)) {
//      return false;
//    } else {
//      return true;
//    }
//  }
//
//  Future<GoogleSignInAccount> getGoogleSignedInAccount() async {
//    GoogleSignInAccount googleSignInAccount = await googleSignInHandle.signIn();
//
//    if (null == googleSignInAccount) {
//      return null;
//    }
//    return googleSignInAccount;
//  }
//
//  @override
//  Future<AuthenticatedUser> autoSignIn() async {
//    AuthenticatedUser authenticatedUser;
//    SharedPreferences preferences = await sharedPreferenceHandle;
//
//    FirebaseUser currentUser = await fireBaseAuthHandle.currentUser();
//
//    if (null == currentUser) {
//      _purgeAuthenticatedUserDetails();
//      return null;
//    }
//
//    String emailId = preferences.getString(AuthConstants.AUTH_EMAIL_ID) ?? '';
//    String idToken = preferences.getString(AuthConstants.AUTH_TOKEN) ?? '';
//    String expiryTimeString =
//        preferences.getString(AuthConstants.AUTH_EXPIRY_DATETIME) ?? '';
//
//    if (emailId.isEmpty || idToken.isEmpty || expiryTimeString.isEmpty) {
//      await _purgeAuthenticatedUserDetails();
//      return null;
//    }
//
//    if (0 != currentUser.email.toLowerCase().compareTo(emailId.toLowerCase())) {
//      await _purgeAuthenticatedUserDetails();
//      return null;
//    }
//
//    DateTime expiryTime = DateTime.parse(expiryTimeString);
//    Duration timeDifference = expiryTime.difference(DateTime.now().toUtc());
//
//    if (timeDifference.inDays > AuthConstants.AUTH_NUMBER_OF_DAYS_EXPIRY) {
//      await _purgeAuthenticatedUserDetails();
//      await fireBaseAuthHandle.signOut();
//      return null;
//    }
//
//    IdTokenResult idTokenResult = await currentUser.getIdToken(refresh: true);
//
//    print("Valid user and signed in.");
//
//    authenticatedUser = AuthenticatedUser(
//        providerId: currentUser.providerId,
//        uid: currentUser.uid,
//        displayName: currentUser.displayName,
//        photoUrl: currentUser.photoUrl,
//        emailId: currentUser.email,
//        idToken: idTokenResult.token);
//
//    return authenticatedUser;
//  }
//
//  @override
//  Future<bool> autoSignOut() async {
//    FirebaseUser currentUser = await fireBaseAuthHandle.currentUser();
//    SharedPreferences preferences = await sharedPreferenceHandle;
//
//    if (null == currentUser) {
//      await _purgeAuthenticatedUserDetails();
//      return true;
//    }
//
//    String currentUserEmail = currentUser.email;
//
//    String expiryDateTimeString =
//    preferences.getString(AuthConstants.AUTH_EXPIRY_DATETIME);
//
//    DateTime expiryDateTime = DateTime.parse(expiryDateTimeString);
//    Duration timeDifference = expiryDateTime.difference(DateTime.now().toUtc());
//
//    if (timeDifference.inDays > AuthConstants.AUTH_NUMBER_OF_DAYS_EXPIRY) {
//      await fireBaseAuthHandle.signOut();
//
//      GoogleSignInAccount currentAccount = googleSignInHandle.currentUser;
//
//      if (null != currentAccount) {
//        if (0 ==
//            currentAccount.email
//                .toLowerCase()
//                .compareTo(currentUserEmail.toLowerCase())) {
//          String emailId = currentAccount.email;
//
//          await googleSignInHandle.isSignedIn().then((isSignedIn) async {
//            await googleSignInHandle.signOut().then((googleAccount) {
//              if (null == googleAccount) {
//                print(emailId + " signed out!!");
//              }
//            }).catchError(() {
//              //do nothing
//            });
//          }).catchError(() {
//            //do nothing
//          });
//        }
//      }
//
//      return true;
//    }
//    return false;
//  }
//
//  @override
//  Future<AuthenticatedUser> signIn() async {
//    AuthenticatedUser authenticatedUser;
//    GoogleSignInAccount googleSignInAccount = await getGoogleSignedInAccount();
//
//    if (null == googleSignInAccount || !_isValidUser(googleSignInAccount)) {
//      return null;
//    }
//
//    authenticatedUser = await autoSignIn();
//
//    if (null != authenticatedUser) {
//      return authenticatedUser;
//    }
//
//    GoogleSignInAuthentication authentication =
//    await googleSignInAccount.authentication;
//
//    if (null == authentication) {
//      return null;
//    }
//
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//      accessToken: authentication.accessToken,
//      idToken: authentication.idToken,
//    );
//
//    if (null == credential) {
//      return null;
//    }
//
//    AuthResult authResult =
//    await fireBaseAuthHandle.signInWithCredential(credential);
//    if (null == authResult) {
//      return null;
//    }
//
//    FirebaseUser fireBaseUser = authResult.user;
//
//    if (null != fireBaseUser) {
//      authenticatedUser =
//      await _overWriteAuthenticatedUser(fireBaseUser, false);
//    }
//
//    return authenticatedUser;
//  }
//
//  Future<Null> _purgeAuthenticatedUserDetails() async {
//    bool isOverridden = false;
//    SharedPreferences preferences = await sharedPreferenceHandle;
//
//    isOverridden = await preferences.setString(AuthConstants.AUTH_EMAIL_ID, "");
//    if (!isOverridden) {
//      print("Email override failed.");
//    }
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_PROVIDER_ID, "");
//    if (!isOverridden) {
//      print("providerId override failed.");
//    }
//
//    isOverridden = await preferences.setString(AuthConstants.AUTH_USER_ID, "");
//    if (!isOverridden) {
//      print("uid override failed.");
//    }
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_DISPLAY_NAME, "");
//    if (!isOverridden) {
//      print("displayName override failed.");
//    }
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_PHOTO_URL, "");
//    if (!isOverridden) {
//      print("photoUrl override failed.");
//    }
//
//    isOverridden = await preferences.setString(AuthConstants.AUTH_TOKEN, "");
//    if (!isOverridden) {
//      print("idToken override failed.");
//    }
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_EXPIRY_DATETIME, "");
//    if (!isOverridden) {
//      print("expiryTime override failed.");
//    }
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_AUTH_DATETIME, "");
//    if (!isOverridden) {
//      print("timeOfAuthentication override failed.");
//    }
//
//    return;
//  }
//
//  Future<AuthenticatedUser> _overWriteAuthenticatedUser(
//      FirebaseUser user, bool forceRefresh) async {
//    bool isOverridden = false;
//    AuthenticatedUser authenticatedUser;
//    SharedPreferences preferences = await sharedPreferenceHandle;
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_EMAIL_ID, user.email);
//    if (!isOverridden) {
//      print("Email override failed.");
//    }
//
//    isOverridden = await preferences.setString(
//        AuthConstants.AUTH_PROVIDER_ID, user.providerId);
//    if (!isOverridden) {
//      print("providerId override failed.");
//    }
//
//    isOverridden =
//    await preferences.setString(AuthConstants.AUTH_USER_ID, user.uid);
//    if (!isOverridden) {
//      print("uid override failed.");
//    }
//
//    isOverridden = await preferences.setString(
//        AuthConstants.AUTH_DISPLAY_NAME, user.displayName);
//    if (!isOverridden) {
//      print("displayName override failed.");
//    }
//
//    isOverridden = await preferences.setString(
//        AuthConstants.AUTH_PHOTO_URL, user.photoUrl);
//    if (!isOverridden) {
//      print("photoUrl override failed.");
//    }
//
//    IdTokenResult idTokenResult =
//    await user.getIdToken(refresh: forceRefresh).catchError((Object error) {
//      return null;
//    });
//
//    isOverridden = await preferences.setString(
//        AuthConstants.AUTH_TOKEN, idTokenResult.token);
//    if (!isOverridden) {
//      print("idToken override failed.");
//    }
//
//    DateTime now = DateTime.now();
//    DateTime expiryTime = DateTime.now()
//        .add(Duration(days: AuthConstants.AUTH_NUMBER_OF_DAYS_EXPIRY));
//
//    isOverridden = await preferences.setString(
//        AuthConstants.AUTH_EXPIRY_DATETIME,
//        expiryTime.toUtc().toIso8601String());
//    if (!isOverridden) {
//      print("expiryTime override failed.");
//    }
//
//    isOverridden = await preferences.setString(
//        AuthConstants.AUTH_AUTH_DATETIME, now.toUtc().toIso8601String());
//    if (!isOverridden) {
//      print("timeOfAuthentication override failed.");
//    }
//
//    authenticatedUser = AuthenticatedUser(
//        providerId: user.providerId,
//        uid: user.uid,
//        displayName: user.displayName,
//        photoUrl: user.photoUrl,
//        emailId: user.email,
//        idToken: idTokenResult.token);
//
//    return authenticatedUser;
//  }
//
//  @override
//  Future<void> signOut() async {
//    try {
//      await _purgeAuthenticatedUserDetails();
//
//      FirebaseUser fireBaseUser = await fireBaseAuthHandle.currentUser();
//
//      if (null != fireBaseUser) {
//        await fireBaseAuthHandle.signOut();
//      }
//
//      await googleSignInHandle.signOut();
//
//      return null;
//    } on Exception catch (e) {
//      print(e);
//    }
//
//    return null;
//  }
//}
//
//class AuthConstants {
//  static const String AUTH_EMAIL_ID = "emailId";
//  static const String AUTH_PROVIDER_ID = "providerId";
//  static const String AUTH_USER_ID = "uid";
//  static const String AUTH_DISPLAY_NAME = "displayName";
//  static const String AUTH_PHOTO_URL = "photoUrl";
//  static const String AUTH_TOKEN = "idToken";
//  static const String AUTH_EXPIRY_DATETIME = "expiryTime";
//  static const String AUTH_AUTH_DATETIME = "timeOfAuthentication";
//  static const int AUTH_NUMBER_OF_DAYS_EXPIRY = 3;
//}
