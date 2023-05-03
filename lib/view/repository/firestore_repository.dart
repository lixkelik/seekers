import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/view/factory/user_factory.dart';

Future<String> getUid() async{
  String uid;
  uid = auth.currentUser!.uid;
  return uid;
}


Future<UserSeekers> getUserData() async{

  String uid = await getUid();
  QuerySnapshot querySnapshot = await db.collection('users').where('uid', isEqualTo: uid).get();

  UserSeekers user = UserSeekers(
    uid: uid,
    name: querySnapshot.docs[0]['name'].toString(),
    email: querySnapshot.docs[0]['email'].toString(),
    role: querySnapshot.docs[0]['role'] ,
  );
  return user;
}
