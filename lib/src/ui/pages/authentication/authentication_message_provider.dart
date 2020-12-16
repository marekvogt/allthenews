import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/communication/firebase_exception.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';

class AuthenticationMessageProvider extends MessageProvider {
  @override
  String getMessage(Object error) {
    if (error is AuthenticationApiException) {
      if (error is NetworkException) {
        return Strings.current.noInternetException;
      } else if (error is InvalidEmailException) {
        return Strings.current.invalidEmailError;
      } else if (error is UserDisabledException) {
        return Strings.current.userDisabledError;
      } else if (error is UserNotFoundException) {
        return Strings.current.userNotFoundError;
      } else if (error is InvalidPasswordException) {
        return Strings.current.invalidPasswordError;
      } else if (error is EmailAlreadyInUseException) {
        return Strings.current.emailAlreadyInUseError;
      } else if (error is NetworkException) {
        return Strings.current.operationNotAllowedError;
      } else if (error is WeakPasswordException) {
        return Strings.current.weakPasswordError;
      } else if (error is TooManyRequestsException) {
        return Strings.current.tooManyRequests;
      }
    }
    return Strings.current.unknownError;
  }
}
