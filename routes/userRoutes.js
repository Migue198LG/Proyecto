const express = require('express');
const router = express.Router();
const { obtenerPerfil, actualizarPerfil } = require('../controllers/userController');
const { verificarAutenticacion } = require('../middleware/authMiddleware');

// Obtener perfil
router.get('/perfil', verificarAutenticacion, obtenerPerfil);

// Actualizar perfil
router.put('/perfil', verificarAutenticacion, actualizarPerfil);

module.exports = router;
