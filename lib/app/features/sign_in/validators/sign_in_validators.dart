class SignInValidators {
  String? emailValidate(String? value) {
    if (value?.isEmpty == true) {
      return 'Informe o e-mail';
    }
    if (value?.contains("@") == false) {
      return 'Informe um e-mail válido';
    }
    return null;
  }

  String? passwordValidate(String? value) {
    if (value?.isEmpty == true) {
      return 'Informe a senha';
    }
    return null;
  }
}
