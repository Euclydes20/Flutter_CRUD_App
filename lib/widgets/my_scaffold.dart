import 'package:crud_app/auxiliary/constants.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:crud_app/screens/annotations/annotation_list.dart';
import 'package:crud_app/screens/home.dart';
import 'package:crud_app/screens/users/user_list.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool showExitButton;
  final bool showDrawer;

  const MyScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
    this.showExitButton = true,
    this.showDrawer = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: showExitButton
            ? [
                ElevatedButton(
                  onPressed: () => confirmLogout(context),
                  child: const Icon(Icons.exit_to_app),
                ),
              ]
            : [],
      ),
      body: body,
      backgroundColor: Colors.blueGrey,
      drawer: showDrawer
          ? Drawer(
              backgroundColor: Colors.blueGrey[200],
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.view_module),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Modules",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      size: 24,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => navigateToPage(context, const HomePage()),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.supervised_user_circle,
                      size: 24,
                    ),
                    title: const Text(
                      'Users',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () => navigateToPage(context, const UserListPage()),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.note_alt,
                      size: 24,
                    ),
                    title: const Text(
                      'Users',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onTap: () =>
                        navigateToPage(context, const AnnotationListPage()),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButton: floatingActionButton,
    );
  }

  void confirmLogout(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Warning"),
          content: const Text("Are you sure want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                /*final response = await AnnotationService.delete(annotationId);
                if (response.success) {
                  showSuccessMessage(response.message);
                  fetchAnnotations();
                } else {
                  showErrorMessage(response.message);
                }*/
                Session.destroySession();
                Navigator.pop(context);
                Navigator.popUntil(context, (r) {
                  bool stopRemoving = r.settings.name == "/" ||
                      r.settings.name == "" ||
                      r.settings.name == null;
                  return stopRemoving;
                });
              },
              child: const Text("Logout"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void navigateToPage(context, page) {
    Navigator.pop(context);

    final pageName = "/${page.runtimeType.toString()}";
    if (pageName == ModalRoute.of(context)!.settings.name) return;

    final route = MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(
        name: pageName,
      ),
    );
    //Navigator.push(context, route);

    Navigator.pushAndRemoveUntil(context, route, (r) {
      bool stopRemoving = r.settings.name == "/" ||
          r.settings.name == "" ||
          r.settings.name == null ||
          (pageName != Constants.homePageRoute &&
              r.settings.name == Constants.homePageRoute);
      return stopRemoving;
    });
  }
}
