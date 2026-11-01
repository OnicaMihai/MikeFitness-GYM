const express = require('express');
const runSeed = require('./seed');
const db = require('./db');

const app = express();
app.use(express.json());

// Rulare Seeding la pornire (Cerința 3)
runSeed();

// Ruta de test
app.get('/api/health', async (req, res) => {
  try {
    const result = await db.query('SELECT NOW()');
    res.json({ message: 'Serverul funcționează!', time: result.rows[0].now });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Serverul rulează pe http://localhost:${PORT}`);
});