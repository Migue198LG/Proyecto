const pool = require('../config/db');

async function obtenerBitacoraCliente(req, res) {
    try {
        const [result] = await pool.query(
            'SELECT * FROM bitacora WHERE tipo_usuario = "cliente" AND id_usuario = ? ORDER BY fecha DESC',
            [req.session.userId]
        );
        res.status(200).json(result);
    } catch (err) {
        console.error('Error al obtener bitácora del cliente:', err);
        res.status(500).json({ error: 'Error al obtener la bitácora' });
    }
}

async function obtenerBitacoraMecanico(req, res) {
    try {
        const [result] = await pool.query(
            'SELECT * FROM bitacora WHERE tipo_usuario = "mecanico" AND id_usuario = ? ORDER BY fecha DESC',
            [req.session.userId]
        );
        res.status(200).json(result);
    } catch (err) {
        console.error('Error al obtener bitácora del mecánico:', err);
        res.status(500).json({ error: 'Error al obtener la bitácora' });
    }
}

module.exports = { obtenerBitacoraCliente, obtenerBitacoraMecanico };
