import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String userName;

  LoggedIn({required this.token, required this.userName});

  @override
  List<Object> get props => [token, userName];
}

class LoggedOut extends AuthenticationEvent {}
