import 'package:assignment_contact_list/utilities/contact.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      child: ListTile(
        leading: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          child: Icon(Icons.contacts_rounded),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(
              color: Colors.deepOrange,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          contact.number,
          style: const TextStyle(fontSize: 15),
        ),
        trailing: const Icon(Icons.call,color: Colors.blue,),
      ),
    );
  }

}
