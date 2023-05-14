import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/factory/user_factory.dart';
import 'package:seekers/service/official_game_service.dart';
import 'package:seekers/view/peer/describe_peer_page.dart';
import 'package:seekers/view/peer/official_game_card.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 38, right: 38, top: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Find A Game',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: fontColor),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter game Code that shared by your friends!',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: fontColor),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appOrange, width: 3)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: appOrange, width: 3)),
                  hintText: 'Type code here...',
                  filled: true,
                  fillColor: whiteGrey,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      try {
                        DocumentReference docRef =
                            db.collection('games').doc(textController.text);
                        var docSnapshot = await docRef.get();

                        if (docSnapshot.exists) {
                          final data =
                              docSnapshot.data() as Map<String, dynamic>;

                          List<dynamic> items = data['obj'];
                          List<ItemObject> itemObject = items.map(
                            (e) {
                              return ItemObject(
                                image: e['image'],
                                objName: e['objName'],
                                description: e['description'],
                                colaboratorDesc: e['colaboratorDesc'],
                              );
                            },
                          ).toList();

                          Game game = Game(
                              code: data['code'],
                              place: data['place'],
                              createdBy: data['createdBy'],
                              createdTime: data['createdTime'],
                              playedBy: data['playedBy'],
                              isPlayed: data['isPlayed'],
                              colaboratorUid: data['colaboratorUid'],
                              obj: itemObject);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DescribePeerPage(game, 0, false)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Game does not exists'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (e) {
                        print('Error getting document: $e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appOrange,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Play!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ))),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: fontColor),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Play Official Games!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: fontColor),
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
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
                          return OfficialGameCard(gameObj, 'Carbonara');
                        }).toList(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
