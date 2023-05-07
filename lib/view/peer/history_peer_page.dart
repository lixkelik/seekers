import 'package:seekers/constant/constant_builder.dart';

class HistoryPeerPage extends StatefulWidget {
  String uid;
  HistoryPeerPage(this.uid, {super.key});

  @override
  State<HistoryPeerPage> createState() => _HistoryPeerPageState(uid);
}

class _HistoryPeerPageState extends State<HistoryPeerPage> {

  String uid;
  _HistoryPeerPageState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}