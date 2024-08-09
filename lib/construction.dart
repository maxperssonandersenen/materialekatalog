class BuildingStructure {
  double co2;
  double price;
  // Add other relevant properties here
  int biodiversitet;
  String name;
  String description;

  BuildingStructure({
    required this.co2,
    required this.price,
    required this.biodiversitet,
    required this.name,
    required this.description,
  });
}

List<BuildingStructure> mockedBuildingStructures = [
  BuildingStructure(
    co2: 250.0,
    price: 900000.0,
    biodiversitet: 5,
    name: 'Roof',
    description: 'Description of the roof',
  ),
  BuildingStructure(
    co2: 180.0,
    price: 700000.0,
    biodiversitet: 3,
    name: 'Outside Wall',
    description: 'Description of the outside wall',
  ),
  BuildingStructure(
    co2: 300.0,
    price: 1000000.0,
    biodiversitet: 4,
    name: 'Foundation',
    description: 'Description of the foundation',
  ),
  BuildingStructure(
    co2: 200.0,
    price: 800000.0,
    biodiversitet: 2,
    name: 'Floor',
    description: 'Description of the floor',
  ),
  BuildingStructure(
    co2: 150.0,
    price: 600000.0,
    biodiversitet: 3,
    name: 'Window',
    description: 'Description of the window',
  ),
  // Add more mocked building structures here
  BuildingStructure(
    co2: 250.0,
    price: 900000.0,
    biodiversitet: 5,
    name: 'Staircase',
    description: 'Description of the staircase',
  ),
  BuildingStructure(
    co2: 180.0,
    price: 700000.0,
    biodiversitet: 3,
    name: 'Elevator',
    description: 'Description of the elevator',
  ),

  BuildingStructure(
    co2: 300.0,
    price: 1000000.0,
    biodiversitet: 4,
    name: 'Facade',
    description: 'Description of the facade',
  ),
  BuildingStructure(
    co2: 200.0,
    price: 800000.0,
    biodiversitet: 2,
    name: 'Column',
    description: 'Description of the column',
  ),
  BuildingStructure(
    co2: 150.0,
    price: 600000.0,
    biodiversitet: 3,
    name: 'Door',
    description: 'Description of the door',
  ),
  BuildingStructure(
    co2: 250.0,
    price: 900000.0,
    biodiversitet: 5,
    name: 'Ceiling',
    description: 'Description of the ceiling',
  ),
];
