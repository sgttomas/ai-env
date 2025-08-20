import assert from 'node:assert/strict';
import { greet, add } from '../src/index.js';

assert.equal(greet('AI'), 'Hello, AI!');
assert.equal(add(2, 3), 5);

console.log('All tests passed.');
