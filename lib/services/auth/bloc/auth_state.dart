import 'package:codecampapp/services/auth/auth_user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;

  const AuthStateLoggedIn(this.user);
}

class AuthStateLoginFailue extends AuthState {
  final Exception exception;
  const AuthStateLoginFailue(this.exception);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

class AuthStateLogoutFailue extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailue(this.exception);
}
