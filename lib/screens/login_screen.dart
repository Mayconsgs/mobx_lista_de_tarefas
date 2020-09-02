import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobxlistadetarefas/screens/list_screen.dart';
import 'package:mobxlistadetarefas/stores/login_store.dart';
import 'package:mobxlistadetarefas/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore;

  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);

    disposer = autorun((_){
      if(loginStore.loggedIn)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListScreen()),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: _boxShadow(),
              ),
              child: Column(
                children: [
                  Observer(builder: (_) {
                    return MyTextFormField(
                      hintText: "Login",
                      enable: !loginStore.loading,
                      prefixIcon: Icons.person_pin,
                      onChange: loginStore.setEmail,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return MyTextFormField(
                      obscure: !loginStore.passwordVisible,
                      hintText: "Senha",
                      enable: !loginStore.loading,
                      prefixIcon: Icons.lock,
                      suffixIcon: loginStore.passwordVisible ?  Icons.visibility_off : Icons.visibility ,
                      onChange: loginStore.setPassword,
                      onClickSuffix: loginStore.tooglePasswordVisibility,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return RaisedButton(
                      color: primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: loginStore.loading ?
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ) : Text("Login"),
                      onPressed: loginStore.loginPressed,
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  List<BoxShadow> _boxShadow() { // Função que cria a sombra do container
    List<BoxShadow> boxShadow = List<BoxShadow>();
    boxShadow.add(BoxShadow(
      color: Colors.black54,
      blurRadius: 12,
      spreadRadius: 2,
    ));
    return boxShadow;
  }
}

