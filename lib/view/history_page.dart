import 'package:flutter/material.dart';
import 'package:seekers/view/impaired/texttospeech.dart';

class HistoryPage extends StatefulWidget {
  int userRoles;
  HistoryPage(this.userRoles, {super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState(userRoles);
}

class _HistoryPageState extends State<HistoryPage> {
  int userRoles;
  _HistoryPageState(this.userRoles);

  @override
  void initState() {
    if(userRoles == 1){
      pageSpeech();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('History page'),
    );
  }

  void pageSpeech(){
    textToSpeech('This is History Page!');
  }

}