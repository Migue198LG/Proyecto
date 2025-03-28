const express = require("express");
const mysql = require("mysql2");
var bodyParser = require('body-parser');
const session = require('express-session');
const path = require('path');
var app = express();

let port = 8080;
let userId = null;

var con = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'n0m3l0',
    database: 'mech'
});

con.connect((err) => {
    if (err) {
        console.log("No se conectó a la base de datos");
        console.log(err);
        return;
    }
    console.log("Conectado a la base de datos");
});

// Servir la carpeta 'public' como archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));

// Ruta para acceder a un archivo HTML específico si lo necesitas
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});


// Configuración de sesión
app.use(session({
    secret: 'clave_secreta',
    resave: false,
    saveUninitialized: true
}));

app.use(express.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Middleware de autenticación
function verificarAutenticacion(req, res, next) {
    if (req.session && req.session.userId) {
        return next();
    } else {
        console.log('Redirigiendo a iniciar sesión');
        res.redirect('/iniciar-sesion');
    }
}

// Rutas protegidas para cliente y mecánico
app.get('/cliente/:archivo', verificarAutenticacion, (req, res) => {
    const archivo = req.params.archivo;
    res.sendFile(path.join(__dirname, 'public', 'cliente', archivo));
});

app.get('/mecanico/:archivo', verificarAutenticacion, (req, res) => {
    const archivo = req.params.archivo;
    res.sendFile(path.join(__dirname, 'public', 'mecanico', archivo));
});

// Rutas de sesión y registro
app.get('/verificar-sesion', (req, res) => {
    if (req.session && req.session.usuario) {
        res.status(200).json({ autenticado: true });
    } else {
        res.status(401).json({ autenticado: false });
    }
});

app.post('/iniciarsesion', (req, res) => {
    const correo_i = req.body.correo_i;
    const contra_i = req.body.contra_i;

    if (!correo_i || !contra_i) {
        return res.status(400).json({ error: "Por favor, completa todos los campos." });
    }

    // Consultamos si el correo y la contraseña coinciden
    con.query('SELECT id_persona, correo, tipo_usuario FROM persona WHERE correo = ? AND contraseña = ?', [correo_i, contra_i], (err, respuesta) => {
        if (err) {
            console.log('ERROR: ', err);
            return res.status(500).json({ error: "Error al consultar la base de datos" });
        }

        if (respuesta.length > 0) {
            req.session.userId = respuesta[0].id_persona;

            // Revisamos el tipo de usuario
            if (respuesta[0].tipo_usuario === 'mecanico') {
                res.status(200).json({ message: "Inicio de sesión exitoso", redirectTo: "/mecanico" });
            } else {
                res.status(200).json({ message: "Inicio de sesión exitoso", redirectTo: "/cliente" });
            }
        } else {
            res.status(400).json({ error: "Credenciales incorrectas" });
        }
    });
});

app.post('/registrarus', (req, res) => {
    const correo_i = req.body.correo;
    const contra_i = req.body.contra;
    const usuario_i = req.body.usuario;
    const rol_i = req.body.rol; // Se recibe como 'cliente' o 'mecanico'

    if (!correo_i || !contra_i || !usuario_i || !rol_i) {
        return res.status(400).json({ error: "Todos los campos son requeridos." });
    }

    // Verificar si el correo ya está registrado
    con.query('SELECT * FROM persona WHERE correo = ?', [correo_i], (err, result) => {
        if (err) {
            console.log("ERROR: ", err);
            return res.status(500).json({ error: 'Error al consultar la base de datos' });
        }

        if (result.length > 0) {
            return res.status(400).json({ error: 'El correo ya está registrado' });
        }

        // Insertar el nuevo usuario en la base de datos
        const query = 'INSERT INTO persona (usuario, correo, contraseña, tipo_usuario) VALUES (?, ?, ?, ?)';
        con.query(query, [usuario_i, correo_i, contra_i, rol_i], (err, result) => {
            if (err) {
                console.log("ERROR: ", err);
                return res.status(500).json({ error: 'Error al registrar el usuario' });
            }

            // Responder con éxito
            res.status(200).json({ success: true });
        });
    });
});

app.post('/cerrarsesion', (req, res) => {
    req.session.destroy(err => {
        if (err) {
            console.error('Error al destruir la sesión:', err);
            return res.status(500).json({ success: false, error: "Error al cerrar sesión" });
        }
        res.clearCookie('connect.sid'); // Esto elimina la cookie de sesión
        res.status(200).json({ success: true, message: "Sesión cerrada correctamente" });
    });
});

// Rutas públicas
app.get('/dashboard', (req, res) => {
    if (req.session.userId) {
        res.sendFile(path.join(__dirname, 'public', 'dashboard.html'));
    } else {
        res.redirect('/iniciar-sesion');
    }
});

app.get('/iniciar-sesion', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/mecanico', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'mecanico', 'inicio_mecanico.html'));
});

app.get('/cliente', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'cliente','inicio_cliente.html'));
});

// Middleware que redirige a login si no está autenticado
app.use((req, res, next) => {
    const rutasPublicas = ['/iniciar-sesion', '/verificar-sesion', '/registrarus', '/cerrarsesion'];
    if (!rutasPublicas.includes(req.path) && (!req.session || !req.session.userId)) {
        console.log('Redirigiendo a iniciar sesión desde middleware');
        return res.redirect('/iniciar-sesion');
    }
    next();
});

app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});
