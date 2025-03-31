import express from 'express';
import { register, login, rol } from '../controllers/authController.js';

const router = express.Router();

router.post('/register', register);
router.post('/login', login);
router.get('/rol', rol);

router.post('/logout', (req, res) => {
    res.clearCookie('token', {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        path: '/'
    });
    res.json({ message: 'Sesión cerrada correctamente' });
});

export { router };