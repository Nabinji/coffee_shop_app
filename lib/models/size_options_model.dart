class SizeOption {
  final String name, quantity;

  SizeOption({required this.name, required this.quantity});
}

List<SizeOption> sizeOptions = [
  SizeOption(name: 'Tall', quantity: '12'),
  SizeOption(name: 'Grande', quantity: '16'),
  SizeOption(name: 'Venti', quantity: '24'),
  SizeOption(name: 'Custom', quantity: '...'),
];
