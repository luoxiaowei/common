
export default {
<% views.forEach((it) => { _%>
    <%=it.method%><%= it.moudleName %><%= it.name %>: '/api',
<% }) _%>
};