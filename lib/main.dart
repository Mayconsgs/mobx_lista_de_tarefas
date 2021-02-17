import 'package:flutter/material.dart';
import 'package:mobxlistadetarefas/screens/login_screen.dart';
import 'package:mobxlistadetarefas/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (context) => LoginStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          // Cor primária para os objetos
          primarySwatch: Colors.deepPurple,
          // Cor de pequenas coisas do dispositivo "Não sei explicar muito bem"
          cursorColor: Colors.deepPurpleAccent,
          // Define a cor do cursor
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
