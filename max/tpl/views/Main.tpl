import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { observer, inject } from 'mobx-react';
import styles from '<%= name %>.less';

@inject('<%= name.replace(/^[a-z]{1}/i, e => e.toLowerCase() ) %>')
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
        return (
            <div>
                
            </div>
        );
    }
}