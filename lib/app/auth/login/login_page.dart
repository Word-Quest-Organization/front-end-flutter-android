import 'package:english_app/features/auth/presentation/viewmodel/auth_Viewmodel.dart';
import 'package:english_app/injector.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthViewModel viewModel;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    viewModel = getIt<AuthViewModel>();

    viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onViewModelChanged);

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onViewModelChanged() {
    if (viewModel.user != null) {
      Routefly.navigate('/home');
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _navigateToRegister() {
    Routefly.push('/auth/register');
  }

  void _performLogin() {
    viewModel.doLogin(_emailController.text, _passwordController.text);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login MVVM')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Campos de Texto ---
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 32),

            // --- Feedback de Erro ---
            // 7. Mostra o erro, se existir
            if (viewModel.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  viewModel.errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

            // --- Botão de Login e Loading ---
            // 8. Mostra o loading OU o botão
            if (viewModel.isLoading)
              Center(child: CircularProgressIndicator())
            else
              ElevatedButton(
                onPressed: _performLogin,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Entrar', style: TextStyle(fontSize: 18)),
                ),
              ),

            TextButton(onPressed: _navigateToRegister, child: Text('Não tem uma conta? Cadastre-se'))
          ],
        ),
      ),
    );
  }
}
