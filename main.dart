import 'dart:js';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login and Register Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}


class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  void _login(String email, String password) {
    if (email == 'example@example.com' && password == 'password') {
      print('Login successful');
      Provider.of<LoginData>(context as BuildContext, listen: false).email = email;
      Provider.of<LoginData>(context as BuildContext, listen: false).password = password;
    } else {
      print('Invalid email or password');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      _isPasswordVisible = !_isPasswordVisible;
                      _passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _passwordController.text.length),
                      );
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  if (value.contains(' ')) {
                    return 'Password cannot contain empty spaces';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login(_emailController.text, _passwordController.text);
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();
  bool _isPasswordVisible = false;

  void register(String name, String email, String password, String dob) {
    print('Name: $name');
    print('Email: $email');
    print('Password: $password');
    print('Date of Birth: $dob');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      _isPasswordVisible = !_isPasswordVisible;
                      _passwordController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _passwordController.text.length),
                      );
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  if (value.contains(' ')) {
                    return 'Password cannot contain empty spaces';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    _dobController.text = selectedDate.toString();
                  }
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String dob = _dobController.text;
                    Provider.of<RegistrationData>(context, listen: false).name = name;
                    Provider.of<RegistrationData>(context, listen: false).email = email;
                    Provider.of<RegistrationData>(context, listen: false).password = password;
                    Provider.of<RegistrationData>(context, listen: false).dob = dob;
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationData with ChangeNotifier {
  String name;
  String email;
  String password;
  String dob;

  RegistrationData({this.name = '', this.email = '', this.password = '', this.dob = ''});
}
    // Add your regex validation for email here

class LoginData with ChangeNotifier {
  String email;
  String password;

  LoginData({this.email = '', this.password = ''});
}


