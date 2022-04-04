import 'package:flutter/material.dart';
// import 'package:flutter_sqlite/helpers/sql_helper.dart';
// import 'package:flutter_sqlite/pages/entryform.dart';
import 'package:sqflite/sqflite.dart';
import '../database/dbhelper.dart';
import '../models/item.dart';
import 'entry_form.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  List<Item> itemList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Item'),
        ),
        body: Column(
          children: [
            Expanded(
              child: createListView(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Tambah Item'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EntryForm()),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) => Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.ad_units),
                ),
                title: Text(
                  itemList[index].name,
                  style: textStyle,
                ),
                subtitle: Text(itemList[index].price.toString()),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () async {
                    // 3 TODO: delete by id
                  },
                ),
                onTap: () async {
                  /* var item =
 await navigateToEntryForm(context, itemList[index]); */
                  // 4 TODO: edit by id
                },
              ),
            ));
  }

  /* Future<Item> navigateToEntryForm(BuildContext context, Item? item) asyn
c {
 var result = await Navigator.push(
 context,
 MaterialPageRoute(builder: (context) => const EntryForm()),
 );
 return result;
 } */

  void updateListView() {
    final Future<Database> dbFuture = SQLHelper.db();
    dbFuture.then((database) {
      // TODO: get all item from DB
      Future<List<Item>> itemListFuture = SQLHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
        });
      });
    });
  }

  void delete(Item item) async {
    int idItem = await SQLHelper.deleteItem(Item.id);
    if (idItem > 0) {
      updateListView();
    }
  }

  void edit(Item item) async {
    int idItem = await SQLHelper.updateItem(item);
    if (idItem > 0) {
      updateListView();
    }
  }
}
