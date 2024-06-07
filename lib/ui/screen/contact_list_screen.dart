import 'package:assignment_contact_list/ui/widgets/contact_list.dart';
import 'package:assignment_contact_list/utilities/contact.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({
    super.key,
  });

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

final List<Contact> _contactList = [];

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Contact List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Number'),
                  controller: _numberTEController,
                  maxLength: 11,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Contact contact = Contact(
                        _numberTEController.text.trim(),
                        _nameTEController.text.trim(),
                      );
                      _addNewContact(contact);
                    }
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _contactList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onLongPress: () {
                          showDeleteConfirmationDialog(index);
                        },
                        child: ListCard(contact: _contactList[index]));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addNewContact(Contact contact) {
    _contactList.add(contact);
    setState(() {});
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Are you sure for Delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.no_sim_outlined),
            ),
            TextButton(
              onPressed: () {
                _contactList.removeAt(index);
                Navigator.pop(context);
                setState(() {});
              },
              child: const Icon(Icons.delete_outlined),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _numberTEController.dispose();
  }
}
