import 'package:flutter/material.dart';

enum TodoAction {
  edit,
  delete,
  markComplete,
  markIncomplete,
}

class TodoPopupMenu extends StatefulWidget {
  final String todoText;
  final bool isCompleted;
  final Function(TodoAction, String) onActionSelected;

  const TodoPopupMenu({
    Key? key,
    required this.todoText,
    required this.isCompleted,
    required this.onActionSelected,
  }) : super(key: key);

  @override
  State<TodoPopupMenu> createState() => _TodoPopupMenuState();
}

class _TodoPopupMenuState extends State<TodoPopupMenu> {
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TodoAction>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (TodoAction action) {
        widget.onActionSelected(action, widget.todoText);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<TodoAction>(
          value: TodoAction.edit,
          child: const Row(
            children: [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem<TodoAction>(
          value: widget.isCompleted ? TodoAction.markIncomplete : TodoAction.markComplete,
          child: Row(
            children: [
              Icon(
                widget.isCompleted ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: widget.isCompleted ? Colors.orange : Colors.green,
              ),
              const SizedBox(width: 8),
              Text(widget.isCompleted ? 'Mark Incomplete' : 'Mark Complete'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<TodoAction>(
          value: TodoAction.delete,
          child: const Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomPopupMenuItem extends PopupMenuItem<String> {
  const CustomPopupMenuItem({
    Key? key,
    required String value,
    required Widget child,
    VoidCallback? onTap,
  }) : super(key: key, value: value, child: child);
}

class ConfirmationPopup {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}