import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../utils/common_widgets.dart';
import '../../utils/const_preferences.dart';

class MyHttp {
  static Future<http.Response?> getMethod(
      {required String url, void Function(int)? checkResponse}) async {
    String? authToken = await ConstPreferences.getToken();
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${authToken ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) log("URL:: $url");
    if (kDebugMode) log("TOKEN:: $authorization");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.get(
          Uri.parse(url),
          headers: authorization,
        );
        if (kDebugMode) log("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForGetMethod(response: response)) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            log(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) log("EXCEPTION:: Server Down $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> getMethodParams(
      {required Map<String, dynamic> queryParameters,
      required String baseUri,
      required String endPointUri,
      void Function(int)? checkResponse}) async {
    String? authToken = await ConstPreferences.getToken();
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${authToken ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) log("endPointUri:: $endPointUri");
    if (kDebugMode) log("BASEURL:: $baseUri");
    if (kDebugMode) log("TOKEN:: $authorization");
    if (kDebugMode) log("queryParameters:: $queryParameters");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        Uri uri = Uri.http(baseUri, endPointUri, queryParameters);
        if (kDebugMode) log("URI:: $uri");
        http.Response? response = await http.get(uri, headers: authorization);
        if (kDebugMode) log("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForGetMethod(
          response: response,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            log(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) log("EXCEPTION:: Server Down");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> postMethod(
      {required String url,
      Map<String, dynamic>? bodyParams,
      bool wantSnackBar = true,
      void Function(int)? checkResponse}) async {
    String? authToken = await ConstPreferences.getToken();
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${authToken ?? ''}",
      'Accept': 'application/json',
      'Accept8': '*/*',
      'Content-Type': 'application/json',
      'Cookie': '_mkra_ctxt=6b2b64a94982acb8365dd42b4e674d23--200',
    };
    if (kDebugMode) log("URL:: $url");
    if (kDebugMode) log("authorization:: $authorization");
    if (kDebugMode) log("bodyParams:: ${jsonEncode(bodyParams ?? {})}");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.post(
          Uri.parse(url),
          body: jsonEncode(bodyParams ?? {}),
          headers: authorization,
        );
        if (kDebugMode) log("CALLING:: ${response.statusCode}");
        if (kDebugMode) log("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForPostMethod(
          wantSnackBar: wantSnackBar,
          response: response,
        )) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            log(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) log("EXCEPTION:: Server Down $e");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> deleteMethod(
      {required String url,
      required Map<String, dynamic> bodyParams,
      void Function(int)? checkResponse}) async {
    String? authToken = await ConstPreferences.getToken();
    Map<String, String> authorization = {};
    authorization = {
      "Authorization": "Bearer ${authToken ?? ''}",
      'Accept': 'application/json'
    };
    if (kDebugMode) log("URL:: $url");
    // if (kDebugMode) log("TOKEN:: $authorization");
    if (kDebugMode) log("bodyParams:: $bodyParams}");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response? response = await http.delete(Uri.parse(url),
            body: bodyParams, headers: authorization);
        if (kDebugMode) log("CALLING:: ${response.body}");
        if (await CommonWidgets.responseCheckForPostMethod(
            response: response)) {
          checkResponse?.call(response.statusCode);
          return response;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            log(
                "ERROR::statusCode=${response.statusCode}: :response=${response.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) log("EXCEPTION:: Server Down");
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<http.Response?> multipart(
      {String multipartRequestType = 'POST', // POST or GET
      required String url,
      //Single Image Upload
      File? image,
      String? imageKey,
      Map<String, dynamic>? bodyParams,
      //Upload with Multiple key
      Map<String, File>? imageMap,
      //Upload with Single key
      List<File>? images,
      void Function(int)? checkResponse}) async {
    String? authToken = await ConstPreferences.getToken();
    if (kDebugMode) log("bodyParams:: ${bodyParams ?? {}}");
    if (kDebugMode) log("URL:: $url");
    if (kDebugMode) log("TOKEN:: ${authToken ?? ''}");
    if (await CommonWidgets.internetConnectionCheckerMethod()) {
      try {
        http.Response res;
        var request =
            http.MultipartRequest(multipartRequestType, Uri.parse(url));
        request.headers.addAll({'Content-Type': 'multipart/form-data'});
        request.headers.addAll({'Accept': 'application/json'});
        request.headers['Authorization'] = "Bearer ${authToken ?? ''}";
        if (kDebugMode) log("CALLING:: $url");
        //Single Image Upload
        if (image != null && imageKey != null) {
          if (kDebugMode) log("imageKey:: $imageKey   image::$image");
          request.files.add(getUserProfileImageFile(
              image: image, userProfileImageKey: imageKey));
        }
        //Upload with Multiple key
        if (imageMap != null) {
          if (kDebugMode) log("imageMap:: $imageMap");
          imageMap.forEach((key, value) {
            request.files.add(getUserProfileImageFile(
                image: value, userProfileImageKey: key));
          });
        }
        //Upload with Single key
        if (images != null && imageKey != null) {
          for (int i = 0; i < images.length; i++) {
            request.files.add(getUserProfileImageFile(
                image: images[i], userProfileImageKey: imageKey));
            var stream = http.ByteStream(images[i].openRead());
            var length = await images[i].length();
            var multipartFile = http.MultipartFile(imageKey, stream, length,
                filename: images[i].path);
            request.files.add(multipartFile);
          }
        }

        if (bodyParams != null) {
          if (kDebugMode) log("bodyParams:: $bodyParams");
          bodyParams.forEach((key, value) {
            request.fields[key] = value;
          });
        }
        var response = await request.send();
        res = await http.Response.fromStream(response);
        if (kDebugMode) log("CALLING:: ${res.body}");
        if (await CommonWidgets.responseCheckForPostMethod(response: res)) {
          checkResponse?.call(response.statusCode);
          return res;
        } else {
          checkResponse?.call(response.statusCode);
          if (kDebugMode) {
            log("ERROR::statusCode=${res.statusCode}: :response=${res.body}");
          }
          return null;
        }
      } catch (e) {
        if (kDebugMode) log("EXCEPTION:: Server Down");
        return null;
      }
    } else {
      return null;
    }
  }

  static http.MultipartFile getUserProfileImageFile(
      {File? image, required String userProfileImageKey}) {
    return http.MultipartFile.fromBytes(
      userProfileImageKey,
      image!.readAsBytesSync(),
      filename: image.uri.pathSegments.last,
    );
  }
}
