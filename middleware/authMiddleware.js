function verificarAutenticacion(req, res, next) {
    if (req.session && req.session.userId) {
        return next();
    } else {
        return res.status(401).json({ error: 'No autenticado' });
    }
}

module.exports = { verificarAutenticacion };
