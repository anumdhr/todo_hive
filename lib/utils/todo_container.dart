import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    this.onPressed,
  });

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(15),
            onPressed: onPressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          )
        ]),
        child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Checkbox(
                    activeColor: Colors.black, checkColor: Colors.purple, value: taskCompleted, onChanged: onChanged),
                Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
