import 'dart:io';

import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/view/impaired/success_page.dart';

class DescribePeerPage extends StatefulWidget {
  Game game;
  int objectCount;
  DescribePeerPage(this.game, this.objectCount, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DescribePeerPage> createState() =>
      _DescribePageState(game, objectCount);
}

class _DescribePageState extends State<DescribePeerPage> {
  Game game;
  int objectCount;

  _DescribePageState(this.game, this.objectCount);

  TextEditingController textController = TextEditingController();
  File? img;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Transform.rotate(
          angle: 3.14 / 2,
          child: SizedBox(
              height: 392.75,
              child: (img != null)
                  ? Image.file(
                      img!,
                      fit: BoxFit.cover,
                      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
        ),
        Align(
            child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.5,
          maxChildSize: 0.65,
          builder: (_, ScrollController scrollController) => Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Touch it!',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: fontColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                          'What is the texture? Is it soft or hard? and the weight, is it light or heavy? How about the size? Is it big or small? What is the function of the object?',
                          softWrap: true,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 13, color: fontColor)),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        maxLength: 150,
                        controller: textController,
                        decoration: const InputDecoration(
                          fillColor: Color(0xffE9E9E9),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: 'Enter text here Or talk',
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (textController.text.isNotEmpty ||
                                  textController.text != '') {
                                String description = textController.text;
                                game.obj[objectCount].colaboratorDesc =
                                    description;
                                if (objectCount < 5) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              // ke page selanjutnya
                                              DescribePeerPage(
                                                  game, objectCount + 1)));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SuccessPage(game) // loading page
                                          ));
                                }
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
                            child: const Text('Next!',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ))),
                      ),
                    ]),
              ),
            ),
          ),
        )),
      ]),
    );
  }

  Future<void> _evictImage() async {
    await FileImage(img!).evict();
    setState(() {});
  }
}
