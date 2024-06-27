import 'package:flutter/material.dart';
import 'package:lc/Utils/AppColors.dart';
import 'package:lc/Utils/TextStyles.dart';
import 'package:lc/Utils/Urls.dart';
import 'package:lc/Views/ChangePasswordView.dart';
import 'package:lc/Views/LandingView.dart';
import 'package:lc/Views/LoginView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends ChangeNotifier {
  String eMessage =
      "Check Internet connection\nSomething went wrong try again after some time !";

  bool loginLoading = false;

  Future<void> Login(context, {email, password}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    loginLoading = true;
    notifyListeners();
    var postJson = {"email": email, "password": password};
    final response = await ApiMethods.loginMethod(postJson: postJson);
    if (response != null) {
      final message = response["message"];
      if (response["status"] == true) {
        final userData = response["loginData"];
        String token = userData["token"];
        var roleId = userData["type"];
        var userId = userData["_id"];
        var type = userData["type"];
        sharedPreferences.setString("token", token.toString());
        sharedPreferences.setString("roleId", roleId.toString());
        sharedPreferences.setString("userId", userId.toString());
        sharedPreferences.setString("type", type.toString());
        ShowMessage(context, backgroundColor: savebtncolor, message: message);
        if (type.toString() != "3") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LandingView()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Scaffold(body: ChangePasswordView())),
                  (route) => false);
        }
      } else {
        ShowMessage(context,
            backgroundColor: onprimaryhrcolor, message: message);
      }
    } else {
      ShowMessage(context,
          backgroundColor: Colors.redAccent, message: eMessage);
    }
    loginLoading = false;
    notifyListeners();
  }

  Future<void> CheckAuthenticationStatus(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var type = sharedPreferences.getString("type");
    if (token == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginView()),
          (route) => false);
    } else {
      if (type.toString() != "3") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LandingView()),
                (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Scaffold(body: ChangePasswordView())),
                (route) => false);
      }
    }
  }

  Future<void> Logout(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginView()), (route) => false);
    notifyListeners();
  }

  bool forgotLoad = false;

  Future<void> ForgotPassword(context, {email}) async {
    forgotLoad = true;
    notifyListeners();
    var response = await ApiMethods.postMethod(
        endpoint: "users/forgotPassword", postJson: {"email": email});
    if (response != null) {
      if (response["status"].toString() == "true") {
        ShowMessage(context,
            message: response["message"].toString(),
            backgroundColor: savebtncolor);
      } else {
        ShowMessage(context,
            message: response["message"].toString(),
            backgroundColor: onprimaryhrcolor);
      }
      forgotLoad = false;
      notifyListeners();
    } else {
      forgotLoad = false;
      notifyListeners();
    }
    forgotLoad = false;
    notifyListeners();
  }

  var image;
  var fullname;
  var email;
  var phone;

  bool profileLoad = false;

  Future<void> GetProfileData({UserId}) async {
    profileLoad = true;
    notifyListeners();
    final response = await ApiMethods.postMethod(
        endpoint: "users/getAccountDetails", postJson: {"_id": UserId});
    if (response != null) {
      var data = response["data"][0];
      fullname = data["firstName"] + " " + data["lastName"];
      image = data["imageUrl"] ?? "";
      email = data["email"];
      phone = data["phone"];
    }
    profileLoad = false;
    notifyListeners();
  }

  bool updateLoad = false;

  Future<void> UpdatePassword(context, {oldPassword, newPassword}) async {
    updateLoad = true;
    notifyListeners();
    final response = await ApiMethods.putMethod(
        endpoint: "users/updatePassword",
        postJson: {"password": oldPassword, "newPassword": newPassword});
    if (response != null) {
      ShowMessage(context,
          message: response["message"],
          backgroundColor:
              response["status"] == true ? savebtncolor : onprimaryhrcolor);
    }
    updateLoad = false;
    notifyListeners();
  }

}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> ShowMessage(context,
    {backgroundColor, message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      content: Text(
        message,
        style: TxtStls.wstl14,
      ),
    ),
  );
}
