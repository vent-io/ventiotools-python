const moment = require('moment');

function greet(name) {
    return `Hello, ${name}!`;
}

const date = moment().format('YYYY-MM-DD');
console.log(`Current date: ${date}`);

console.log(greet('World'))
console.log('Your setup is working!')

module.exports = {
    greet
};
