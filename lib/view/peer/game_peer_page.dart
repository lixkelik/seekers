import 'package:flutter/material.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/service/official_game_service.dart';

class GamePeer extends StatefulWidget {
  const GamePeer({super.key});
  @override
  State<GamePeer> createState() => _GamePeerState();
}

class _GamePeerState extends State<GamePeer> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    _addOfficialGame();
    super.initState();
  }

  void _addOfficialGame() async {
    OfficialGameService dummyDataService = OfficialGameService();
    await dummyDataService.addOfficialGame();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Find A Game',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enter game Code that shared by your friends!',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type code here...',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Play Official Games!',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getGame
                  .where('createdBy', isEqualTo: 'Carbonara')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(document['text']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
