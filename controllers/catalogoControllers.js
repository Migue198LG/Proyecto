const pool = require('../config/db');

async function getPZSCarroceria(req, res) {
    try {
        const [pszcarroceria] = await pool.query(
            'SELECT * FROM merch.pzscarroceria');
        res.status(200).json(pszcarroceria);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al obtener pszcarroceria' });
    }
}

async function getPZSMecanicas(req, res) {
    try {
        const [pszcarroceria] = await pool.query(
            'SELECT * FROM merch.pzsmecanicas');
        res.status(200).json(pszcarroceria);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al obtener pszcarroceria' });
    }
}

async function getPZSMotor(req, res) {
    try {
        const [pszcarroceria] = await pool.query(
            'SELECT * FROM merch.pzsmotor');
        res.status(200).json(pszcarroceria);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al obtener pszcarroceria' });
    }
}
module.exports = {getPZSCarroceria, getPZSMecanicas, getPZSMotor};