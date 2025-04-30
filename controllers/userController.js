const pool = require('../config/db');
const registrarBitacora = require('../utils/registrarBitacora');

async function obtenerPerfil(req, res) {
    try {
        const [result] = await pool.query(
            'SELECT usuario, correo, tipo_usuario FROM persona WHERE id_persona = ?',
            [req.session.userId]
        );

        if (result.length === 0) return res.status(404).json({ error: 'Usuario no encontrado' });

        res.status(200).json(result[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al obtener perfil' });
    }
}

async function actualizarPerfil(req, res) {
    const { usuario, correo } = req.body;

    try {
        await pool.query(
            'UPDATE persona SET usuario = ?, correo = ? WHERE id_persona = ?',
            [usuario, correo, req.session.userId]
        );

        const [rows] = await pool.query('SELECT tipo_usuario FROM persona WHERE id_persona = ?', [req.session.userId]);
        const tipo_usuario = rows.length > 0 ? rows[0].tipo_usuario : 'desconocido';

        await registrarBitacora(req.session.userId, tipo_usuario, 'Actualizó su perfil');

        res.status(200).json({ success: true, message: 'Perfil actualizado correctamente' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al actualizar perfil' });
    }
}

module.exports = { obtenerPerfil, actualizarPerfil };
