import 'package:flutter/material.dart';
import 'package:seekers/constant/constant_builder.dart';

class ArticlePeer extends StatelessWidget {
  const ArticlePeer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Page Title'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // gambar artikel
          Image.asset(profilePic),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Lalallaala panjang banget',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          // reward biar lucu
          Image.asset(profilePic),
        ]),
      ),
    );
    // return const Center(
    //   child: Text('article peer page'),
    // );
  }
}
