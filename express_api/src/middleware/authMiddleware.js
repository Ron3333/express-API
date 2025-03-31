import jwt from 'jsonwebtoken';

const authMiddleware = (req, res, next) => {
    // 1. Verificar el header Authorization
    // 2. Verificar query parameters (token en URL)
    // 3. Verificar cookies (si las usas)
    const token = req.cookies.token;
    //const token = req.header('Authorization')?.replace('Bearer ', '') || req.query.token || req.cookies?.token;

    console.log("Token recibido:", token); // Para depuración

    if (!token) {
        console.log("Acceso denegado: No se encontró token");
        return res.status(401).json({ error: 'Acceso denegado. Token no proporcionado.' });
    }

    try {
        const decoded = jwt.verify(token, 'secreto');
        req.user = decoded;
        // Opcional: Guardar el token en cookies para futuras solicitudes
        //res.cookie('token', token, { httpOnly: true, secure: process.env.NODE_ENV === 'production' }); 
        next();
    } catch (error) {
        console.error("Error verificando token:", error);
        res.clearCookie('token'); // Limpiar cookie inválida
        res.status(401).json({ error: 'Token inválido o expirado' });
    }
};

export { authMiddleware };