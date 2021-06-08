import 'package:test/test.dart';
import 'package:web_backoffice/handlers/fields_validators.dart';

void main() {
  test('Errors should contains \"Text should have at least one number\"', () {
    final text = "salayna";
    final errors = FieldsValidators.passwordValidator(text);
    print(errors[0]);
    expect(errors.contains("Text should have at least one number"), true);
  });
}
