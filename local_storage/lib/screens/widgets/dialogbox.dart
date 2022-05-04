import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox {
  Widget dialog(
      {BuildContext? context,
      Function()? onPressed,
      TextEditingController? textEditingController1,
      TextEditingController? textEditingController2,
      FocusNode? input1FocusNode,
      FocusNode? input2FocusNode}) {
    return AlertDialog(
      title: Text('Enter Fruity Details'),
      content: Container(
        height: 100,
        child: Column(
          children:  [
            TextFormField(
              controller: textEditingController1,
              keyboardType: TextInputType.text,
              focusNode: input1FocusNode,
              decoration: InputDecoration(hintText: "Fruit Name"),
              autofocus: true,
              onFieldSubmitted: (value) {
                input1FocusNode!.unfocus();
                FocusScope.of(context!).requestFocus(input2FocusNode);
              },
            ),
            TextFormField(
              controller: textEditingController2,
              keyboardType: TextInputType.number,
              focusNode: input2FocusNode,
              decoration: InputDecoration(hintText: "Quantity"),
              onFieldSubmitted: (value) {
                input2FocusNode!.unfocus();
              },
            ),
          ],
        )
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context!).pop();
          },
          color: Colors.blueGrey,
          child: Text(
            "Cancel",
          ),
        ),
        MaterialButton(
          onPressed: onPressed,
          child: Text("Submit"),
          color: Colors.blue,
        )
      ],
    );
  }
}
