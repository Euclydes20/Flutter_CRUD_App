import 'package:crud_app/screens/home.dart';
import 'package:crud_app/screens/users/user_list.dart';
import 'package:crud_app/screens/users/user_manage.dart';
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
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.exit_to_app),
                ),
              ]
            : [],
      ),
      body: body,
      drawer: showDrawer
          ? Drawer(
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
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => navigateToPage(context, const HomePage()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.supervised_user_circle),
                    title: const Text('Users'),
                    onTap: () => navigateToPage(context, const UserListPage()),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButton: floatingActionButton,
    );
  }

  void navigateToPage(context, page) {
    final route = MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(
        name: "/${page.runtimeType.toString()}",
      ),
    );
    Navigator.push(context, route);

    //var teste = ModalRoute.of(context)!.settings.name;
    //if (route.isCurrent) return;
    //Navigator.of(context).pushNamed("/${page.runtimeType.toString()}");

    /*Navigator.pushAndRemoveUntil(context, route, (r) {
      bool teste = r.settings.name == "/" ||
          r.settings.name == "/${const HomePage().runtimeType.toString()}" ||
          r.settings.name == "/${page.runtimeType.toString()}";
      print(r.settings.name);
      print(teste);
      return teste;
    });*/
  }
}
