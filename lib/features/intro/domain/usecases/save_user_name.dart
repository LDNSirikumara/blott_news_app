import '../entities/user.dart';
import '../repository/user_repository.dart';

class SaveUserName {
  final UserRepository repository;

  SaveUserName(this.repository);

  Future<void> call(User user) {
    return repository.saveUser(user);
  }
}
