const pool = require('../config/db');
const registrarBitacora = require('../utils/registrarBitacora');

async function crearCita(req, res) {
    const { id_mecanico, fecha } = req.body;

    try {
        await pool.query('INSERT INTO citas (id_cliente, id_mecanico, fecha) VALUES (?, ?, ?)', [req.session.userId, id_mecanico, fecha]);

        await registrarBitacora(req.session.userId, 'cliente', 'Creó una nueva cita');
        await registrarBitacora(id_mecanico, 'mecanico', 'Le fue asignada una nueva cita');

        res.status(200).json({ message: 'Cita creada correctamente' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al crear cita' });
    }
}

async function obtenerMisCitas(req, res) {
    try {
        const [citas] = await pool.query(
            'SELECT * FROM citas WHERE id_cliente = ? OR id_mecanico = ?',
            [req.session.userId, req.session.userId]
        );
        res.status(200).json(citas);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al obtener citas' });
    }
}

async function actualizarEstadoCita(req, res) {
    const { id, estado } = req.body;

    try {
        await pool.query('UPDATE citas SET estado = ? WHERE id = ?', [estado, id]);
        await registrarBitacora(req.session.userId, 'mecanico', `Actualizó el estado de la cita a ${estado}`);
        res.status(200).json({ message: 'Cita actualizada' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error al actualizar cita' });
    }
}

module.exports = { crearCita, obtenerMisCitas, actualizarEstadoCita };
