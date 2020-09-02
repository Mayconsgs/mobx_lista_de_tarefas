import 'package:mobx/mobx.dart';
import 'package:email_validator/email_validator.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = "";
  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";
  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;
  @action
  void tooglePasswordVisibility() => passwordVisible = !passwordVisible;

  @observable
  bool loading = false;
  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  @observable
  bool loggedIn = false;

  @action
  void logout() {
    loggedIn = false;
  }

  // Computeds
  @computed
  bool get isEmailValid => EmailValidator.validate(email);

  @computed
  bool get isPasswordValid => password.length >= 8;

  @computed
  Function get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : null;


}
