const pool = require('../config/db');
const registrarBitacora = require('../utils/registrarBitacora');

async function iniciarSesion(req, res) {
    const { correo_i, contra_i } = req.body;

    if (!correo_i || !contra_i) {
        return res.status(400).json({ error: "Completa todos los campos." });
    }

    try {
        const [rows] = await pool.query('SELECT id_persona, tipo_usuario FROM persona WHERE correo = ? AND contraseña = ?', [correo_i, contra_i]);

        if (rows.length > 0) {
            req.session.userId = rows[0].id_persona;
            const tipo_usuario = rows[0].tipo_usuario;

            await registrarBitacora(req.session.userId, tipo_usuario, 'Inicio de sesión');

            const redirectTo = tipo_usuario === 'mecanico' ? '/mecanico' : '/cliente';
            return res.status(200).json({ message: 'Inicio de sesión exitoso', redirectTo });
        } else {
            return res.status(400).json({ error: "Credenciales incorrectas" });
        }

    } catch (err) {
        console.error('Error al iniciar sesión:', err);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
}

async function registrarUsuario(req, res) {
    const { correo, contra, usuario, rol } = req.body;

    if (!correo || !contra || !usuario || !rol) {
        return res.status(400).json({ error: 'Todos los campos son requeridos' });
    }

    try {
        const [existing] = await pool.query('SELECT * FROM persona WHERE correo = ?', [correo]);

        if (existing.length > 0) {
            return res.status(400).json({ error: 'El correo ya está registrado' });
        }

        await pool.query('INSERT INTO persona (usuario, correo, contraseña, tipo_usuario) VALUES (?, ?, ?, ?)', [usuario, correo, contra, rol]);
        res.status(200).json({ success: true });

    } catch (err) {
        console.error('Error al registrar usuario:', err);
        res.status(500).json({ error: 'Error interno' });
    }
}

async function cerrarSesion(req, res) {
    const id_usuario = req.session.userId;

    req.session.destroy(async err => {
        if (err) {
            return res.status(500).json({ error: 'Error al cerrar sesión' });
        }
        res.clearCookie('connect.sid');

        // Registrar cierre en bitácora
        if (id_usuario) {
            const [rows] = await pool.query('SELECT tipo_usuario FROM persona WHERE id_persona = ?', [id_usuario]);
            if (rows.length > 0) {
                await registrarBitacora(id_usuario, rows[0].tipo_usuario, 'Cierre de sesión');
            }
        }

        res.status(200).json({ success: true });
    });
}

module.exports = { iniciarSesion, registrarUsuario, cerrarSesion };
