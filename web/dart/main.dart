import 'dart:html';
import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;

void main() {
  react_client.setClientConfiguration();
  var component = react.h1({}, 'Updated from Dart and React');
  react_dom.render(component, querySelector('#content'));
}