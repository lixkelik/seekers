import 'package:flutter/material.dart';
import 'package:seekers/factory/user_factory.dart';
import 'package:seekers/view/peer/article_peer_page.dart';
import 'package:seekers/view/peer/game_peer_page.dart';
import 'package:seekers/view/repository/firestore_repository.dart';
import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/view/widget/skeleton.dart';

class HomePeerPage extends StatefulWidget {
  const HomePeerPage({super.key});

  @override
  State<HomePeerPage> createState() => _HomePeerPageState();
}

class _HomePeerPageState extends State<HomePeerPage> {
  String uid = '';
  UserSeekers? user;

  @override
  void initState() {
    _getUid();
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              width: 100,
            ),

            // profile picture and name
            Container(
              width: 93,
              height: 93,
              margin: const EdgeInsets.only(right: 12),
              child: const Image(image: AssetImage(profilePic)),
            ),
            const SizedBox(
              width: 5,
            ),
            (user != null)
                ? Text(
                    "Howdy, " + user!.name + "!",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : skeletonBox(140, 30),
            // xp bar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Badges', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('XP', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.7, // Replace with the actual progress value
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  SizedBox(height: 20),
                  Text('Total Games', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('50', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),

            // game button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GamePeer()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Let's Play a Game!", style: TextStyle(fontSize: 16)),
                    Image.asset(profilePic, width: 50),
                  ],
                ),
              ),
            ),

            // article button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArticlePeer()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Today's fun article!",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 10),
                    Text('What is an Airport',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Read More', style: TextStyle(fontSize: 16)),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ],
                ),
              ),
            )

            // end page
          ],
        ),
      )),
    );
    // return  Center(
    //   child: Text(uid),
    // );
  }

  Future<void> _getUid() async {
    String value = await getUid();
    setState(() {
      uid = value;
    });
  }

  Future<void> _getUserData() async {
    UserSeekers user = await getUserData();
    setState(() {
      this.user = user;
    });
  }
}
