import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText; // Texto sugestivo
  final IconData prefixIcon; // Icone que aparece na frente do texto digitado
  final IconData suffixIcon; // Icone que aparece no icon button depois do texto digitado
  final TextEditingController controller; // Controlador de texto
  final Function(String text) onChange; // Função a ser executada a cada mudança
  final Function() onClickSuffix; // Click do botão suffix
  final bool enable; // Define se a caixa de texto está habilitada ou não
  final bool obscure;

  MyTextFormField({
    // Construtor
    @required this.hintText, // O hint text se torna obrigatório
    this.onClickSuffix,
    this.obscure,
    this.enable,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure ?? false, // Define se o texto digitado fica oculto ou nao.
      controller: controller,
      onChanged: onChange,
      enabled: enable,
      decoration: InputDecoration( // Decora o nosso TextField
        contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0), // Espaçamento entre as bordas e o conteudo
        border: OutlineInputBorder( // Aparencia da borda
          borderRadius: BorderRadius.circular(100), // Torna a borda arredondada
          borderSide: BorderSide.none, // Oculta as linhas da borda
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true, // Torna o text field "preenchivel" para o proximo atributo
        fillColor: Colors.grey[300], // Cor de preenchimento do text field
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: onClickSuffix)
            : null,
      ),
    );
  }
}
