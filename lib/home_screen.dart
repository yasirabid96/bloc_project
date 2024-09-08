import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_responsive_login_ui/bloc/auth_bloc.dart';
import 'package:flutter_responsive_login_ui/login_screen.dart';
import 'package:flutter_responsive_login_ui/widgets/gradient_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
     
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
     
        if(state is !AuthSuccess){
          return const Scaffold();
        }
        // final authState = context.watch<AuthBloc>().state as AuthSuccess;
        // the problem with context watch it will rebuild the whole widget tree
        return Scaffold(
            body: Column(
          children: [
            Center(child: Text((state as AuthSuccess).uid)),
            GradientButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
                // or context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            ),
          ],
        ));
      },
    );
  }
}
