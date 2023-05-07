import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/view/impaired/texttospeech.dart';
import 'package:seekers/view/widget/history_card.dart';
import 'package:seekers/view/widget/skeleton.dart';

class HistoryImpairedPage extends StatefulWidget {
  String uid;
  HistoryImpairedPage(this.uid, {super.key});

  @override
  State<HistoryImpairedPage> createState() => _HistoryImpairedPageState(uid);
}

class _HistoryImpairedPageState extends State<HistoryImpairedPage> {

  String uid;
  _HistoryImpairedPageState(this.uid);

  List<Game> gameList = [];

  @override
  void initState() {
    pageSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 65),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Game History',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: fontColor
                )
              ),
              const SizedBox(height: 20),
              
              StreamBuilder<QuerySnapshot>(
                stream: getGame.orderBy('createdTime', descending: true).where('createdBy', isEqualTo: uid).snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Column(
                      children: [
                        skeletonBox(double.infinity, 125),
                        const SizedBox(height: 15),
                        skeletonBox(double.infinity, 125),
                      ]
                    );
                  }else if(snapshot.data!.docs.isEmpty){
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(image: AssetImage(inspired)),
                          Text(
                            'No Game Found\nPlay a game first!',
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
                  }else{
                    return Column(
                      children: 
                        (snapshot.data!).docs.map((e) {
                          
                          List<dynamic> items =  e['obj'];
                          List<ItemObject> itemObject = items.map((e) => ItemObject(image: e['image'], objName: e['objName'], description: e['description'], colaboratorDesc: e['colaboratorDesc'],)).toList();
                          Game gameObj = Game(place: e['place'], obj: itemObject, code: e['code'], createdBy: e['createdBy'], playedBy: e['playedBy'], createdTime: e['createdTime'], isPlayed: e['isPlayed']);
                          return HistoryCard(gameObj);
                        }).toList(),
                    );
                  }
                }
              )
            ],
          ),
        )
        
    );
  }

  void pageSpeech(){
    textToSpeech('This is History Page!');
  }

}