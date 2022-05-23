import 'package:flutter/material.dart';
import 'package:new_app/screens/register.dart';
import 'package:new_app/services/auth.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return SignIn(toggleView: toggleView);
    else {
      return Register(toggleView: toggleView);
    }
  }
}

class SignIn extends StatefulWidget {
  SignIn({Key? key, this.toggleView}) : super(key: key);

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late AuthService _auth;
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = ' ';
  String password = ' ';
  String error = '';
  bool loading = false;
  @override
  void initState() {
    _auth = context.read<AuthService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Scaffold(
            body: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '007App1',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          validator: (val) => val!.length < 6
                              ? 'Enter an a password 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white, // background
                            onPrimary: Colors.blue, // foreground
                          ),
                          child: Text('Log in anon',
                              style: TextStyle(color: Colors.blue)),
                          onPressed: () async {
                            dynamic result = await _auth.signInAnon();
                            if (result == null) {
                              print('error signing in');
                            } else {
                              print('signed in');
                              print(result.uid);
                            }
                          },
                        ),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: Text('Log in'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth
                                    .logInWithEmailAndPassword(email, password);
                                if (result == null) {
                                  loading = false;
                                  error =
                                      'could not log in with those credentials';
                                }
                              }
                            },
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text('Does not have account?'),
                          TextButton(
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              widget.toggleView!();
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  )),
            ),
          );
  }
}
