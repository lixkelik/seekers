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
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            // profile picture and name
            Container(
              width: 93,
              height: 93,
              margin: const EdgeInsets.only(right: 12),
              child: const Image(image: AssetImage(profilePic)),
            ),
            SizedBox(
              height: 20,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: appOrange,
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
            ),
            SizedBox(height: 20),
            // game button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 40), // Set the left and right padding
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GamePeer()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: green,
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
                      Text("Let's Play a Game!",
                          style: TextStyle(fontSize: 16)),
                      Image.asset(clickMe, width: 50),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // article button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArticlePeer()),
                  );
                },
                // tampilannya
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: appYellow,
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
                  // tulisan artikel dll
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: appYellow),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's fun article!",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Image.asset(articleBg, width: double.infinity),
                            SizedBox(height: 10),
                            Text('What is an Airport',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: appOrange),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: <Widget>[
                                Text('Read More',
                                    style: TextStyle(fontSize: 16)),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // end page
            SizedBox(height: 50)
          ],
        ),
      ),
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
