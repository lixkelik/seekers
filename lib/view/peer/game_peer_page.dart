import 'package:flutter/material.dart';

class GamePeer extends StatelessWidget {
  const GamePeer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         'Enter some text:',
        //         style: TextStyle(fontSize: 18),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 16),
        //       child: TextField(
        //         controller: _controller,
        //         decoration: InputDecoration(
        //           hintText: 'Type something...',
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         'Data from database:',
        //         style: TextStyle(fontSize: 18),
        //       ),
        //     ),
        //     Expanded(
        //       child: StreamBuilder<QuerySnapshot>(
        //         stream: FirebaseFirestore.instance
        //             .collection('my_collection')
        //             .snapshots(),
        //         builder: (BuildContext context,
        //             AsyncSnapshot<QuerySnapshot> snapshot) {
        //           if (!snapshot.hasData) {
        //             return Center(child: CircularProgressIndicator());
        //           }
        //           return ListView.builder(
        //             itemCount: snapshot.data!.docs.length,
        //             itemBuilder: (BuildContext context, int index) {
        //               final DocumentSnapshot document =
        //                   snapshot.data!.docs[index];
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   width: double.infinity,
        //                   padding: const EdgeInsets.all(16),
        //                   decoration: BoxDecoration(
        //                     color: Colors.grey[200],
        //                     borderRadius: BorderRadius.circular(10),
        //                   ),
        //                   child: Text(document['text']),
        //                 ),
        //               );
        //             },
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
