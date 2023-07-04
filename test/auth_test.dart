import 'package:codecampapp/services/auth/auth_exceptions.dart';
import 'package:codecampapp/services/auth/auth_provider.dart';
import 'package:codecampapp/services/auth/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mock authentication', () {
    final provider = MockAuthProvider();
    test('should not be intialized to begin with', () {
      expect(provider.isIntialized, false);
    });
    test('cannot log out is not intialized', () {
      expect(provider.logOut(),
          throwsA(const TypeMatcher<NotIntializedException>()));
    });
    test('Should be able to be intialized', () async {
      await provider.intialize();
      expect(provider._isIntialized, true);
    });
    test('user should be null after intialization', () {
      expect(provider.currentUser, null);
    });
    test('Should be able to intialize in less than 2s', () async {
      await provider.intialize();
      expect(provider.isIntialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));
    test('create user should delegate to login function', () async {
      final badEmailUser =
          provider.createUser(email: 'foo@bar.com', password: 'anypass');
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));
      final badPassUser =
          provider.createUser(email: 'any@any.com', password: 'foobarbaz');
      expect(badPassUser,
          throwsA(const TypeMatcher<WroingPasswordAuthException>()));
      final user = await provider.createUser(email: 'foo', password: 'bar');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerifcation();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test('Should be able to log out and log in again', () async {
      await provider.logOut();
      await provider.logIn(email: 'email', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotIntializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isIntialized = false;
  bool get isIntialized => _isIntialized;

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!_isIntialized) {
      throw NotIntializedException();
    }
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> intialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isIntialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!_isIntialized) {
      throw NotIntializedException();
    }
    if (email == 'foo@bar.com') {
      throw UserNotFoundAuthException();
    }
    if (password == 'foobarbaz') {
      throw WroingPasswordAuthException();
    }
    const user =
        AuthUser(isEmailVerified: false, email: 'foo@bar.com', id: 'my_id');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!_isIntialized) {
      throw NotIntializedException();
    }
    if (_user == null) {
      throw UserNotFoundAuthException();
    }
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerifcation() async {
    if (!_isIntialized) {
      throw NotIntializedException();
    }
    final user = _user;
    if (user == null) {
      throw UserNotFoundAuthException();
    }
    const newUser =
        AuthUser(isEmailVerified: true, email: 'foo@bar.com', id: 'my_id');
    _user = newUser;
  }
}
