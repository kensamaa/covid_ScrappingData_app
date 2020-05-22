
import 'dart:ui';

class CoronaData {
  String cases;
  String dead;
  String cured;
  String awayy;

  CoronaData(this.cases, this.dead, this.cured, this.awayy);


}
class ville{
  String name;
  double value;
  ville(this.name, this.value);

  @override
  String toString() {
    return 'ville{name: $name, value: $value}';
  }

}

class coronaCity{
  ville casablanca;
  ville marakech;
  ville Rabat;
  ville tanger;
  ville Fesmeknes;
  ville oriental;
  ville beniMellal;
  ville DaraaTafilalet;
  ville DakhlaOuedEdDahab;
  ville SoussMassa;
  ville LaayouneSakiaElHamra;
  ville Guelmim;

  coronaCity(this.casablanca, this.marakech,  this.Rabat,
      this.tanger, this.Fesmeknes, this.oriental, this.beniMellal,
      this.DaraaTafilalet, this.DakhlaOuedEdDahab, this.SoussMassa,
      this.LaayouneSakiaElHamra, this.Guelmim);

  @override
  String toString() {
    return 'coronaCity{casablanca: $casablanca, marakech: $marakech, Rabat: $Rabat, tanger: $tanger, Fesmeknes: $Fesmeknes, oriental: $oriental, beniMellal: $beniMellal, DaraaTafilalet: $DaraaTafilalet, DakhlaOuedEdDahab: $DakhlaOuedEdDahab, SoussMassa: $SoussMassa, LaayouneSakiaElHamra: $LaayouneSakiaElHamra, Guelmim: $Guelmim}';
  }


}
double stringtodouble(String str){
  String neww=str.replaceAll('%', '').replaceAll(',', '.');
  return double.parse(neww);
}



