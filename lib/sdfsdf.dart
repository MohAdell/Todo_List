class Faker {
  String name;
  String location;
  double idHottel;

  Faker(this.name, this.location, this.idHottel);

  List<Faker> faker = [
    Faker("ahmed", "egypt", 111),
    Faker("ali", "UAE", 222),
    Faker("noor", "USA", 333),
  ];
}
