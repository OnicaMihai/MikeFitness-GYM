const db = require('./db');

async function runSeed() {
  try {
    // Înserare roluri de bază
    await db.query(`
      INSERT INTO roles (id, denumire) 
      VALUES (1, 'Admin'), (2, 'Trainer'), (3, 'Client')
      ON CONFLICT (id) DO NOTHING;
    `);

    // Inserare abonamente de bază
    await db.query(`
      INSERT INTO membership_types (id, denumire, pret, durata_zile)
      VALUES 
        (1, 'Day Pass', 50.00, 1),
        (2, 'Full Access Lunar', 200.00, 30),
        (3, 'Abonament Student', 150.00, 30)
      ON CONFLICT (id) DO NOTHING;
    `);

    console.log('✅ Fixtures / Seeding executat cu succes!');
  } catch (err) {
    console.error('❌ Eroare la seed:', err);
  }
}

module.exports = runSeed;