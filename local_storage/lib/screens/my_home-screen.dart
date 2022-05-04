import 'package:flutter/material.dart';
import 'package:local_storage/models/fruit_model.dart';
import 'package:local_storage/screens/widgets/dialogbox.dart';
import 'package:local_storage/screens/widgets/itemcard.dart';
import 'package:sqflite/sqflite.dart';

import '../db_service/database.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final DbManager dbManager =  DbManager();

  FruitModel? model;
  List<FruitModel>? modelList;
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();
  FocusNode? input1FocusNode;
  FocusNode? input2FocusNode;

  @override
  void initState() {
    input1FocusNode = FocusNode();
    input2FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    input1FocusNode!.dispose();
    input2FocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  DbManager dbManager = DbManager();

    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogBox().dialog(
                    context: context,
                    onPressed: () {
                      FruitModel fruitModel = FruitModel(
                          fruitName: input1.text, fruitQuantity: input2.text);
                      dbManager.insertFruitModel(fruitModel);
                      setState(() {
                        input1.text = "";
                        input2.text = "";
                      });
                      Navigator.of(context).pop();
                    },
                    textEditingController1: input1,
                    textEditingController2: input2,
                    input1FocusNode: input1FocusNode,
                    input2FocusNode: input2FocusNode,
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: Center(
            child: SafeArea(
          child: FutureBuilder(
            future: dbManager.getFruitModelList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                modelList = snapshot.data;
                return ListView.builder(
                    itemCount: modelList!.length,
                    itemBuilder: (context, index) {
                      FruitModel _fruitmodel = modelList![index];
                      return fruitItemCard(
                        fruitModel: _fruitmodel,
                        input1: input1,
                        input2: input2,
                        onDeletePress: () {
                          dbManager.deleteModel(_fruitmodel);
                          setState(() {});
                        },
                        onEditPress: () {
                          input1.text = _fruitmodel.fruitName ?? '';
                          input2.text = _fruitmodel.fruitQuantity ?? '';
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogBox().dialog(
                                    context: context,
                                    onPressed: () {
                                      FruitModel __fruitmodel = FruitModel(
                                          id: _fruitmodel.id,
                                          fruitName: input1.text,
                                          fruitQuantity: input2.text);
                                      dbManager.updateModel(__fruitmodel);

                                      setState(() {
                                        input1.text = "";
                                        input2.text = "";
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    textEditingController2: input2,
                                    textEditingController1: input1);
                              });
                        },
                      );
                    });
              }
              return Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
              );
            },
          ),
        )));
  }
}
