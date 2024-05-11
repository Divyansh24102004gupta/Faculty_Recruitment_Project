import multer from "multer";
import { nanoid } from 'nanoid'

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, "./public/temp")
    },
    filename: function (req, file, cb) {
      // console.log(file.originalname+Date.now());
      cb(null, file.originalname+nanoid())
    }
  })
  
export const upload = multer({ 
    storage, 
})