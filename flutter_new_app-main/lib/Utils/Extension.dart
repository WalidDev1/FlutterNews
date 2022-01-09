  String daysBetween(DateTime from, DateTime to) {
    return "${calculeInterval((to.difference(from).inSeconds).round())}";
  }

  String calculeInterval(int val)  {

  if ((val / 2629743) >= 1) {
  return "Il y a ${(val / 2629743).round()} mois";
  }
  if((val / 604800) >= 1){
  return "Il y a ${(val / 604800).round()} semaines";
  }
  if((val / 86400) >= 1){
  return "Il y a ${(val / 86400).round()} jour";
  }
  if (((val % 86400) / 3600) >= 1 ) {
  return "Il y a ${((val % 86400) / 3600).round()} heures";
  }
  if (((val % 3600) / 60) >= 1) {
  return "Il y a ${((val % 3600) / 60).round()} minutes";
  }
  if (((val % 3600) % 60) >= 1 ){
  return "Il y a ${((val % 3600) % 60).round()}  secondes";
  }
  return "À l'instant";
  }