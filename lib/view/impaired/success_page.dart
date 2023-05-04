import 'dart:math';

import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/view/impaired/game_impaired_page.dart';

class SuccessPage extends StatefulWidget {
  String title;
  List<ItemObject> objects; 
  SuccessPage( this.title,this.objects, {super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState(title, objects);
}

class _SuccessPageState extends State<SuccessPage> {
  String title;
  List<ItemObject> objects; 
  _SuccessPageState(this.title,this.objects);

  String _gameCode = '';

  @override
  void initState() {
    super.initState();
    codeGenerator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 38, right: 38, top: 95),
        child: Column(
          children: [
            const Text(
              'Good job!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: fontColor
              )
            ),
            const Text(
              'You have scanned and described 5 object!',
              softWrap: true,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: fontColor
              )
            ),
            const SizedBox(height: 47,),
            const Image(
              image: AssetImage(completedTask),
              height: 302,
              width: 302,
            ),
            const SizedBox(height: 54,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const GameImpaired())
                  );
                },
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: appOrange,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Return',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  void codeGenerator(){
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final random = Random.secure();
    setState(() {
      _gameCode = String.fromCharCodes(Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    });
  }

}