import Router from '../Router';
import TestStore from './actions/store';
import Test from './views/Test';

Router.addRoute({
    title: 'Test',
    path: '/test',
    component: Test
});

Router.addStore({
    test: new TestStore()
});