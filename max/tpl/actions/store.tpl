import { observable, action, runInAction } from 'mobx';
import api from './api';
import ajax from 'ajax';

class <%= name %>Store {
<% views.forEach((it) => { _%>
<% if(it.type == 'List') { _%> 
    @observable <%= (it.operationName + 'List').replace(/[A-Z]/, s => s.toLowerCase()) %> = [];
    @observable <%= (it.operationName + 'Total').replace(/[A-Z]/, s => s.toLowerCase()) %> = 0;
    @observable <%= (it.operationName + 'Filter').replace(/[A-Z]/, s => s.toLowerCase()) %> = {
        page: 1,
        pageSize: 10
    };
<% } _%>
<% }) _%>
<% views.forEach((it) => { _%>

<% if(it.type == 'List') { _%> 
   @action async <%= it.method %><%= it.moudleName %><%= it.name %>(cb) { 
        const result = await ajax.get(api.<%= it.method %><%= it.moudleName %><%= it.name %>, { params: this.<%= (it.operationName + 'Filter').replace(/[A-Z]/, s => s.toLowerCase()) %> });
        runInAction(() => {
            this.<%= (it.operationName + 'List').replace(/[A-Z]/, s => s.toLowerCase()) %>  = result.data.list;
            this.<%= (it.operationName + 'Total').replace(/[A-Z]/, s => s.toLowerCase()) %> = result.data.total;
        });
        cb && cb(result);
    }; 
<% } _%>
<% if(it.type == 'Form') { _%> 
   @action async <%= it.method %><%= it.moudleName %><%= it.name %>(params, cb) { 
        const result = await ajax.post(api.<%= it.method %><%= it.moudleName %><%= it.name %>, params);
        cb && cb(result);
    }; 
<% } _%>
<% }) _%>
    
}

export default <%= name %>Store;