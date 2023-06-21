import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latihan_1/model/post.model.dart';
import 'package:latihan_1/model/user.model.dart';
import 'package:latihan_1/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPage extends StatefulWidget {
  final UserModel paramUser;

  const PostPage({super.key, required this.paramUser});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<List<PostModel>> futurePosts;
  late Future<String> futureLang;
  late List<PostModel> listPost;
  late List<PostModel> tempListPost;
  String? pLocale = '';

  @override
  void initState() {
    super.initState();
    _pullRefresh();
  }

  Future<void> _pullRefresh() async {
    futurePosts = APIService().fetchPost();
  }

  Future<String?> _getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale');
  }

  void selectedPost(String textPost) {
    Navigator.pop(context, textPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: Column(
          children: [
            FutureBuilder(
              future: _getLang(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String? lang = snapshot.data;
                  return Localizations.override(
                    context: context,
                    locale: Locale(lang!),
                    // Using a Builder to get the correct BuildContext.
                    // Alternatively, you can create a new widget and Localizations.override
                    // will pass the updated BuildContext to the new widget.
                    child: Builder(
                      builder: (context) {
                        // A toy example for an internationalized Material widget.
                        return CalendarDatePicker(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          onDateChanged: (value) {},
                        );
                      },
                    ),
                  );
                }
                return Text('Loading');
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: futurePosts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    listPost = snapshot.data!;
                    tempListPost = listPost
                        .where((i) => i.userId == widget.paramUser.id)
                        .toList();

                    return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                        itemCount: tempListPost.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => selectedPost(tempListPost[index].body),
                            child: Card(
                              child: Text(tempListPost[index].body),
                              margin: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 4.0,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return SpinKitCircle(
                    color: Theme.of(context).primaryColor,
                    duration: Duration(
                      seconds: 3,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
