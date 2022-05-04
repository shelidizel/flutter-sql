import 'package:flutter/material.dart';
import 'package:local_storage/db_service/database.dart';
import 'package:local_storage/models/fruit_model.dart';

class fruitItemCard extends StatefulWidget {
  FruitModel? fruitModel;
   TextEditingController? input1;
  TextEditingController? input2;
  Function()? onDeletePress;
  Function()? onEditPress;
  fruitItemCard({Key? key, this.fruitModel, this.onDeletePress, this.onEditPress, this.input1, this.input2}) : super(key: key);

  @override
  State<fruitItemCard> createState() => _fruitItemCardState();
}

class _fruitItemCardState extends State<fruitItemCard> {
  final DbManager dbManager = DbManager();
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Name: ${widget.fruitModel!.fruitName }', style: TextStyle(fontSize: 15),),
              Text(
                  'Quantity: ${widget.fruitModel!.fruitQuantity}',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                   backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: widget.onEditPress,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                 CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: widget.onDeletePress,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
}


