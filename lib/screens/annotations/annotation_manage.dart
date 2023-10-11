import 'package:crud_app/models/annotations/annotation.dart';
import 'package:crud_app/services/annotations/annotation_service.dart';
import 'package:crud_app/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class AnnotationManagePage extends StatefulWidget {
  final Annotation? annotation;
  const AnnotationManagePage({super.key, this.annotation});

  @override
  State<AnnotationManagePage> createState() => _AnnotationManagePageState();
}

class _AnnotationManagePageState extends State<AnnotationManagePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  bool isLoading = false;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final annotation = widget.annotation;
    if (widget.annotation != null) {
      isEdit = true;
      titleController.text = annotation?.title ?? "";
      textController.text = annotation?.text ?? "";
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showDrawer: false,
      title:
          isEdit ? "CRUD App - Edit Annotation" : "CRUD App - Add Annotation",
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            enabled: !isLoading,
            controller: titleController,
            decoration: const InputDecoration(hintText: "Title"),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            enabled: !isLoading,
            controller: textController,
            decoration: const InputDecoration(hintText: "Text"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: isLoading ? null : saveData,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            label: Text(isEdit ? "Edit" : "Add"),
            icon: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )
                : const Icon(Icons.save),
          ),
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

    final title = titleController.text;
    final text = textController.text;

    final body = {
      "Id": 0,
      "Title": title,
      "Text": text,
    };

    if (isEdit) {
      if (widget.annotation?.id != null) {
        body["Id"] = widget.annotation?.id ?? 0;
      } else {
        showErrorMessage("Inválid Annotation");
        return;
      }
    }

    final response = isEdit
        ? await AnnotationService.update(body)
        : await AnnotationService.add(body);

    if (response.success) {
      if (!isEdit) {
        titleController.text = "";
        textController.text = "";
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
