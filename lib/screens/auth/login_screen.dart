import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState()=> _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  final _emailController= TextEditingController();
  final _passController= TextEditingController();
  bool _obscure=true;


@override
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _login(){
    final auth= AuthService.instance;
    final email=_emailController.text.trim().toLowerCase();

    if(email.isEmpty || _passController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    if(email.contains('admin')){
      auth.loginAsAdmin();
    }else {
      auth.loginAsUser();
    }

    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    //final auth = AuthService.instance;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Icon(Icons.eco_outlined, size: 72, color: colors.onPrimary),
                  const SizedBox(height: 12),
                  Text(
                    'GroceryShop',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: colors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Fresh • Simple • Green',
                    style: TextStyle(color: colors.onPrimary.withOpacity(0.85)),
                  ),
                  const SizedBox(height: 22),

                  //forma
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                    const SizedBox(height: 12),
                        TextField(
                          controller: _passController,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscure = !_obscure),
                              icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                         SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _login,
                            child: const Text('Log in'),
                          ),
                        ),
                       const SizedBox(height: 10),
                        TextButton(
                          onPressed: () => Navigator.push(context, 
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          ),
                          child: const Text('Create account'),
                        ),

                        const SizedBox(height: 4),
                        Text(
                          'Demo: use email containing "admin" for admin role.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}