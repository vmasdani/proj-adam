import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:schoolinventory/helpers.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemAddPage extends StatefulWidget {
  const ItemAddPage({super.key, this.onSave, this.id});

  final Function? onSave;
  final dynamic? id;

  @override
  State<ItemAddPage> createState() => _ItemAddPageState();
}

class _ItemAddPageState extends State<ItemAddPage> {
  var _nameController = TextEditingController();
  var _descriptionController = TextEditingController();

  dynamic _item = {};
  Image? _fileImg = null;
  String? _imgString = null;
  final _picker = ImagePicker();

  @override
  void initState() {
    fetchItemData();
    super.initState();
  }

  Future fetchItemData() async {
    if (widget.id != null) {
      final d = await fetchItem(widget.id);

      setState(() {
        _item = d;
        _nameController.text = d?['name'];
        _descriptionController.text = d?['description'];
      });
    }
  }

  Future handleSave() async {
    try {
      if (_imgString != null) {
        _item['image'] = _imgString;
      }

      await http.post(
        Uri.parse('${dotenv.get('BASE_URL')}/api/items'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(_item),
      );
    } catch (e) {
      print(e);
    }

    Navigator.pop(context);
    widget?.onSave?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item ${widget.id}'),
        actions: [
          Container(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                handleSave();
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Text('Name'),
              ),
              TextField(
                controller: _nameController,
                onChanged: (v) {
                  _item['name'] = v;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              Container(
                child: Text('Description'),
              ),
              TextField(
                controller: _descriptionController,
                onChanged: (v) {
                  _item['description'] = v;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
              Container(
                child: Text('Photo'),
              ),
              Container(
                child: ElevatedButton(
                  child: Icon(Icons.photo_camera),
                  onPressed: () async {
                    try {
                      final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                        // maxWidth: maxWidth,
                        // maxHeight: maxHeight,
                        // imageQuality: quality,
                      );

                      Image? img;
                      String? imgString;

                      if (kIsWeb) {
                        final d = await pickedFile?.readAsBytes();
                        if (d != null) {
                          img = Image.memory(d);
                          imgString = base64Encode(d);
                        }
                      } else {
                        final file = File(pickedFile?.path ?? '');
                        img = Image.file(file);
                        imgString = base64Encode(file.readAsBytesSync());
                      }

                      if (img != null) {
                        setState(() {
                          _fileImg = img;
                          // _imgString=imgString;
                        });
                      }

                      if (imgString != null) {
                        setState(() {
                          // _fileImg = img;
                          _imgString = imgString ?? '';
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              ...(_fileImg != null
                  ? [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: _fileImg,
                      ),
                    ]
                  : []),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                // child: FractionallySizedBox(
                //   heightFactor: 0.4,
                child: FadeInImage(
                  image: NetworkImage(
                      "${dotenv.get("BASE_URL")}/api/items/${widget.id}/photo?ts=${DateTime.now().millisecondsSinceEpoch}"),
                  placeholder: MemoryImage(kTransparentImage),
                ),
              ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
