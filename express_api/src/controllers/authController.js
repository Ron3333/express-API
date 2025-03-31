import { pool } from '../config/db.js';
import jwt  from 'jsonwebtoken';
import bcrypt  from 'bcryptjs';

async function register(req, res){
    try {

      const {nombre, email, password, rol } = req.body;
      const [existingUsers] = await pool.query("SELECT * FROM usuarios WHERE email = ?", [email,]);
 
      if(existingUsers.length > 0){
            return res.status(400).json({ message: `El email ${email} ya está registrado` });
        }
      const [rows] = await pool.query("INSERT INTO usuarios (nombre, email, password, rol) VALUES (?, ?, ?, ?)", [nombre, email, password, rol]);
      res.status(201).json({ id: rows.insertId,nombre, email, password, rol });
    } catch (error) {
        console.log(error);
        return res.status(500).json({ message: "Something goes wrong" });
    }
  };
/*
  async function login(req, res) {
    try {
        const { email, password } = req.body;
        const [rows] = await pool.query("SELECT * FROM usuarios WHERE email = ?", [email]);
    
        if (rows.length !== 1) {
            return res.status(400).json({ error: 'Credenciales inválidas' });
        }

        const user = rows[0];
        
        // Comparación directa de contraseña (sin hash por ahora)
        if (user.password !== password) {
            return res.status(400).json({ error: 'Credenciales inválidas' });
        }

        // Si usaras bcrypt (recomendado):
        // const passwordMatch = await bcrypt.compare(password, user.password);
        // if (!passwordMatch) {
        //     return res.status(400).json({ error: 'Credenciales inválidas' });
        // }

        const token = jwt.sign({ id: user.id, rol: user.rol }, 'secreto', { expiresIn: '6h' });
        res.json({ token });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error en el servidor' });
    }
}
*/
  async function login(req, res){
  try {
    const { email, password } = req.body;
    const [rows] = await pool.query("SELECT * FROM usuarios WHERE email = ? ", [email,]);
  
    if(rows.length !== 1 ){
        throw new Error('Credenciales inválidas'); 
    }

    const user = rows[0];
    if(rows.password == password ){
      throw new Error('Password inválido'); 
    }

    // 3. Comparar contraseña con hash (usando bcrypt)
    /*
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      throw new Error('Credenciales inválidas');
    }
    */

    const token = jwt.sign({ id: user.id, rol: user.rol }, 'secreto', { expiresIn: '6h' });

     // 3. Establecer cookie HTTP-Only
     res.cookie('token', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // Solo HTTPS en producción
      sameSite: 'strict', // Protección contra CSRF
      maxAge: 2 * 60 * 60 * 1000, // 2 horas (debe coincidir con la expiración del JWT)
      path: '/', // Accesible en todas las rutas
    });

    res.json({ 
      message: 'Login exitoso',
      user: { id: user.id, email: user.email, rol: user.rol }
     });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

async function rol(req, res){
  try {
      const [rows] = await pool.query("SELECT nombre FROM rol");
      res.json(rows);
    } catch (error) {
      return res.status(500).json({ message: "Something goes wrong" });
    }
}

export { register, login, rol };