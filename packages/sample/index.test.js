const idx = require('./index');

test('Greets properly', () => {
    expect(idx.greet('Hans')).toBe('Hello, Hans!');
});
