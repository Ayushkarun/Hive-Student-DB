import 'package:flutter/material.dart';
import 'model/mydb_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'functions/mydb_services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:adder/details_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _editnameController = TextEditingController();
  final TextEditingController _editdomainController = TextEditingController();
  final TextEditingController _editageController = TextEditingController();
  final TextEditingController _editplaceController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _domainFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _placeFocusNode = FocusNode();
  final FocusNode _savefocusnode = FocusNode();
  final MydbServices _service = MydbServices();
  List<Mydb> _items = [];

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _domainFocusNode.dispose();
    _ageFocusNode.dispose();
    _placeFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    _items = await _service.getMydb();
    setState(() {});
  }

  Future<void> _saveItem() async {
    FocusScope.of(context).unfocus();
    if (_nameController.text.isEmpty ||
        _domainController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _domainController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill both fields!")));
      return;
    }
    final newItem = Mydb(
      name: _nameController.text,
      domain: _domainController.text,
      age: _ageController.text,
      place: _placeController.text,
    );

    await _service.addMydb(newItem);

    _nameController.clear();
    _domainController.clear();
    _ageController.clear();
    _placeController.clear();
    _loadItems();
  }

  void _editItem(Mydb item, int index) {
    _editnameController.text = item.name;
    _editdomainController.text = item.domain;
    _editageController.text = item.age;
    _editplaceController.text = item.place;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _editnameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: _editdomainController,
                  decoration: InputDecoration(labelText: "Domain"),
                ),
                TextField(
                  controller: _editageController,
                  decoration: InputDecoration(labelText: "Age"),
                ),
                TextField(
                  controller: _editplaceController,
                  decoration: InputDecoration(labelText: "Place"),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                item.name = _editnameController.text;
                item.domain = _editdomainController.text;
                item.age = _editageController.text;
                item.place = _editplaceController.text;

                await _service.updateMydb(index, item);

                Navigator.pop(context);

                FocusScope.of(context).unfocus();
                _nameController.clear();
                _domainController.clear();
                _ageController.clear();
                _placeController.clear();

                _loadItems();
              },
              child: Text("save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(int index) async {
    await _service.deleteMydb(index);
    _loadItems(); // Refresh the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyDB'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              decoration: InputDecoration(labelText: 'Name'),
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(_domainFocusNode);
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _domainController,
              focusNode: _domainFocusNode,
              decoration: InputDecoration(labelText: 'Domain'),
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(_ageFocusNode);
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    focusNode: _ageFocusNode,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_placeFocusNode);
                    },
                    keyboardType: TextInputType.number, // Number keyboard
                    decoration: const InputDecoration(labelText: 'Age'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _placeController,
                    focusNode: _placeFocusNode,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_savefocusnode);
                    },

                    decoration: const InputDecoration(labelText: 'Place'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              focusNode: _savefocusnode,
              onPressed: _saveItem,
              child: Text('Save'),
            ),
            SizedBox(height: 10),
            Expanded(
              child:
                  _items.isEmpty
                      ? Center(child: Text("No items yet"))
                      : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ), //
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => Screen2(
                                          name: item.name,
                                          domain: item.domain,
                                          age: item.age,
                                          place: item.place,
                                          index: index,
                                        ),
                                  ),
                                );
                              },
                              title: Text(item.name),
                              subtitle: Text(item.domain),
                              trailing: SizedBox(
                                width: 100, // Fixed width for trailing widgets
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, size: 20),
                                      onPressed: () {
                                        _editItem(item, index);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _deleteItem(index);
                                      },
                                    ),
                                  ],
                                ),
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


/*
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen2(),
        ),
      );
*/