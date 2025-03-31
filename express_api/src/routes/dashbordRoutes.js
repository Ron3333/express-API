import  { Router } from 'express';
const router = Router();

// Ruta de ejemplo para renderizar una plantilla

router.get('/', (req, res) =>{
    res.render('dashbord.ejs', {  message: '¡DASHBORD!' })
})

router.get('/consultas', (req, res) =>{
    res.render('consultas.ejs', {  message: 'Consultas!' })
})


export {router} ;