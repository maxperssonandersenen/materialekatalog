import 'package:flutter/material.dart';
import 'package:materialekatalog/construction.dart';
import 'package:materialekatalog/dropdown_chip.dart';
import 'package:materialekatalog/filter_tag.dart';
import 'package:materialekatalog/nested_checkbox.dart';
import 'package:materialekatalog/slider_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.white,
            showDragHandle: true,
          ),
          sliderTheme: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
          )),
      home: const FilterGridScreen(),
    );
  }
}

class FilterGridScreen extends StatefulWidget {
  const FilterGridScreen({super.key});

  @override
  _FilterGridScreenState createState() => _FilterGridScreenState();
}

class _FilterGridScreenState extends State<FilterGridScreen> {
  final List<String> _items = List.generate(100, (index) => 'Item $index');
  String _filter = '';
  final Map<String, OverlayPortalController> _overlayPortalControllers = {};
  final Set<FilterTag> _selectedFilters = {};
  final Map<String, String> _values = {};
  late final Set<FilterTag> _filters;
  final Set<BuildingStructure> _savedStructures = {};
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _filters = {
      FilterTag(name: 'Konstruktion', isSelected: false, icon: Icons.house, menu: NestedCheckbox()),
      FilterTag(name: 'Materialer', isSelected: false, icon: Icons.forest, menu: NestedCheckbox()),
      FilterTag(name: 'Egenskaber', isSelected: false, icon: Icons.construction, menu: NestedCheckbox()),
      FilterTag(
          name: 'CO2',
          isSelected: false,
          icon: Icons.co2,
          menu: SliderWidget(
            title: 'CO2',
            unit: 'kg',
            onChanged: (p0) => {
              setState(() {
                _values['CO2'] = p0;
              })
            },
          )),
      FilterTag(
          name: 'Pris',
          isSelected: false,
          icon: Icons.money,
          menu: SliderWidget(
            title: 'Pris',
            unit: 'kr',
            onChanged: (p0) => {
              setState(() {
                _values['Pris'] = p0;
              })
            },
          )),
    };
    super.initState();
  }

  final OverlayPortalController _overlaymenu = OverlayPortalController();
  @override
  Widget build(BuildContext context) {
    final filteredItems = _items.where((item) {
      final matchesFilter = item.contains(_filter);
      //final matchesCategory = _selectedCategory == 'All' || item.contains(_selectedCategory);
      return matchesFilter;
    }).toList();

    return Scaffold(
      key: scaffoldKey,
      drawer: StatefulBuilder(builder: (context, state) {
        final double highestPrice = _savedStructures.isNotEmpty ? _savedStructures.map((structure) => structure.price).reduce((a, b) => a > b ? a : b) : 0.0;
        final double highestCO2 = _savedStructures.isNotEmpty ? _savedStructures.map((structure) => structure.co2).reduce((a, b) => a > b ? a : b) : 0.0;
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close))),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Sammenligning',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: SizedBox.shrink()), // New column for images

                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Description')),
                    DataColumn(numeric: true, label: Text('CO2')),
                    DataColumn(numeric: true, label: Text('Price')),
                    DataColumn(label: SizedBox.shrink()),
                  ],
                  rows: _savedStructures.map((structure) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage('assets/Untitled.jpg'), // Replace 'structure.image' with the actual image path or URL
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(structure.name)),
                        DataCell(Text(structure.description)),
                        DataCell(Column(
                          children: [
                            Text('${structure.co2} kg'),
                            LinearProgressIndicator(
                              value: structure.co2 / highestCO2,
                            ),
                          ],
                        )),
                        DataCell(Column(
                          children: [
                            Text('${structure.price} kr'),
                            LinearProgressIndicator(
                              value: structure.price / highestPrice,
                            ),
                          ],
                        )),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _savedStructures.remove(structure);
                              });
                              state(() {
                                _savedStructures.remove(structure);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }),
      appBar: AppBar(
        leading: IconButton(
          icon: Row(
            children: [
              Icon(Icons.compare),
              Text('  ${_savedStructures.length}'),
            ],
          ),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text('Materialekatalog'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              cacheExtent: 1000,
              children: [
                CustomDropDown(
                  overlayPortalController: _overlaymenu,
                  menu: SizedBox(
                    width: 200,
                    child: ListView(
                        shrinkWrap: true,
                        children: _filters.difference(_selectedFilters).map((category) {
                          return ListTile(
                            leading: Icon(category.icon),
                            title: Text(category.name),
                            onTap: () {
                              _overlaymenu.hide();
                              setState(() {
                                category.isSelected = true;
                                _selectedFilters.add(category);
                                _overlayPortalControllers[category.name] = OverlayPortalController();
                                _overlayPortalControllers.updateAll((key, value) => OverlayPortalController());
                              });
                              _overlayPortalControllers[category.name]!.show();
                            },
                          );
                        }).toList()),
                  ),
                  label: 'Tilføj filter',
                  iconData: Icons.add,
                  chipColor: Theme.of(context).colorScheme.primary.withAlpha(140),
                ),
                ..._selectedFilters.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomDropDown(
                      menu: SizedBox(width: 300, child: category.menu),
                      overlayPortalController: _overlayPortalControllers[category.name],
                      iconData: category.icon,
                      onDeleted: () {
                        setState(() {
                          category.isSelected = false;
                          _selectedFilters.remove(category);
                          _overlayPortalControllers.remove(category.name);
                          _values.remove(category.name);
                        });
                      },
                      label: category.name + (_values[category.name] != null ? ' ${_values[category.name]}' : ''),
                    ),
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ActionChip(
                      color: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary.withAlpha(140),
                      ),
                      label: Text('Ryd'),
                      onPressed: () => setState(() {
                            _selectedFilters.clear();
                            _overlayPortalControllers.clear();
                            _values.clear();
                          })),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: mockedBuildingStructures.length,
              itemBuilder: (context, index) {
                final item = mockedBuildingStructures[index];
                final isItemSelected = _savedStructures.contains(item);
                return Card(
                  elevation: 2,
                  shape: ShapeBorder.lerp(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    0.5,
                  ),
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: GridTile(
                    header: GridTileBar(
                        trailing: IconButton(
                            icon: Icon(
                              isItemSelected ? Icons.check : Icons.add,
                              color: isItemSelected ? Colors.green : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isItemSelected ? _savedStructures.remove(item) : _savedStructures.add(item);
                              });
                            }),
                        subtitle: Text(
                          item.description,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        title: Text(item.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
                    child: Image.asset('assets/Untitled.jpg'),
                    footer: Column(
                      children: [
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.black26,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.co2),
                                  Text('${item.co2} kg'),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.money),
                                  Text('${item.price} kr'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
