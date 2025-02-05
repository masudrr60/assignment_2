import 'package:flutter/material.dart';

void main() {
  runApp( ContactApp());
}

class ContactApp extends StatelessWidget {
  ContactApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  ContactListScreenState createState() => ContactListScreenState();
}

class ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final List<Map<String, String>> contacts = [];

  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add({'name': name, 'number': number});
      });
      nameController.clear();
      numberController.clear();
    }
  }

  void deleteContact(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:Text("Confirmation"),
        content:Text("Are you sure for delete?"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon:Icon(Icons.cancel_outlined, color: Colors.blueAccent),
            tooltip: "Cancel",
          ),
          IconButton(
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            icon:Icon(Icons.delete, color: Colors.blueAccent),
            tooltip: "Delete",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title:Text(
          "Contact List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
             SizedBox(height: 10),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.phone,
              decoration:InputDecoration(
                labelText: "Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child:Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
         SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => deleteContact(index),
                    child: Card(
                      child: ListTile(
                        leading:
                       Icon(Icons.person, color: Colors.grey),
                        title: Text(
                          contacts[index]['name'] ?? '',
                          style:TextStyle(color: Colors.red),
                        ),
                        subtitle: Text(contacts[index]['number'] ?? ''),
                        trailing: Icon(Icons.call,
                            color: Colors.blueAccent),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
