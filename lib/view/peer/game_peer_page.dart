import 'package:flutter/material.dart';
import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/service/official_game_service.dart';
import 'package:seekers/view/widget/skeleton.dart';

import '../widget/history_impaired_card.dart';

class GamePeer extends StatefulWidget {
  const GamePeer({super.key});
  @override
  State<GamePeer> createState() => _GamePeerState();
}

class _GamePeerState extends State<GamePeer> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // _addOfficialGame();
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
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(children: [
                      skeletonBox(double.infinity, 125),
                      const SizedBox(height: 15),
                      skeletonBox(double.infinity, 125),
                    ]);
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(image: AssetImage(inspired)),
                          Text(
                            'No official game',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: fontColor.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: (snapshot.data!).docs.map((e) {
                        List<dynamic> items = e['obj'];
                        List<ItemObject> itemObject = items
                            .map((e) => ItemObject(
                                image: e['image'],
                                objName: e['objName'],
                                description: e['description'],
                                colaboratorDesc: e['colaboratorDesc']))
                            .toList();
                        Game gameObj = Game(
                            place: e['place'],
                            obj: itemObject,
                            code: e['code'],
                            createdBy: e['createdBy'],
                            playedBy: e['playedBy'],
                            createdTime: e['createdTime'],
                            isPlayed: e['isPlayed'],
                            colaboratorUid: e['colaboratorUid']);
                        return HistoryImpairedCard(gameObj, 'Carbonara');
                      }).toList(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
