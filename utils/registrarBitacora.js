const pool = require('../config/db');

async function registrarBitacora(id_usuario, tipo_usuario, accion) {
    try {
        await pool.query(
            'INSERT INTO bitacora (id_usuario, tipo_usuario, accion) VALUES (?, ?, ?)',
            [id_usuario, tipo_usuario, accion]
        );
    } catch (err) {
        console.error('Error al registrar en la bitácora:', err);
    }
}

module.exports = registrarBitacora;
