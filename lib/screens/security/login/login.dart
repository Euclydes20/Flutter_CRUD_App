import 'package:crud_app/auxiliary/utilities.dart';
import 'package:crud_app/models/configurations/configuration.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:crud_app/models/users/user.dart';
import 'package:crud_app/screens/home.dart';
import 'package:crud_app/screens/users/user_list.dart';
import 'package:crud_app/services/configurations/configuration_service.dart';
import 'package:crud_app/services/security/login_service.dart';
import 'package:crud_app/services/users/user_service.dart';
import 'package:crud_app/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isValidLogin = true;
  bool isValidPassword = true;
  bool isValidAccess = false;

  @override
  void initState() {
    super.initState();
    loadServerUrl();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD App - Login Page"),
        bottom: AppBar(
          title: const Text(
            "Em Desenvolvimento por Euclydes",
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.network(
                "https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png",
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                enabled: !isLoading,
                controller: loginController,
                decoration: InputDecoration(
                  hintText: "Login",
                  border: const OutlineInputBorder(),
                  labelText: "Login",
                  errorText: !isValidLogin ? "Login is required" : null,
                ),
                onChanged: (value) {
                  setState(() {
                    isValidLogin = loginController.text.isNotEmpty;
                    isValidAccess =
                        isValidLogin && passwordController.text.isNotEmpty;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                enabled: !isLoading,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  errorText: !isValidPassword ? "Password is required" : null,
                ),
                onChanged: (value) {
                  setState(() {
                    isValidPassword = passwordController.text.isNotEmpty;
                    isValidAccess =
                        isValidPassword && loginController.text.isNotEmpty;
                  });
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              ElevatedButton(
                onPressed: isLoading ? null : showInDevelopmentDialog,
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent,
                ),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      isLoading || !isValidAccess ? null : authenticateUser,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  label: const Text(
                    "Access",
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : const Icon(Icons.login),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Does not have account?"),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : showNewAccountModal, //showInDevelopmentDialog,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNewAccountModal() {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxHeight: 500),
      context: context,
      builder: (BuildContext modalContext) {
        TextEditingController modalNameController = TextEditingController();
        TextEditingController modalLoginController = TextEditingController();
        TextEditingController modalPasswordController = TextEditingController();
        TextEditingController modalBibliographyController =
            TextEditingController();
        bool isModalLoading = false;
        return StatefulBuilder(
          builder: (BuildContext modalStateContext, StateSetter setModalState) {
            return WillPopScope(
              onWillPop: () async {
                return !isModalLoading;
              },
              child: MyScaffold(
                showDrawer: false,
                showBackButton: !isModalLoading,
                showExitButton: false,
                title: "Register New Account",
                body: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    TextField(
                      enabled: !isModalLoading,
                      controller: modalNameController,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: !isModalLoading,
                      controller: modalLoginController,
                      decoration: const InputDecoration(hintText: "Login"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: !isModalLoading,
                      controller: modalPasswordController,
                      decoration: const InputDecoration(hintText: "Password"),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: !isModalLoading,
                      controller: modalBibliographyController,
                      decoration:
                          const InputDecoration(hintText: "Bibliography"),
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 8,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: !isModalLoading
                          ? () async {
                              var user = {
                                "name": modalNameController.text,
                                "login": modalLoginController.text,
                                "password": modalPasswordController.text,
                                "bibliography": modalBibliographyController.text
                              };
                              setModalState(() {
                                isModalLoading = true;
                              });
                              await registerNewAccount(user, modalStateContext);
                              setModalState(() {
                                isModalLoading = false;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                      ),
                      label: const Text("Register"),
                      icon: isModalLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            )
                          : const Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> registerNewAccount(user, modalStateContext) async {
    final response = await UserService.add(user);

    if (response.success) {
      showSuccessMessage(response.message, customContext: modalStateContext);
      loginController.text = "";
      passwordController.text = "";
      Navigator.pop(context);
    } else {
      showErrorMessage(response.message, customContext: modalStateContext);
    }
  }

  Future<void> authenticateUser() async {
    setState(() {
      isLoading = true;
    });

    final login = loginController.text;
    final password = passwordController.text;

    final body = {
      "Login": login,
      "Password": password,
      "EncryptedPassword": false,
    };

    final response = await LoginService.authenticate(body);

    if (response.success) {
      if (Session.isValid()) {
        loginController.text = "";
        passwordController.text = "";
        showSuccessMessage(response.message);
        navigateToHomePage();
      } else {
        showErrorMessage("Invalid session.");
      }
    } else {
      showErrorMessage(response.message);
    }

    setState(() {
      isLoading = false;
    });
  }

  void navigateToHomePage() {
    final route = MaterialPageRoute(
      builder: (context) => const HomePage(),
      settings: RouteSettings(
        name: "/${const HomePage().runtimeType.toString()}",
      ),
    );
    Navigator.push(context, route).then((value) {
      setState(() {
        isLoading = false;
        isValidLogin = true;
        isValidPassword = true;
        isValidAccess = false;
      });
      Session.destroySession();
    });
    /*Navigator.pushAndRemoveUntil(context, route, (r) {
      bool teste = r.settings.name == "/" ||
          r.settings.name == "/${const UserListPage().runtimeType.toString()}";
      print(r.settings.name);
      print(teste);
      return teste;
    }).then((value) => Session.destroySession());*/
  }

  void showSuccessMessage(String message, {BuildContext? customContext}) {
    ScaffoldMessenger.of(customContext ?? context).clearSnackBars();
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(customContext ?? context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message, {BuildContext? customContext}) {
    ScaffoldMessenger.of(customContext ?? context).clearSnackBars();
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(customContext ?? context).showSnackBar(snackBar);
  }

  void showInDevelopmentDialog() {
    showInformationDialog(
      context,
      title: "Information",
      text: "In development.",
      confirmText: "Ok",
      onConfirmPress: () => Navigator.pop(context),
    );
  }

  Future<void> loadServerUrl() async {
    setState(() {
      isLoading = true;
    });

    final response = await ConfigurationService.getBaseUrl();

    if (response.success) {
      Configuration.baseUrl = response.data!;
      if (!Session.isValid()) {
        Session.destroySession();
      } else {
        navigateToHomePage();
      }
      setState(() {
        isLoading = false;
      });
    } else {
      showFailGetServerUrlDialog();
    }
  }

  Future<void> showFailGetServerUrlDialog() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Error"),
                ),
              ],
            ),
            content:
                const Text("Failed to acquire API URL.\n\nPress Ok to retry."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  loadServerUrl();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }
}
