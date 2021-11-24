import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Error"),
    content: const Text(
        "There are issues connecting to the server.\n Please try again later!"),
    actions: <Widget>[
      TextButton(
        child: const Text('Ok'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

// Future<void> showAlertDialog() async {
//   var context;
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//               Text(
//                   'There are issues connecting to the server.\n Please try again later!'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
