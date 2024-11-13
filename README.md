Conjure simply lets you expose properties of a data model class for easy building, somewhat allowing the abstraction of ui between two different models.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
import 'package:conjure/conjure.dart';

/// Define a model
class User implements ConjuredTitle, ConjuredSubtitle {
  final String name;
  final String email;
  // ...

  User({
    required this.name,
    required this.email,
    // ...
  });

  /// Connect name with title
  @override
  String get title => name;

  /// Connect email with subtitle
  @override
  String get subtitle => email;
}

/// Here we create a widget that supports ANY conjured model
class ConjureCard<M extends Conjured> extends StatelessWidget {
  final M model;

  const ConjureCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) => Card(
    // we check if the color is available in the model, if not we use null
    color: ConjuredField.color.isPresent<M>() ? Color(ConjuredField.color.getValue(model)) : null,
    child: Column(
      children: [
        // we check if the title and subtitle are available in the model, if not we just dont put it there
        if(ConjuredField.title.isPresent<M>())
          Text(ConjuredField.title.getValue(model)),
        if(ConjuredField.subtitle.isPresent<M>())
          Text(ConjuredField.subtitle.getValue(model)),
      ],
    ),
  );
}

```

## Additional information

NOTE: This package does not actually contain any UI on it's own, it's just a way to abstract the UI building process. You will need to construct your own widgets to use this package. This package does not depend on flutter because some projects put their data models in another dart-only project in the event their servers are written in dart_shelf and want access to the models also.
