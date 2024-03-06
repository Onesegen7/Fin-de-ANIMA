import { PrismaClient } from "@prisma/client";
import "dotenv/config";
import  jwt  from "jsonwebtoken";
const prisma = new PrismaClient();

export const getUsers = async (req, res) => {

  try {

    const users = await prisma.User.findMany();
    res.status(200).json(users);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error en el servidor, no se logro obtener el usuario" });
  }
};


export const getUserProfile = async (req, res) => {
  
  const token = req.headers.authorization;


  if (!token){
    return res.status(401).json({ message: "Token Faltante"})
  }

  //Se busca el usuario

  try {

    const data = jwt.verify(token,  process.env.JWT_ACCESS_SECRET);

    const user = await prisma.User.findUnique({
      where: {
        id: data.id,
      },
    });

    if (!user) {
      return res.status(404).json({ error: "No se encontro el usuario" });
    }

    res.status(200).json({ id: user.id, name: user.name, surname: user.surname, email: user.email, imagen: user.imagen, edad: user.edad});

  } catch (error) {

    res.status(500).json({ error: "No se logro obtener la información" });
  }
};

export const createUser = async (req, res) => {
  const { name, surname, imagen, email, contrasena, edad, celular } = req.body;

  if (!name || !surname || !email || !contrasena || !edad || !celular || !imagen) {
    return res.status(400).json({ error: "Todos los campos son requeridos" });
  }

  const usuarioExistente = await prisma.user.findUnique({ where: { email } });

  const edadInt = edad;

  if(edadInt < 18){
    return res.status(400).json({ error: "La edad debe ser mayor a 18" });
  }

  if (usuarioExistente) {
    return res.status(400).json({ mensaje: 'El correo electrónico ya está en uso' });
  }

  if(contrasena.length < 8) {
    return res.status(400).json({ mensaje: 'La constraseña debe tener al menos 8 caracteres' });
  }

  try {
    const newUser = await prisma.User.create({
      data: {
        name,
        surname,
        imagen,
        email,
        contrasena,
        edad,
        celular,
      },
    });

    res.status(201).json(newUser);
    
  } catch (error) {
    res.status(500).json({ error: "No se logro crear el usuario" });
  }
};

export const deleteUserById = async (req, res) => {

  const id = parseInt(req.params.id);

  if (isNaN(id) || id < 1) {
    return res.status(400).json({ error: "Id invalida" });
  }

  try {
    const deleteUser = await prisma.User.delete({
      where: {
        id: id,
      },
    });

    res.status(200).json({message: "El usuario se a eliminado correctamente"});

  } catch (error) {
    res.status(500).json({ error: "No se a logrado eliminar el usuario" });
  }
};

export const logIn = async (req, res) => {
  const { email, password } = req.body;
  const secretKey = process.env.JWT_ACCESS_SECRET;

  if (!email || !password){
    return res.status(400).json({ error: "Ambos campos son requeridos" });
  }

  const user = await prisma.User.findUnique({ where: { email }});

  if (!user || user.contrasena !== password){
    return res.status(401).json({ message: "credencial invalida"});
  }

  const token = jwt.sign({ id: user.id }, secretKey);
  res.json( { token: token } );

};

export const getUserByName = async (req, res) =>{
  const { name } = req.params;
  
  if (!name) {
    return res.status(400).json({ mensaje: 'El parámetro "nombre" es obligatorio' });
  }

  try {
    // Realiza la búsqueda de usuarios por nombre en la base de datos
    const user = await prisma.user.findMany({
      where: {
        name: {
          contains: name, // Puedes ajustar la búsqueda según tus necesidades
        },
      },
    });

    res.json({name: user.nombre, email: user.email});

  } catch (error) {
    res.status(500).json({ mensaje: 'Error interno del servidor' });
  }

}

export const getUserById = async (req, res) => {
  const { id } = req.params

  if(!id){
    return res.status(400).json({message: "Faltan parametros"})
  }

  try{
    const user = await prisma.User.findUnique({
      where: {
        id: id,
      },
    });

    if(!user){
      return res.status(404).json({message: "Usuario no encontrado"})
    }

    res.status(200).json({name: user.name, surname: user.surname, email: user.email, edad: user.edad})
  }catch(error){
    res.status(500).json({error: "No se a logrado obteener el usuario"})
  }
};

