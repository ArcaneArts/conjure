library conjure;

extension XListConjured<T extends ConjuredDimension> on List<T> {
  List<T> conjureSort(ConjuredField field, {bool descending = false}) {
    if (isNotEmpty && field.isPresent<T>()) {
      sort((a, b) {
        Comparable? av = descending ? field.getValue(b) : field.getValue(a);
        Comparable? bv = descending ? field.getValue(a) : field.getValue(b);
        if (av == null && bv == null) return 0;
        if (av == null) return -1;
        if (bv == null) return 1;
        return av.compareTo(bv);
      });
    }
    return this;
  }
}

abstract class Conjured {}

abstract class ConjuredDimension implements Conjured {}

enum ConjuredField {
  identity,
  title,
  subtitle,
  color,
  progress,
}

extension XConjuredField on ConjuredField {
  Type get type {
    switch (this) {
      case ConjuredField.identity:
      case ConjuredField.title:
      case ConjuredField.subtitle:
        return String;
      case ConjuredField.color:
        return int;
      case ConjuredField.progress:
        return double;
    }
  }

  Comparable? getValue<T extends Conjured>(T conjured) {
    switch (this) {
      case ConjuredField.identity:
        return (conjured as ConjuredIdentity).identity;
      case ConjuredField.title:
        return (conjured as ConjuredTitle).title;
      case ConjuredField.subtitle:
        return (conjured as ConjuredSubtitle).subtitle;
      case ConjuredField.color:
        return (conjured as ConjuredColor).color;
      case ConjuredField.progress:
        return (conjured as ConjuredProgress).progress;
    }
  }

  bool isPresent<T extends Conjured>() {
    switch (this) {
      case ConjuredField.identity:
        return T is ConjuredIdentity;
      case ConjuredField.title:
        return T is ConjuredTitle;
      case ConjuredField.subtitle:
        return T is ConjuredSubtitle;
      case ConjuredField.color:
        return T is ConjuredColor;
      case ConjuredField.progress:
        return T is ConjuredProgress;
    }
  }
}

abstract class ConjuredIdentity extends ConjuredDimension {
  String? get identity;
}

abstract class ConjuredTitle extends ConjuredDimension {
  String? get title;
}

abstract class ConjuredSubtitle extends ConjuredDimension {
  String? get subtitle;
}

abstract class ConjuredColor extends ConjuredDimension {
  int? get color;
}

abstract class ConjuredProgress extends ConjuredDimension {
  double? get progress;
}
