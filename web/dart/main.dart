import 'dart:html';
import 'package:react/react.dart';
import 'package:react/react_client.dart' as react_client;
import 'package:react/react_dom.dart' as react_dom;

typedef AppType({String headline, String text});

var _app = registerComponent(() => new App());

AppType app = ({headline, text}) =>
    _app({'headline':headline, 'text':text});

class App extends Component {
  get headline => props['headline'];
  get text => props['text'];
  render() =>
      div({},[
        h1({}, headline),
        span({}, text),
      ]);
}

void main() {
  react_client.setClientConfiguration();
  react_dom.render(
      app(headline: "My custom headline",
          text: "My custom text"),
      querySelector('#app')
  );
}