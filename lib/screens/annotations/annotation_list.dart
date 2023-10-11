import 'package:crud_app/models/annotations/annotation.dart';
import 'package:crud_app/models/security/session.dart';
import 'package:crud_app/screens/annotations/annotation_manage.dart';
import 'package:crud_app/services/annotations/annotation_service.dart';
import 'package:crud_app/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class AnnotationListPage extends StatefulWidget {
  const AnnotationListPage({super.key});

  @override
  State<AnnotationListPage> createState() => _AnnotationListPageState();
}

class _AnnotationListPageState extends State<AnnotationListPage> {
  bool isLoading = true;
  List<Annotation> annotations = [];

  @override
  void initState() {
    super.initState();
    fetchAnnotations();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "CRUD App - Annotations List",
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchAnnotations,
          child: Visibility(
            visible: annotations.isNotEmpty,
            replacement: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "No Annotations",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ],
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: annotations.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final annotation = annotations[index];
                final annotationId = annotation.id.toString();
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text("${index + 1}")),
                    title: Text(annotation.title),
                    subtitle: Text(annotation.text),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        switch (value) {
                          case "edit":
                            navigateToAnnotationManagePage(annotation);
                            break;
                          case "remove":
                            removeAnnotation(annotationId);
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
        onPressed: navigateToAnnotationManagePage,
        label: const Text("Add Annotation"),
      ),
    );
  }

  Future<void> navigateToAnnotationManagePage([annotation]) async {
    final annotationManagePage = AnnotationManagePage(annotation: annotation);
    final route = MaterialPageRoute(
      builder: (context) => annotationManagePage,
      settings: RouteSettings(
        name: "/${annotationManagePage.runtimeType.toString()}",
      ),
    );
    final reloadAnnotations = await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    if (Session.isValid()) fetchAnnotations();
  }

  Future<void> removeAnnotation(annotationId) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Warning"),
            content: const Text("Are you sure want to remove this annotation?"),
            actions: [
              TextButton(
                onPressed: () async {
                  final response = await AnnotationService.delete(annotationId);
                  if (response.success) {
                    showSuccessMessage(response.message);
                    fetchAnnotations();
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

  Future<void> fetchAnnotations() async {
    setState(() {
      isLoading = true;
    });

    final response = await AnnotationService.getAll();

    if (response.success) {
      final annotationsList = response.data;
      setState(() {
        annotations = annotationsList!;
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
