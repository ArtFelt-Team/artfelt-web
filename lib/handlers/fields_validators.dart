
class FieldsValidators {
  static List<String> passwordValidator(String text) {
    var test = text;
    List<String> errors = [];
    if (test.contains(RegExp(r'[0-9]'))) {
      errors.add("Text should have at least one number");
    }
    if(test.length < 7 || test.length > 20){
      errors.add("Password should be between 7 and 20 caracters long");
    }
    return errors;
  }
}
