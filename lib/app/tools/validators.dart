String? validateEmail(String input) {
  {
    String pattern =
        r'^(([^<>()[]\.,;:s@"]+(.[^<>()[]\.,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])|(([a-zA-Z-0-9]+.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(input.trim())) {
      return 'Ingrese un correo electrónico válido';
    } else {
      return null;
    }
  }
}

String? noValidate() {
  return null;
}

String? validatePassword(input) {
  if (input.trim().length < 6) {
    return 'La contraseña debe tener mínimo 6 caracteres';
  }

  if (input.trim().length > 20) {
    return 'La contraseña debe tener máximo 20 caracteres';
  }

  return null;
}

String? validateText(input) {
  if (input.trim() == "" || input.trim().length < 2) {
    return 'Este campo es obligatorio';
  } else {
    return null;
  }
}

String? validatePhone(input) {
  String pattern = r'^(?:[+0][1-9])?[0-9]{7,20}$';
  RegExp regExp = RegExp(pattern);

  if (input.isNotEmpty && !regExp.hasMatch(input.trim())) {
    return 'Ingrese un teléfono válido';
  }
  return null;
}

String? validateDocument(input) {
  String pattern = r'^[0-9]+$';
  RegExp regExp = RegExp(pattern);

  if (input.trim().length < 6 || !regExp.hasMatch(input)) {
    return 'Ingrese un documento válido';
  } else {
    return null;
  }
}
