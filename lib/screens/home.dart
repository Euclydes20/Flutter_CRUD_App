import 'package:crud_app/screens/users/user_list.dart';
import 'package:crud_app/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> items = const [
    {
      "page": UserListPage(),
      "name": "Users",
      "icon": Icons.supervised_user_circle
    },
    {
      "page": UserListPage(),
      "name": "Users",
      "icon": Icons.supervised_user_circle
    }
  ];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "CRUD App - Home Page",
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(width: 2),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(45),
                  ),
                  color: Colors.green),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () => navigateToPage(context, item["page"]),
                  icon: Icon(item["icon"]),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.infinite,
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                  label: Text(
                    item["name"],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
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
          r.isCurrent ||
          r.settings.name != "/${runtimeType.toString()}" ||
          r.settings.name == "/${page.runtimeType.toString()}";
      print(r.settings.name);
      print(teste);
      return teste;
    });*/
  }
}
