import 'package:flutter/material.dart';
import 'package:latihan_1/pages/album.dart';
import 'package:latihan_1/pages/comment.dart';
import 'package:latihan_1/pages/stack.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Login'),
            Text(
              'Latihan Apps',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(
          12.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommentPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 60.0,
                        horizontal: 60.0,
                      ),
                      child: Text('COMMENT'),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AlbumPage(),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 60.0,
                        horizontal: 60.0,
                      ),
                      child: Text('ALBUM'),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                padding: EdgeInsets.all(
                  60.0,
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StackPage(),
                    ),
                  ),
                  child: SizedBox(
                    width: 120.0,
                    height: 120.0,
                    child: Center(
                      child: Text('GREEN'),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                padding: EdgeInsets.only(
                  left: 60.0,
                  right: 60.0,
                  top: 60.0,
                  bottom: 60.0,
                ),
                child: Text('BLUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
