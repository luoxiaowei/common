import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { observer, inject } from 'mobx-react';
import styles from '<%= name %>.less';

@inject('<%= storeName %>')
@observer

export default class Main extends Component {
    static propTypes = {

    }
    constructor(props) {
        super(props);
        this.state = {
            
        };
    }

    render() {
        const {  } = this.props.<%= storeName %>;
        return (
            <div><%= name %></div>
        );
    }
}