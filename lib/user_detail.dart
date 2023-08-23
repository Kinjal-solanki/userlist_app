
import 'package:flutter/material.dart';
import 'package:user_list_app/table_row_card.dart';
import 'Model/Model.dart';

class UserDetail extends StatefulWidget {
  final User user;
  const UserDetail({super.key, required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late User user;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("User Detail"),
        ),
        body: _getUserDetail(widget.user)
    );
  }

  Widget _getUserDetail(User user) {
   return Align(
     alignment: Alignment.topCenter,
     child: Container(
         child: Column(
             children: [
               Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage('${user.picture.large}'),
                        fit: BoxFit.fill
                    ),
                  ),
                ),
               Center(
                // Adjust width as needed
                   child:  Padding(
                     padding: const EdgeInsets.only(top: 20),
                     child: Column(
                       children: [
                         Text('Basic Info', style: TextStyle(fontSize: 20),),
                         TableRowCard('Name', '${user.name.title } ' + '${user.name.first } ' + '${user.name.last}' ),
                         TableRowCard('Gender', user.gender.name.toLowerCase()),
                         TableRowCard('Email', user.email),
                         TableRowCard('Contact', user.phone),
                         TableRowCard('Age', '${user.dob.age}'),
                       ],
                     ),
                   ),
                 ),
               /*Container(
                 padding: EdgeInsets.all(20),
                 width: 300, // Adjust width as needed
                 child: Table(
                   border: TableBorder.symmetric(),
                   defaultColumnWidth: IntrinsicColumnWidth(),
                   children: [
                     _getTableRow('Name', '${user.name.title } ' + '${user.name.first } ' + '${user.name.last}' ),
                     _getTableRow('Gender', user.gender.name.toLowerCase()),
                     _getTableRow('Email', user.email),
                     _getTableRow('Contact', user.phone),
                     _getTableRow('Age', '${user.dob.age}'),
                     // Add more rows as needed
                   ],
                 ),
               )*/
             ],
           ),
       ),
   );
  }

  TableRow _getTableRow(String title, String value) {
    return TableRow(
      children: [
        TableCell(child: Text('$title')),
        TableCell(child: Text('$value')),
      ],
    );
  }
}
