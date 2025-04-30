const express = require('express');
const router = express.Router();
const { iniciarSesion, registrarUsuario, cerrarSesion } = require('../controllers/authController');

// Iniciar sesión
router.post('/iniciarsesion', iniciarSesion);

// Registrar usuario
router.post('/registrarus', registrarUsuario);

// Cerrar sesión
router.post('/cerrarsesion', cerrarSesion);

module.exports = router;
