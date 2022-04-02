import 'package:flutter/material.dart';
import '../models/item.dart';

class EntryForm extends StatefulWidget {
  final Item item;
  const EntryForm({Key? key, required this.item});
  @override
  EntryFormState createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  late Item item;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      nameController.text = item.name;
      priceController.text = item.price.toString();
    }

    return Scaffold(
        appBar: AppBar(
          title: item == null ? const Text('Tambah') : const Text('Ubah'),
          leading: const Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              //Tombol
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (item == null) {
                            item = Item(nameController.text,
                                int.parse(priceController.text));
                          } else {
                            item.name = nameController.text;
                            item.price = int.parse(priceController.text);
                          }

                          Navigator.pop(context, item);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
