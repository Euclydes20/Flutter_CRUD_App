import 'package:crud_app/auxiliary/constants.dart';
import 'package:crud_app/auxiliary/utilities.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:crud_app/screens/annotations/annotation_list.dart';
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
      "page": AnnotationListPage(),
      "name": "Annotations",
      "icon": Icons.note_alt,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!Session.isValid()) return true;

        await confirmLogout();
        return !Session.isValid();
      },
      child: MyScaffold(
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
                  color: Colors.green,
                ),
                child: ElevatedButton(
                  onPressed: () => navigateToPage(context, item["page"]),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.infinite,
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item["icon"]),
                      Text(
                        item["name"],
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> confirmLogout() async {
    await showDialog(
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
                removeKeyFromLocalStorage(Constants.storageSessionKey);
                Navigator.pop(context);
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
    return;
  }

  void navigateToPage(context, page) {
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
          r.settings.name == Constants.homePageRoute;
      return stopRemoving;
    });
  }
}
