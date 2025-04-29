const express = require('express');
const router = express.Router();
const {getPZSCarroceria, getPZSMecanicas, getPZSMotor} = require('../controllers/catalogoControllers');
const { verificarAutenticacion } = require('../middleware/authMiddleware');

// Crear
//router.post('/', verificarAutenticacion, crear);

// Obtener (cliente o mecánico)
router.get('/carroceria', verificarAutenticacion, getPZSCarroceria );
router.get('/mecanicas', verificarAutenticacion, getPZSMecanicas );
router.get('/motor', verificarAutenticacion, getPZSMotor);

// Actualizar estado (solo mecánico)
//router.put('/', verificarAutenticacion, actualizarEstado);

module.exports = router;
