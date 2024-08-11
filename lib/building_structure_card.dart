import 'package:flutter/material.dart';
import 'package:materialekatalog/construction.dart';

class BuildingStructureCard extends StatelessWidget {
  final BuildingStructure item;
  final bool isItemSelected;
  final Function(bool) onItemPressed;

  const BuildingStructureCard({
    Key? key,
    required this.item,
    required this.isItemSelected,
    required this.onItemPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onItemPressed(!isItemSelected);
            },
          ),
          subtitle: Text(
            item.description,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          title: Text(
            item.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
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
  }
}
