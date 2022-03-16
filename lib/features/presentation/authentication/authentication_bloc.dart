import 'package:bloc/bloc.dart';
import 'package:clean_demo/features/data/datasource/local_datasource.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LocalDataSource _localDataSource;

  AuthenticationBloc({required LocalDataSource localDataSource})
      : _localDataSource = localDataSource,
        super(Uninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // app start
    if (event is AppStarted) {
      var token = await _getToken();
      if (token != '') {
        // Storage().token = token;
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      // Storage().token = event.token;
      await _saveToken(event.token);
      yield Authenticated();
    }

    if (event is LoggedOut) {
      // Storage().token = '';
      await _deleteToken();
      yield Unauthenticated();
    }
  }

  /// delete Auth Token
  Future<void> _deleteToken() async {}

  /// Save Auth Token
  Future<void> _saveToken(String token) async {}

  /// Read Auth Token
  Future<String?> _getToken() async {
    return null;
  }
}
