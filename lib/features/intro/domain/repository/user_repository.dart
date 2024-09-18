import '../../data/data_sources/local/user_local_datasource.dart';
import '../entities/user.dart';

class UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepository(this.localDataSource);

  Future<void> saveUser(User user) {
    return localDataSource.saveUser(user);
  }

  Future<User?> getUser() {
    return localDataSource.getUser();
  }
}
