import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latihan_1/model/comment.model.dart';

import '../service/api.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late Future<List<CommentModel>> futureComment;
  late List<CommentModel> listComment;

  @override
  void initState() {
    super.initState();
    futureComment = APIService().fetchComment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CommentModel>>(
        future: Future.delayed(
          Duration(seconds: 5),
          () {
            return futureComment;
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            listComment = snapshot.data!;
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: listComment.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '$index ${listComment[index].name}, ini angka ${listComment[index].angka}'),
                  subtitle: Text('$index ${listComment[index].body}'),
                  trailing: InkWell(
                    onTap: () {
                      setState(() {
                        listComment[index].angka++;
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.red,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(color: Colors.red, size: 50.0),
              SizedBox(
                height: 12,
              ),
              Text('Loading ...'),
            ],
          );
        },
      ),
    );
  }
}
