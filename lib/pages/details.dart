import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/users.dart';


// class Details extends StatelessWidget {
//   final User user;
//   const Details({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: Text(user.fullName),
//       ),
//       body: Center(child: Text(user.email)),
//     );
// }

class Details extends StatefulWidget {
  final User item;
  const Details({super.key, required this.item});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  
  @override
  Widget build(BuildContext context) {
    User item = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.fullName),
      ),
      body: Center(child: Text(item.email)),
    );
  }
}