import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/user.dart';

class UserLocalDataSource {
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', user.firstName);
    await prefs.setString('lastName', user.lastName);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('firstName');
    final lastName = prefs.getString('lastName');
    if (firstName != null && lastName != null) {
      return User(firstName: firstName, lastName: lastName);
    }
    return null;
  }
}
