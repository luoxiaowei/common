import Router from '../Router';
import <%= name %>Store from './actions/store';
import <%= name %> from './views/<%= name %>';

Router.addRoute({
    title: '<%= title || name %>',
    path: '/<%= name.replace(/[A-Z]/, s => s.toLowerCase()) %>',
    component: <%= name %>
});

Router.addStore({
    <%= name.replace(/[A-Z]/, s => s.toLowerCase()) %>: new <%= name %>Store()
});