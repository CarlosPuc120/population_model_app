class Validators {
  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    if (double.tryParse(value) == null) {
      return 'Ingrese un número válido';
    }
    return null;
  }
}