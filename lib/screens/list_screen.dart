import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobxlistadetarefas/screens/login_screen.dart';
import 'package:mobxlistadetarefas/stores/list_store.dart';
import 'package:mobxlistadetarefas/stores/login_store.dart';
import 'package:mobxlistadetarefas/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  final ListStore listStore = ListStore();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Tarefas",
          style: TextStyle(fontSize: 32),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
              onPressed: () {
                Provider.of<LoginStore>(context, listen: false).logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: _boxShadow(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Observer(builder: (context) {
              return MyTextFormField(
                hintText: "Nova tarefa",
                suffixIcon: listStore.isFormValid ? Icons.add : null,
                onChange: listStore.setNewTodoTitle,
                onClickSuffix: () {
                  listStore.addTodo();
                  controller.clear();
                },
                controller: controller,
              );
            }),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: Observer(builder: (_) {
                return ListView.separated(
                  itemCount: listStore.todoList.length,
                  itemBuilder: (_, index) {
                    final todo = listStore.todoList[index];
                    return Observer(builder: (_) {
                      return ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                              decoration:
                                  todo.done ? TextDecoration.lineThrough : null,
                              color: todo.done ? Colors.grey : Colors.black,
                              fontWeight: todo.done ? null : FontWeight.bold),
                        ),
                        onTap: todo.toggleDone,
                      );
                    });
                  },
                  separatorBuilder: (_, __) {
                    return Divider();
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<BoxShadow> _boxShadow() {
    // Função que cria a sombra do container
    List<BoxShadow> boxShadow = List<BoxShadow>();
    boxShadow
        .add(BoxShadow(color: Colors.black54, blurRadius: 12, spreadRadius: 2));

    return boxShadow;
  }
}
