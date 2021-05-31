import React, { Component } from 'react';
import { Jumbotron } from 'react-bootstrap';

class LinkDisplay extends Component {
  render() {
    return (
      <Jumbotron>
        <h1>Here is your shortlink!</h1>
        <a href={this.props.shortLink}>{this.props.shortLink}</a>
      </Jumbotron>
    );
  }
}

export default LinkDisplay;
