const express = require('express');
const session = require('express-session');
const path = require('path');
const dotenv = require('dotenv');
dotenv.config();

const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const bitacoraRoutes = require('./routes/bitacoraRoutes');
const citaRoutes = require('./routes/citaRoutes');
const catalogoRoutes = require('./routes/catalogoRoutes');

const app = express();
const PORT = process.env.PORT || 8080;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true
}));

// Rutas
app.use('/', authRoutes);
app.use('/usuario', userRoutes);
app.use('/bitacora', bitacoraRoutes);
app.use('/citas', citaRoutes);
app.use('/catalogo', catalogoRoutes);

// Rutas de inicio
app.get('/', (req, res) => res.sendFile('index.html', { root: 'public' }));
app.get('/iniciar-sesion', (req, res) => res.sendFile('index.html', { root: 'public' }));
app.get('/cliente', (req, res) => res.sendFile('cliente/inicio_cliente.html', { root: 'public' }));
app.get('/mecanico', (req, res) => res.sendFile('mecanico/inicio_mecanico.html', { root: 'public' }));

app.listen(PORT, () => {
    console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
