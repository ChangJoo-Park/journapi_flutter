import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bullet extends StatefulWidget {
  const Bullet({
    Key key,
    @required this.bullet,
    @required this.onSaveClicked,
    @required this.onDeleteClicked,
  }) : super(key: key);

  final Map bullet;
  final Function(int bulletId, String bullet, DateTime dateTime) onSaveClicked;
  final Function(int bulletId) onDeleteClicked;

  @override
  _BulletState createState() => _BulletState();
}

class _BulletState extends State<Bullet> {
  final buttonColor = const Color(0xff4a5568);
  var timeString = '';
  var isEdit = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController bulletEditingController;
  DateTime selectedDate;
  @override
  void initState() {
    bulletEditingController =
        TextEditingController(text: widget.bullet['bullet']);
    selectedDate = DateTime.parse(widget.bullet['published_at']).toLocal();
    String hour = selectedDate.hour.toString().length == 1
        ? '0${selectedDate.hour}'
        : '${selectedDate.hour}';
    String minute = selectedDate.minute.toString().length == 1
        ? '0${selectedDate.minute}'
        : '${selectedDate.minute}';
    String second = selectedDate.second.toString().length == 1
        ? '0${selectedDate.second}'
        : '${selectedDate.second}';
    timeString = '$hour:$minute:$second';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (isEdit) {
      children.addAll([
        Form(
          key: formKey,
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: bulletEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'The bullet edit field is required';
                    }
                    return null;
                  },
                  style: TextStyle(fontFamily: 'JetBrainsMono'),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  minLines: 2,
                  maxLines: 10,
                ),
                SizedBox(height: 8),
                DateTimeField(
                  dateTextStyle: TextStyle(fontFamily: 'JetBrainsMono'),
                  initialDatePickerMode: DatePickerMode.day,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  selectedDate: selectedDate,
                  onDateSelected: (DateTime value) {
                    setState(() => selectedDate = value);
                  },
                ),
              ],
            ),
          ),
        ),
        ButtonBar(
          key: ValueKey("${widget.bullet['id']}_button_bar_edit"),
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  widget.onSaveClicked(widget.bullet['id'],
                      bulletEditingController.text, selectedDate.toLocal());
                  setState(() {
                    isEdit = false;
                  });
                }
              },
              icon: SvgPicture.asset('assets/images/save.svg',
                  width: 20, height: 20),
              label: Text(
                'Save',
                style:
                    TextStyle(fontFamily: 'JetBrainsMono', color: buttonColor),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() => isEdit = false);
              },
              icon: SvgPicture.asset('assets/images/cancel.svg',
                  width: 20, height: 20),
              label: Text(
                'Cancel',
                style:
                    TextStyle(fontFamily: 'JetBrainsMono', color: buttonColor),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/time.svg',
                  width: 20, height: 20),
              label: Text(
                timeString,
                style:
                    TextStyle(fontFamily: 'JetBrainsMono', color: buttonColor),
              ),
            ),
          ],
        ),
      ]);
    } else {
      children.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Text(
            widget.bullet['bullet'].replaceAll("\n", " "),
            style: TextStyle(fontFamily: 'JetBrainsMono', fontSize: 16),
          ),
        ),
        ButtonBar(
          key: ValueKey("${widget.bullet['id']}_button_bar_view"),
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isEdit = true;
                });
              },
              icon: SvgPicture.asset('assets/images/edit.svg',
                  width: 20, height: 20),
              label: Text(
                'Edit',
                style:
                    TextStyle(fontFamily: 'JetBrainsMono', color: buttonColor),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                widget.onDeleteClicked(widget.bullet['id']);
              },
              icon: SvgPicture.asset('assets/images/delete.svg',
                  width: 20, height: 20),
              label: Text(
                'Delete',
                style:
                    TextStyle(fontFamily: 'JetBrainsMono', color: buttonColor),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/time.svg',
                  width: 20, height: 20),
              label: Text(
                timeString,
                style:
                    TextStyle(fontFamily: 'JetBrainsMono', color: buttonColor),
              ),
            ),
          ],
        ),
      ]);
    }

    children.add(Divider(height: 6, color: Color(0xffcbd5e0), thickness: 4));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
