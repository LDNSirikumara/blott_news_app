import '../entities/user.dart';
import '../repository/user_repository.dart';

class GetUserName {
  final UserRepository repository;

  GetUserName(this.repository);

  Future<User?> call() {
    return repository.getUser();
  }
}
