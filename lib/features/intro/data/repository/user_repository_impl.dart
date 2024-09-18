import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../data_sources/local/user_local_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveUser(User user) {
    return localDataSource.saveUser(user);
  }

  @override
  Future<User?> getUser() {
    return localDataSource.getUser();
  }
}
