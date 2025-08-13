import 'dart:convert';

import 'package:flutter_module/app/data/Apis/api_urls.dart';
import 'package:flutter_module/app/data/Apis/http_methods.dart';
import 'package:flutter_module/app/modules/login/repo/login_model.dart';
import 'package:http/http.dart' as http;

class SignInMethod {
  static Future<LoginModel?> signInApi({Map<String, dynamic>? bodyParams}) async {
    http.Response? response = await MyHttp.postMethod(url: ApiUrlsConstants.endPointOfLogin, bodyParams: bodyParams);
    if (response != null) {
      return LoginModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
