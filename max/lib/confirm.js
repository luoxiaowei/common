const readline = require('readline');

const confirm = (message) => {
    return new Promise((resolve, reject) => {
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });
        rl.question(message, (answer) => {
            if (/^y/i.test(answer)){
                rl.close();
                resolve(true);
            } else {
                rl.close();
                resolve(false);
                
            }
        });
    })
    
} 
module.exports = confirm;


