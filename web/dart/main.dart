import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

class _LeftChild extends react.Component {
  @override
  render() {
    return react.div({
      'className': 'childDiv',
      'id': 'leftChild',
    }, [
      react.h2({}, props['value']),
    ]);
  }
}
var leftChild = react.registerComponent(() => new _LeftChild());

class _RightChild extends react.Component {
  @override
  render() {
    return react.div({
      'className': 'childDiv',
      'id': 'rightChild',
    }, [
      react.h2({}, props['value']),
    ]);
  }
}
var rightChild = react.registerComponent(() => new _RightChild());

/// > The functions can be [Component] parameters _(handy for callbacks)_
///
/// > The DOM [Element]s can be accessed using [ref]s.
class _AppForm extends react.Component {
  var searchInputInstance;

  @override
  render() {
    return react.div({}, [
      react.form({
        'className': 'form-inline',
        'onSubmit': onFormSubmit
      }, [
        react.button({
          'className': 'btn btn-primary',
          'type': 'submit'
        }, 'Update All'),
      ])
    ]);
  }

  /// Handle form submission via `props.onSubmit`
  onFormSubmit(react.SyntheticEvent event) {
    event.preventDefault();
    // Call the callback from the parent element.
    props['submitter']();
  }
}

var appForm = react.registerComponent(() => new _AppForm());


/// The root [Component] of our application.
///
/// Introduces [state]. Both [state] and [props] are valid locations to store [Component] data.
///
/// However, there are some key differences to note:
///
/// > [props] can contain data dictated by the parent component
///
/// > [state] is an internal storage of the component that can't be accessed by the parent.
///
/// > When [state] is changed, the component will re-render.
///
class _App extends react.Component {
  @override
  getInitialState() => {
    'leftValue': 1,
    'rightValue': 2,
  };

  /// Sends request to the server processes the result
  updateAll() {

    // Send the request to /func
    HttpRequest.getString('/func')
        .then((value) =>
    // Delay the answer 2 more seconds, for test purposes
    new Future.delayed(new Duration(seconds: 2), () => value)
    )
        .then((String raw) {

        var data = JSON.decode(raw);
        print(data);

        // Calling `setState` will update the state and repaint the component.
        setState({
          'leftValue': data['randLeft'],
          'rightValue': data['randRight'],
        });
    })
        .catchError((Error error) {
    });
  }

  @override
  render() {
    return react.div({}, [
      react.h1({}, 'App'),
      leftChild({
        'value': state['leftValue'],
      }),
      rightChild({
        'value': state['rightValue']}),
      appForm({
        'submitter': updateAll  // call App's submit function from form child
      })
    ]);
  }
}

var app = react.registerComponent(() => new _App());

/// And finally, a few magic commands to wire it all up!
///
/// Select the root of the app and the place in the DOM where it should be mounted.
void main() {
  react_client.setClientConfiguration();
  react_dom.render(app({}), querySelector('#content'));
}