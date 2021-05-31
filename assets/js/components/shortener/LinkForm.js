import React, { Component } from 'react';
import { Container, Row, Col, Form, Button, Alert } from 'react-bootstrap';

class LinkForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isValid: true
    }
    this.validURL = this.validURL.bind(this);
  }

  validURL(event) {
    let url;
    let isValid;

    try {
      url = new URL(event.target.value);
    } catch (_) {
      isValid = false;
    }
    if (isValid !== false) {
      isValid = url.protocol === "http:" || url.protocol === "https:";
    }
    this.setState({isValid});
  }

  render() {
    return (
      <Form onSubmit={this.props.createShortLink}>
      { !this.state.isValid && <Alert variant="danger">Invalid URL!</Alert> }
        <Form.Group>
          <Form.Control type="text" placeholder="Paste link" name="formLink" onChange={this.validURL} />
        </Form.Group>
        <Button variant="primary" type="submit" size="lg" block disabled={!this.state.isValid}>
          Generate Shortlink
        </Button>
      </Form>
    );
  }
}

export default LinkForm;
