import 'package:flutter/material.dart';
import 'package:seekers/constant/firebase_constant.dart';
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
        child: Container(
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
                      Text('Badges gained',
                          style: TextStyle(
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              const Image(
                                  image: AssetImage(badge1),
                                  fit: BoxFit.contain),
                              SizedBox(width: 10),
                              const Image(
                                  image: AssetImage(badge2),
                                  fit: BoxFit.contain),
                              SizedBox(width: 10),
                              const Image(
                                  image: AssetImage(badge3),
                                  fit: BoxFit.contain),
                              SizedBox(width: 10),
                              const Image(
                                  image: AssetImage(badge4),
                                  fit: BoxFit.contain)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      StreamBuilder<QuerySnapshot>(
                          stream: db.collection('games').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int count = snapshot.data!.docs.length;
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Text('Total Games',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10),
                                          Text('$count',
                                              style: TextStyle(fontSize: 24)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Text('XP',
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(height: 10),
                                          Text('${count * 20}',
                                              style: TextStyle(fontSize: 24)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
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
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Text("Let's Play a Game!",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Image.asset(clickMe, width: 100),
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
                                style: TextStyle(fontSize: 16, color: white),
                              ),
                              SizedBox(height: 10),
                              Image.asset(articleBg, width: double.infinity),
                              SizedBox(height: 10),
                              Text('What is an Airport',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: white)),
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
                                      style: TextStyle(
                                          fontSize: 16, color: white)),
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
