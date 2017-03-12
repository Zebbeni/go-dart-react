import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

class _LeftChild extends react.Component {
  @override
  getInitialState() => {
    'value': 0,
  };

  @override
  render() {
    return react.div({}, [
      react.h1({}, props['value']),
    ]);
  }
}

var leftChild = react.registerComponent(() => new _LeftChild());

class _RightChild extends react.Component {
  @override
  getInitialState() => {
    'value': 3,
  };

  @override
  render() {
    return react.div({}, [
      react.h1({}, props['value']),
    ]);
  }
}

var rightChild = react.registerComponent(() => new _RightChild());

/// In this [Component] we'll build a search form.
///
/// This [Component] illustrates that:
///
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
        }, 'Submit'),
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
/// It's a common practice to store the application data in the [state] of the root [Component]. It will re-render
/// every time the state is changed. However, it is not required - you can also use normal variables and re-render
/// manually if you wish.
///
/// When the request is sent, it has `pending` status in the history. This changes to `OK` or `error` when the answer
/// _(or timeout)_ comes. If the new request is sent meanwhile, the old one is cancelled.
class _App extends react.Component {
  @override
  getInitialState() => {
    'leftValue': 1, // Data from last query.
    'rightValue': 2,
  };

  /// The id of the last query.
  var last_id = 0;

  /// Sends request to the server processes the result
  newQuery() {
    // Prepare the URL
    var path = '/func';

    // Send the request
    HttpRequest.getString(path)
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
      leftChild({'value': state['leftValue']}),
      rightChild({'value': state['rightValue']}),
      appForm({
        // `newQuery` is the final callback of the button click.
        'submitter': newQuery
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