import 'package:crud_app/models/users/user.dart';
import 'package:crud_app/screens/users/user_manage.dart';
import 'package:crud_app/services/user_service.dart';
import 'package:crud_app/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  bool isLoading = true;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "CRUD App - Users List",
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchUsers,
          child: Visibility(
            visible: users.isNotEmpty,
            replacement: Center(
              child: Text(
                "No Users",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: users.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final user = users[index];
                final userId = user.id.toString();
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(user.login),
                    subtitle: Text(user.name),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        switch (value) {
                          case "edit":
                            navigateToUserManagePage(user);
                            break;
                          case "remove":
                            removeUser(userId);
                            break;
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: "edit",
                            child: Text("Edit"),
                          ),
                          const PopupMenuItem(
                            value: "remove",
                            child: Text("Remove"),
                          )
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToUserManagePage,
        label: const Text("Add User"),
      ),
    );
  }

  Future<void> navigateToUserManagePage([user]) async {
    final userManagePage = UserManagePage(user: user);
    final route = MaterialPageRoute(
      builder: (context) => userManagePage,
      settings: RouteSettings(
        name: "/${userManagePage.runtimeType.toString()}",
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchUsers();
  }

  Future<void> removeUser(String userId) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Warning"),
            content: const Text("Are you sure want to remove this user?"),
            actions: [
              TextButton(
                onPressed: () async {
                  final response = await UserService.delete(userId);
                  if (response.success) {
                    showSuccessMessage(response.message);
                    fetchUsers();
                  } else {
                    showErrorMessage(response.message);
                  }
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        });
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    final response = await UserService.getAll();

    if (response.success) {
      final usersList = response.data;
      setState(() {
        users = usersList?.where((user) => !user.superUser).toList() ?? [];
      });
    } else {
      showErrorMessage(response.message);
    }

    setState(() {
      isLoading = false;
    });
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
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
