import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class list_note extends StatelessWidget {
  const list_note({
    super.key,
    required this.ischecked,
    required this.onChanged,
    required this.data,
    required this.delatenote,
  });
  final bool ischecked;
  final VoidCallback onChanged;
  final String data;
  final VoidCallback delatenote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            GestureDetector(
              onTap: () {
                delatenote();
              },
              child: Container(
                width: 160,
                decoration: BoxDecoration(color: Colors.red),
                child: Center(child: Icon(Icons.delete)),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data,
                style: TextStyle(
                  decoration:
                      ischecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                  color: ischecked ? const Color.fromARGB(126, 0, 0, 0) : Colors.black,
                ),
              ),
              Checkbox(
                value: ischecked,
                onChanged: (bool? value) {
                  onChanged();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
