import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen ({super.key});
  @override
  State<RegisterScreen> createState()=> _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  final _nameController= TextEditingController();
  final _emailController= TextEditingController();
  final _passController= TextEditingController();
  bool _obscure=true;

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _register(){
    final auth=AuthService.instance;

    final name= _nameController.text.trim();
    final email=_emailController.text.trim();

    if(name.isEmpty || email.isEmpty || _passController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    auth.loginAsUser(
      name:_nameController.text.trim(),
      email:_emailController.text.trim(),
    );

    //zatvori register, zatvori login
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget build(BuildContext context){ 
    final colors=Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 0,
        title: const Text('Sign up'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                children: [
                  Icon(Icons.eco_outlined, size: 64, color: colors.onPrimary),
                  const SizedBox(height: 12),
                  Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Full name',
                            prefixIcon: Icon(Icons.badge_outlined),
                          ),
                        ),
                        const SizedBox(height:12),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration (
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _passController,
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_)=>_register(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: ()=> setState(()=>_obscure=!_obscure),
                              icon: Icon(_obscure?Icons.visibility: Icons.visibility_off),
                            ),
                          ),
                        ),

                        const SizedBox(height:18),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _register,
                            child: const Text('Create account') ,
                            ),
                        ),

                        const SizedBox(height: 10),
                        Text(
                          'Nemam bekend jos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize:12,color: colors.onSurfaceVariant),
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