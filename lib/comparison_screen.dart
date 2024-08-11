import 'package:flutter/material.dart';
import 'package:materialekatalog/construction.dart';

class ComparisonScreen extends StatelessWidget {
  final Set<BuildingStructure> savedStructures;

  ComparisonScreen({required this.savedStructures});

  @override
  Widget build(BuildContext context) {
    final double highestPrice = savedStructures.isNotEmpty ? savedStructures.map((structure) => structure.price).reduce((a, b) => a > b ? a : b) : 0.0;
    final double highestCO2 = savedStructures.isNotEmpty ? savedStructures.map((structure) => structure.co2).reduce((a, b) => a > b ? a : b) : 0.0;
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
                  icon: Icon(Icons.close),
                ),
              ),
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
              rows: savedStructures.map((structure) {
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
                    DataCell(
                      Column(
                        children: [
                          Text('${structure.co2} kg'),
                          LinearProgressIndicator(
                            value: structure.co2 / highestCO2,
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Column(
                        children: [
                          Text('${structure.price} kr'),
                          LinearProgressIndicator(
                            value: structure.price / highestPrice,
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Remove the structure from the saved structures
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Structure removed'),
                            ),
                          );
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
  }
}
