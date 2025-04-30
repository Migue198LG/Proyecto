const express = require('express');
const router = express.Router();
const { crearCita, obtenerMisCitas, actualizarEstadoCita } = require('../controllers/citaController');
const { verificarAutenticacion } = require('../middleware/authMiddleware');

// Crear cita
router.post('/', verificarAutenticacion, crearCita);

// Obtener citas (cliente o mecánico)
router.get('/', verificarAutenticacion, obtenerMisCitas);

// Actualizar estado de cita (solo mecánico)
router.put('/', verificarAutenticacion, actualizarEstadoCita);

module.exports = router;
