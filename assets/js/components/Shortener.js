import React, { Component } from 'react';
import LinkForm from './shortener/LinkForm';
import LinkDisplay from './shortener/LinkDisplay';
import { Container, Row, Col, Jumbotron } from 'react-bootstrap';

class Shortener extends Component {
  constructor(props) {
    super(props);
    this.state = {
      shortLink: ''
    }
    this.createShortLink = this.createShortLink.bind(this);
  }

  createShortLink(event) {
    event.preventDefault();
    const url = event.target.formLink.value;
    if (url == null || url == '') {return;}

    const requestOptions = {
     method: 'POST',
     headers: { 'Content-Type': 'application/json' },
     body: JSON.stringify({ link: { url: url } })
    };

    fetch('/api/links', requestOptions)
      .then((response) => {
        return response.json();
      }).then((data) => {
        this.setState({ shortLink: data.shortLink })
      });
      event.target.formLink.value = null;
  }

  render() {
    return (
      <Container>
        <Row className="justify-content-lg-center">
          <Col lg="6">
            <Jumbotron>
            <h1>Welcome to Shorten!</h1>
            <p>
              The world's greatest URL shortener. Get started by pasting your link below.
            </p>
            </Jumbotron>
            <LinkForm createShortLink={this.createShortLink} validURL={this.validURL}/>
            { this.state.shortLink && <LinkDisplay shortLink={this.state.shortLink}/> }
          </Col>
        </Row>
      </Container>
    );
  }
}

export default Shortener;
