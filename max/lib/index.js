#!/usr/bin/env node
const fs = require("fs");
const ejs = require("ejs");
const path = require("path");
const confirm = require('./confirm');
const delFile = require('./delete');

const PATH_TPL = path.join(__dirname, '../tpl');
const METHOD = {
    'List': 'get',
    'Form': 'post'
};
const VIEWS = {
    'List': true,
    'Form': true
}

let argv = process.argv;
argv.shift();
argv.shift();

switch (argv[0]) {
    case 'view': // 创建组件
        argv.shift();
        createView();
        break;
    case 'create': 
        argv.shift();
    default:  // 创建模块
        createMoudle();

}



async function createMoudle() {
    let moudleName = argv[0].replace(/(.*)\//, ''); // /\/$/
    let pathName = `./${argv[0]}`;
    argv.shift();
    let views = [];
    
    argv.forEach(item => {
        views.push({
            method: METHOD[item.replace(/(.*)[A-Z]/, e => e.slice(-1))],
            type: item.replace(/(.*)[A-Z]/, e => e.slice(-1)),
            operationName: item.replace(item.replace(/(.*)[A-Z]/, e => e.slice(-1)), ''),
            name: item,
            moudleName,
            storeName: moudleName.replace(/^[a-z]{1}/i, e => e.toLowerCase())
        }); 
    });
    
    let flag = true;
    if (fs.existsSync(pathName)) {
        flag = await confirm(moudleName + '已经存在，是否覆盖?');
        if (flag) {
            try {
                delFile(pathName);
                console.log('成功删除' + moudleName);
            } catch (err) {
                throw err
            }
        }
    }
    if (flag) {
        fs.mkdir(pathName, async err => {
            if (err) {
                throw err;
            }
            const actionsPATH = pathName + '/actions';
            const viewsPATH = pathName + '/views';
            fs.mkdirSync(actionsPATH);
            fs.mkdirSync(viewsPATH);
            // index.js
            ejs.renderFile(PATH_TPL + '/index.tpl', { name: moudleName, title: '' }, {}, function(err, str){
                if(err) throw err; 
                fs.writeFile(pathName + '/index.js', str, (err) => {
                    if(err) throw err; 
                });
            });
            // actions api.js
            ejs.renderFile(PATH_TPL + '/actions/api.tpl', {
                name: moudleName,
                views
            }, {}, function(err, str){
                if(err) throw err; 
                fs.writeFile(actionsPATH + '/api.js', str, (err) => {
                    if(err) throw err; 
                });
            });
            // actions store.js
            ejs.renderFile(PATH_TPL + '/actions/store.tpl', {
                name: moudleName,
                views
            }, {}, function(err, str){
                if(err) throw err; 
                fs.writeFile(actionsPATH + '/store.js', str, (err) => {
                    if(err) throw err; 
                });
            });
            // views main.js
            ejs.renderFile(PATH_TPL + '/views/Main.tpl', {
                name: moudleName,
                views
            }, {}, function(err, str){
                if(err) throw err; 
                fs.writeFile(viewsPATH + '/' + moudleName + '.jsx', str, (err) => {
                    if(err) throw err; 
                });
            });
            // views main.less
            fs.writeFile(viewsPATH + '/' + moudleName + '.less', '', (err) => {
                if(err) throw err; 
            });

            // views 
            views.map(item => {
                let viewsPath = pathName + '/views/' + item.name;
                fs.mkdirSync(viewsPath);
                // views view.js
                ejs.renderFile(PATH_TPL + '/views/'+ item.type +'.tpl', { ...item }, {}, function(err, str){
                    if (err) throw err;
                    fs.writeFile(viewsPath + '/' + item.name + '.jsx', str, (err) => {
                        if(err) throw err; 
                    });
                });
                // views main.less
                fs.writeFile(viewsPath + '/' + item.name + '.less', '', (err) => {
                    if(err) throw err; 
                });
            })
        })
    }
    
    
}

async function createView() {
    let moudleName = argv[0];
    argv.shift();
    let views = [];
    argv.forEach(item => {
        views.push({
            type: VIEWS[item.replace(/(.*)[A-Z]/, e => e.slice(-1))] ? item.replace(/(.*)[A-Z]/, e => e.slice(-1)) : 'Default',
            operationName: item.replace(item.replace(/(.*)[A-Z]/, e => e.slice(-1)), ''),
            name: item.replace(/(.*)\//, ''),
            moudleName,
            storeName: moudleName.replace(/^[a-z]{1}/i, e => e.toLowerCase()),
            viewsPath: `./${item}`
        }); 
    });
    views.forEach(async item => {
        const { viewsPath, name } = item;
        let flag = true;
        if (fs.existsSync(viewsPath)) {
            flag = await confirm(name + '已经存在，是否覆盖?');
            if (flag) {
                try {
                    delFile(viewsPath);
                    console.log('成功删除' + name);
                } catch (err) {
                    throw err
                }
            }
        }
        if (flag) {
            fs.mkdirSync(viewsPath);
            // views view.js
            ejs.renderFile(PATH_TPL + '/views/'+ item.type +'.tpl', { ...item }, {}, function(err, str){
                if (err) throw err;
                fs.writeFile(viewsPath + '/' + item.name + '.jsx', str, (err) => {
                    if(err) throw err; 
                });
            });
            // views main.less
            fs.writeFile(viewsPath + '/' + item.name + '.less', '', (err) => {
                if(err) throw err; 
            });
        }
    })

}

