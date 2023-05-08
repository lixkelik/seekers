import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/factory/game_factory.dart';

class ReviewPage extends StatefulWidget {
  int gameCounter;
  Game gameObj;
  ReviewPage(this.gameObj, this.gameCounter, {super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState(gameObj, gameCounter);
}

class _ReviewPageState extends State<ReviewPage> {
  Game gameObj;
  int gameCounter;
  _ReviewPageState(this.gameObj, this.gameCounter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                color: appOrange,
                width: double.infinity,
                height: 1000,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Transform.rotate(
                      angle: 3.14 / 2,
                      child: SizedBox(
                        height: 392.75,
                        child:Image.network(
                            gameObj.obj[gameCounter].image,
                            width: double.infinity,
                          ),
                      ),
                    ),
                    
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}