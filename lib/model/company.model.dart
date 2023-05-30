class Company {
  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });
  late final String name;
  late final String catchPhrase;
  late final String bs;

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['catchPhrase'] = catchPhrase;
    _data['bs'] = bs;
    return _data;
  }
}
