import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/view/authentication/login_page.dart';
import 'package:seekers/factory/user_factory.dart';
import 'package:seekers/view/repository/firestore_repository.dart';
import 'package:seekers/view/impaired/texttospeech.dart';

class ProfilePage extends StatefulWidget {
  int userRoles;
  ProfilePage(this.userRoles, {super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState(userRoles);
}

class _ProfilePageState extends State<ProfilePage> {
  int userRoles;
  _ProfilePageState(this.userRoles);

  UserSeekers? user;

  @override
  void initState() {
    if(userRoles == 1){
      pageSpeech(); 
    }
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 38, right: 38, top: 55, bottom: 10),
        height: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 93,
                  height: 93,
                  margin: const EdgeInsets.only(right: 12),
                  child: const Image(image: AssetImage(profilePic)),
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  (user != null)
                      ? Text(
                          user!.name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : skeletonBox(140, 30),
                  const SizedBox(
                    height: 10,
                  ),
                  (user != null)
                      ? Text(
                          user!.email,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      : skeletonBox(170, 20)
                ])
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  onPressed: () {
                    signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appOrange,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Logout',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ))),
            ),
            const SizedBox(
              width: double.infinity,
              child: Text('Preference',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 95,
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text('Speech Reading Speed',
                            style: TextStyle(
                              fontSize: 20,
                              
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: white,
                          ),
                          width: 75,
                          height: 50,
                          child: Center(
                            child: Text(speechRate.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 220,
                          child: Slider(
                              activeColor: appOrange,
                              max: 1,
                              min: 0.25,
                              value: speechRate,
                              onChanged: (double value) {
                                setState(() {
                                  speechRate = value;
                                });
                              }),
                        )
                      ]),
                    ],
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Container(
                width: double.infinity,
                height: 95,
                decoration: const BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text('Speech Volume',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: white,
                          ),
                          width: 75,
                          height: 50,
                          child: Center(
                            child: Text(volume.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 220,
                          child: Slider(
                              activeColor: appOrange,
                              max: 2,
                              min: 0.1,
                              value: volume,
                              onChanged: (double value) {
                                setState(() {
                                  volume = value;
                                });
                              }),
                        )
                      ]),
                    ],
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: const Image(image: AssetImage(walkingMan)),
              ),
            )
          ],
        ),
      ),
    );
  }

  signOut() async {
    await auth.signOut();
  }

  Future<void> _getUserData() async {
    UserSeekers user = await getUserData();
    setState(() {
      this.user = user;
    });
  }

  void pageSpeech() {
    textToSpeech('You are at: Profile page!');
  }
}
