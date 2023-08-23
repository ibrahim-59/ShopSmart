import 'package:e_commerce/const/my_validators.dart';
import 'package:e_commerce/screens/root_screen.dart';
import 'package:e_commerce/services/my_app_methods.dart';
import 'package:e_commerce/widgets/app_name_widget.dart';
import 'package:e_commerce/widgets/auth/Image_picker_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/SignupScreen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  late final TextEditingController _repeatPassController;
  late final TextEditingController _nameController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _nameFocusNode;
  late final FocusNode _passFocusNode;
  late final FocusNode _rPassFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool _isShown = true;
  bool isLoading = false;
  XFile? _pickedImage;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _repeatPassController = TextEditingController();
    _nameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _passFocusNode = FocusNode();
    _rPassFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _rPassFocusNode.dispose();
    _repeatPassController.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  Future<void> SignUp() async {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // if (_pickedImage == null) {
      //   MyAppMethods.showErrorOrWaringDialog(
      //     context: context,
      //     subTitle: "Make sure to pick up an image",
      //     ftc: () {},
      //   );
      // }
      try {
        setState(() {
          isLoading = true;
        });
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "An Account Has Been Created",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseAuthException catch (error) {
        MyAppMethods.showErrorOrWaringDialog(
          context: context,
          subTitle: "An erroe Occured ${error.message}",
          ftc: () {},
        );
      } catch (error) {
        MyAppMethods.showErrorOrWaringDialog(
          context: context,
          subTitle: "An erroe Occured ${error}",
          ftc: () {},
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFct: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      gallaryFct: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFct: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const AppNameWidget(
                  fontSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: TitleWidget(title: 'Welcome ')),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: SubTitlewidget(title: 'Sign up Now')),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  child: ImagePickerWidget(
                    ftc: () async {
                      await localImagePicker();
                    },
                    PickedImage: _pickedImage,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            hintText: 'Name',
                            prefixIcon: Icon(IconlyLight.user)),
                        validator: (value) {
                          return MyValidators.displayNamevalidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(IconlyLight.message)),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_passFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passController,
                        focusNode: _passFocusNode,
                        obscureText: _isShown,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isShown = !_isShown;
                              });
                            },
                            icon: Icon(
                              _isShown
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_rPassFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _repeatPassController,
                        focusNode: _rPassFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Repeat Password',
                          prefixIcon: const Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isShown = !_isShown;
                              });
                            },
                            icon: Icon(
                              _isShown
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.repeatPasswordValidator(
                            value: value,
                            password: _passController.text,
                          );
                        },
                        onFieldSubmitted: (value) {
                          SignUp();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () async {
                              SignUp();
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
