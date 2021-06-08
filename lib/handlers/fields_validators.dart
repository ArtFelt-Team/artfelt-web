class FieldsValidators {
  static List<String> passwordValidator(String text) {
    var test = text;
    List<String> errors = [];
    if (test.contains(RegExp(r'[0-9]'))) {
      errors.add("Text should have at least one number");
    }
    
    return errors;
  }
}
