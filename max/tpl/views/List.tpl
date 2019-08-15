import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { observer, inject } from 'mobx-react';
import { Spin, Table } from 'antd';
import styles from './<%= name %>.less';

@inject('<%= storeName %>')
@observer

export default class Main extends Component {
    static propTypes = {
        
    }
    constructor(props) {
        super(props);
        this.state = {
            
        };
        this.columns = [
            {
                title: 'name',
                dataIndex: 'key',
                width: '10%',
            },
        ];
    }

    componentDidMount () {
        this.props.<%= storeName %>.get<%= moudleName %><%= name %>();
    }

    render() {
        const { list, total, filter, loading } = this.props.<%= storeName %>;
        const pagination = {
            pageSize: filter.pageSize,
            showQuickJumper: true,
            total: total,
            showTotal: (total) => {
                return <p className='l'>共 <b>{total}</b> 条</p>;
            },
            current: filter.page,
            onChange: (page, pageSize) => {
                this.props.<%= storeName %>.filter = {
                    ...this.props.<%= storeName %>.filter,
                    page
                };
                this.props.<%= storeName %>.get<%= moudleName %><%= name %>();
            }
        };
        return (
            <Spin tip="正在加载数据..." spinning={loading}>
                <Table
                    dataSource={list}
                    columns={this.columns}
                    bordered
                    pagination={pagination}
                />
            </Spin>
        );
    }
}