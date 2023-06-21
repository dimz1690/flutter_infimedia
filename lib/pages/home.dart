import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latihan_1/common.dart';
import 'package:latihan_1/model/500.model.dart';
import 'package:latihan_1/model/user.model.dart';
import 'package:latihan_1/pages/post.dart';
import 'package:latihan_1/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  late Future<List<UserModel>> futureUsers;
  late List<UserModel> listUsers;
  String selectedPost = '';
  int idx = 0;
  late SharedPreferences prefs;

  TextStyle _myTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    getFCMToken();
  }

  getFCMToken() async {
    // String? token = await messaging.getToken();
    // print(token);
  }

  Future<bool> goToPost(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = '';
    lang = index / 2 > 0 ? 'es' : 'id';
    // // pub locale
    await prefs.setString('locale', lang);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
      ),
      body: Column(
        children: [
          Text('Ini file ENV ${dotenv.env['PASS']}'),
          Text(AppLocalizations.of(context)!.helloWorld),
          Text(
            'User Data',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          FutureBuilder(
            future: APIService().fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!;
                if (data is Error500Model) {
                  return Text('0x00896');
                }

                listUsers = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: listUsers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await goToPost(index);
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PostPage(paramUser: listUsers[index]),
                            ),
                          );

                          if (result is String) {
                            setState(() {
                              selectedPost = result;
                            });
                          }
                        },
                        child: Card(
                          color: Color(0xFFb74093),
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.all(
                              12.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listUsers[index].name,
                                  style: _myTextStyle,
                                ),
                                Text(
                                  listUsers[index].company.name,
                                  style: _myTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return SpinKitCircle(
                color: Colors.blue,
                duration: Duration(
                  seconds: 3,
                ),
              );
            },
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  'Post Data Selected',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  selectedPost,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  selectedPost,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
