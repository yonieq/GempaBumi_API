import 'package:bmkg_rest/userDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ControllerLogin with ChangeNotifier {
  var googleSignInNow = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  UserDetailsModel? userDetailsModel;

  allowUserToLogin() async {
    this.googleSignInAccount = await googleSignInNow.signIn();

    this.userDetailsModel = new UserDetailsModel(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }

  allowUserToLogout() async {
    this.googleSignInAccount = await googleSignInNow.signOut();

    userDetailsModel = null;

    notifyListeners();
  }
}
