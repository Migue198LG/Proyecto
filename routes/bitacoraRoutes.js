const express = require('express');
const router = express.Router();
const { verificarAutenticacion } = require('../middleware/authMiddleware');
const { obtenerBitacoraCliente, obtenerBitacoraMecanico } = require('../controllers/bitacoraController');

// Bitácora del cliente
router.get('/cliente', verificarAutenticacion, obtenerBitacoraCliente);

// Bitácora del mecánico
router.get('/mecanico', verificarAutenticacion, obtenerBitacoraMecanico);

module.exports = router;
