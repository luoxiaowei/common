import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { observer, inject } from 'mobx-react';
import { Spin, Table } from 'antd';
import styles from '<%= name %>.less';

@inject('<%= storeName %>')
@observer

export default class Main extends Component {
    static propTypes = {
        formValue: PropTypes.object,
    }
    constructor(props) {
        super(props);
        this.state = {
            
        };
    }
    handleSubmit = () => {
        const { validateFields } = this.props.form;
        const { formValue } = this.props;
        validateFields((err, values) => {
            if (err) {
                return;
            }
            let params = { ...values };
            if (formValue.id) {
                params.id = formValue.id;
            } 
            this.props.<%= storeName %>.post<%= moudleName %><%= name %>(params, () => {
                message.success('操作成功');
            });
        });

    }

    render() {
        const { list, total, filter, loading } = this.props.<%= storeName %>;
        const { getFieldDecorator } = this.props.form;
        const { formValue } = this.props;
        const formItemLayout = {
            labelCol: {
                xs: { span: 24 },
                sm: { span: 6 },
            },
            wrapperCol: {
                xs: { span: 24 },
                sm: { span: 18 },
            },
            colon: false
        };
        return (
            <Form>
                <Row>
                    <Col span={24}>
                        <FormItem label={'labelName'} { ...formItemLayout }>
                            {getFieldDecorator('key', {
                                initialValue: formValue.key || '',
                                rules: [{ required: true, message: '不能为空' }]
                            })(
                                <Input placeholder="请输入" maxLength={100} />
                            )}
                        </FormItem>
                    </Col>
                </Row>
            </Form>
        );
    }
}