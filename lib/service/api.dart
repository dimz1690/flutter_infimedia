import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:latihan_1/model/500.model.dart';
import 'package:latihan_1/model/album.model.dart';
import 'package:latihan_1/model/comment.model.dart';
import 'package:latihan_1/model/post.model.dart';
import 'package:latihan_1/model/user.model.dart';
import 'package:retry/retry.dart';

class APIService {
  final String _url = 'https://jsonplaceholder.typicode.com';
  final retryOpt = RetryOptions(maxAttempts: 8);
  final timeOut = 60;

  getUrl() {
    return _url;
  }

  setUrl() {}

  // Future<List<UserModel>> fetchUser() async {
  //   final response = await http.get(Uri.parse('$_url/users'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.

  //     var responseJson = json.decode(response.body);
  //     return (responseJson as List).map((p) => UserModel.fromJson(p)).toList();
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<List<CommentModel>> fetchComment() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseJson = json.decode(response.body);
      return (responseJson as List)
          .map((p) => CommentModel.fromJson(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<PostModel>> fetchPost() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => PostModel.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<AlbumModel> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return AlbumModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<dynamic> fetchUser() async {
    try {
      var response = await retryOpt.retry(
        () => http
            .get(
              Uri.parse('$_url/users'),
            )
            .timeout(
              Duration(seconds: timeOut),
            ),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return (responseJson as List)
            .map((p) => UserModel.fromJson(p))
            .toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } catch (err) {
      // throw Exception('Failed to load album');
      return Error500Model(code: 500, message: 'Unknown Error');
    } finally {
      HttpClient().close();
    }
  }
}
