import 'package:flutter/material.dart';
import 'package:seekers/view/repository/firestore_repository.dart';

class HomePeerPage extends StatefulWidget {
  const HomePeerPage({super.key});

  @override
  State<HomePeerPage> createState() => _HomePeerPageState();
}

class _HomePeerPageState extends State<HomePeerPage> {

  String uid = '';
  @override
  void initState() {
    _getUid();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return  Center(
      child: Text(uid),
    );
  }

  Future<void> _getUid() async {
    String value = await getUid();
    setState(() {
      uid = value;
    });
  }
  
}