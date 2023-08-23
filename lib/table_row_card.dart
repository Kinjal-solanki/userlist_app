import 'package:flutter/material.dart';

class TableRowCard extends StatelessWidget {
  final String name;
  final String value;

  TableRowCard(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: Text(name)),
            Expanded(child: Text(value)),
          ],
        ),
      ),
    );
  }
}