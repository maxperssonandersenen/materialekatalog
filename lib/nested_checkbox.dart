import 'package:flutter/material.dart';

class NestedCheckbox extends StatefulWidget {
  @override
  _NestedCheckboxState createState() => _NestedCheckboxState();
}

class _NestedCheckboxState extends State<NestedCheckbox> {
  bool _isChecked = false;

  final List<Map<String, dynamic>> _nestedItems = [
    {
      'title': 'Tag',
      'isChecked': false,
      'subItems': [
        {
          'title': 'Indertag',
          'isChecked': false,
          'subItems': [
            {'title': 'Tagpap', 'isChecked': false},
            {'title': 'Træskelet', 'isChecked': false},
          ]
        },
        {
          'title': 'Ydertag',
          'isChecked': false,
          'subItems': [
            {'title': 'Tagpap', 'isChecked': false},
            {'title': 'Tagsten', 'isChecked': false},
          ]
        },
        {
          'title': 'Isolering',
          'isChecked': false,
          'subItems': [
            {'title': 'Rockwool', 'isChecked': false},
            {'title': 'Skum', 'isChecked': false},
          ]
        },
      ],
    },
    {
      'title': 'Ydervægge',
      'isChecked': false,
      'subItems': [
        {
          'title': 'Bagmur',
          'isChecked': false,
          'subItems': [
            {'title': 'Træskelet', 'isChecked': false},
            {'title': 'Betonbagmur', 'isChecked': false},
            {'title': 'Aluminium skelet', 'isChecked': false},
            {'title': 'CLT', 'isChecked': false},
          ]
        },
        {'title': 'Isolering', 'isChecked': false},
        {'title': 'Klimaskærm', 'isChecked': false},
      ],
    },
    {
      'title': 'Indervægge',
      'isChecked': false,
      'subItems': [
        {'title': 'Bagmur', 'isChecked': false},
        {'title': 'Isolering', 'isChecked': false},
        {'title': 'Klimaskærm', 'isChecked': false},
      ],
    },
    {
      'title': 'Vinduer',
      'isChecked': false,
      'subItems': [
        {'title': 'Ramme', 'isChecked': false},
        {'title': 'Ruder', 'isChecked': false},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: _nestedItems.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return buildNestedCheckbox(_nestedItems[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildNestedCheckbox(Map<String, dynamic> item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          title: Text(item['title']),
          value: item['isChecked'],
          onChanged: (bool? value) {
            setState(() {
              item['isChecked'] = value!;
            });
          },
        ),
        if (item['subItems'] != null)
          Visibility(
            visible: item['isChecked'],
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: item['subItems']?.length,
              itemBuilder: (context, subIndex) {
                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: buildNestedCheckbox(item['subItems'][subIndex]),
                );
              },
            ),
          ),
      ],
    );
  }
}
