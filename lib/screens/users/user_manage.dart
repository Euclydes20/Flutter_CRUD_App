import 'package:crud_app/models/users/user.dart';
import 'package:crud_app/services/user_service.dart';
import 'package:crud_app/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class UserManagePage extends StatefulWidget {
  final User? user;
  const UserManagePage({super.key, this.user});

  @override
  State<UserManagePage> createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bibliographyController = TextEditingController();
  bool isLoading = false;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    if (widget.user != null) {
      isEdit = true;
      nameController.text = user?.name ?? "";
      loginController.text = user?.login ?? "";
      passwordController.text = user?.password ?? "";
      bibliographyController.text = user?.bibliography ?? "";
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    loginController.dispose();
    passwordController.dispose();
    bibliographyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showDrawer: false,
      title: isEdit ? "CRUD App - Edit User" : "CRUD App - Add User",
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            enabled: !isLoading,
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            enabled: !isLoading,
            controller: loginController,
            decoration: const InputDecoration(hintText: "Login"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            enabled: !isLoading,
            controller: passwordController,
            decoration: const InputDecoration(hintText: "Password"),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            enabled: !isLoading,
            controller: bibliographyController,
            decoration: const InputDecoration(hintText: "Bibliography"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: isLoading ? null : saveData,
              style:
                  ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
              label: Text(isEdit ? "Edit" : "Add"),
              icon: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : const Icon(Icons.save)),
          /*ElevatedButton(
            onPressed: saveData,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(isEdit ? "Edit" : "Add")),
          ),*/
        ],
      ),
    );
  }

  Future<void> saveData() async {
    setState(() {
      isLoading = true;
    });

    final name = nameController.text;
    final login = loginController.text;
    final password = passwordController.text;
    final bibliography = bibliographyController.text;

    final body = {
      "Id": 0,
      "Name": name,
      "Login": login,
      "Password": password,
      "Bibliography": bibliography,
    };

    if (isEdit) {
      if (widget.user?.id != null) {
        body["Id"] = widget.user?.id ?? 0;
      } else {
        showErrorMessage("Inválid user");
        return;
      }
    }

    final response =
        isEdit ? await UserService.update(body) : await UserService.add(body);

    if (response.success) {
      if (!isEdit) {
        nameController.text = "";
        loginController.text = "";
        passwordController.text = "";
        bibliographyController.text = "";
      }
      showSuccessMessage(response.message);
    } else {
      showErrorMessage(response.message);
    }

    setState(() {
      isLoading = false;
    });
  }

  void showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
