import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text('STACK PAGE'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 320.0,
            width: 320.0,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text('STACK 1'),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Text('STACK 2'),
                  ),
                ),
                Positioned(
                  bottom: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Text('STACK 3'),
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
