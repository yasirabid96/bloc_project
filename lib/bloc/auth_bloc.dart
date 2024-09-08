import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }
  

}

void _onAuthLogoutRequested(
    AuthLogoutRequested event, Emitter<AuthState> emit) async {
  emit(AuthLoading());

  try {
    await Future.delayed(const Duration(seconds: 1), () {
      emit(AuthInitial());
    });
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}

void _onAuthLoginRequested(
    AuthLoginRequested event, Emitter<AuthState> emit) async {
  final email = event.email;
  final password = event.password;

  // Emmitting to loading state before success or failure
  emit(AuthLoading());
  try {
    if (password.length < 6) {
      emit(const AuthFailure("Password cannot be less than 6 characters"));
      return; // return is needed because emit does not return anything
    }
    await Future.delayed(const Duration(seconds: 1), () {
      emit(AuthSuccess(uid: '$email-$password'));
      return;
    });
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}
