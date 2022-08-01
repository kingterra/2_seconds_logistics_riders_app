import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.black,
                        iconSize: 35.0,
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        }
                    ),
                    Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 30,
                        )
                    )
                  ],
                ),
              ],
            ),
        ),
      )
    );
  }
}
