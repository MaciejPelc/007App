import 'package:flutter/material.dart';
import 'package:new_app/services/auth.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register({Key? key, this.toggleView}) : super(key: key);

  final Function? toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late AuthService _auth;
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String password2 = '';
  String error = '';
  bool loading = false;
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _auth = context.read<AuthService>();
    return MaterialApp(
      home: loading
          ? CircularProgressIndicator()
          : Scaffold(
              body: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '007App2',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Register',
                              style: TextStyle(fontSize: 20),
                            )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
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
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                password2 = val;
                              });
                            },
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Repeat password',
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
                            child: Text('anon',
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print('error register');
                              } else {
                                print('Registered');
                                print(result.uid);
                              }
                            },
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                                child: Text('Register'),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, email, password);
                                    if (result == null) {
                                      loading = false;
                                      error =
                                          'please supply a valid email or/and password ';
                                    }
                                  }
                                })),
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
                            Text('Allready have account?'),
                            TextButton(
                              child: Text(
                                'Log in',
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
                    ),
                  )),
            ),
    );
  }
}
