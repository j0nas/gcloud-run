const request = require('supertest');
const app = require('./app');

describe('server', () => {
  it('accepts requests', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toEqual(200);
  });
});
