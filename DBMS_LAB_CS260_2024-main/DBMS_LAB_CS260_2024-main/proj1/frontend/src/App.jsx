import './App.css'
import Login from './pages/Login.jsx';
import Signup from './pages/SignUp.jsx';
import Toast from './pages/Toast.jsx';
import ResetPassword from './pages/ResetPassword.jsx'
import ResetPasswordchange from './pages/ResetPasswordchange.jsx'
import Form1 from './pages/Form1.jsx';
import Form2 from './pages/Form2.jsx';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { useEffect, useState } from 'react';
import axios from 'axios';
import Form3 from './pages/Form3.jsx';
import Form6 from './pages/Form6.jsx';
import Form5 from './pages/Form5.jsx';
import Form4 from './pages/Form4.jsx';
import Form7 from './pages/Form7.jsx';
import Form8 from './pages/Form8.jsx';
import Changepassword from './pages/Changepassword.jsx';
import FinalDeclaration from './pages/FinalDeclaration.jsx';
import PDF from './pages/PDF.jsx';


function App() {

  return (
    <>
      <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login/>}/>
        <Route path="register" element={<Signup/>}/>
        <Route path="/form1" element={<Form1/>}/>
        <Route path="toast" element={<Toast/>}/>
        <Route path="resetpassword" element={<ResetPassword/>}/>
        <Route path="reset-password/:id/:token" element={<ResetPasswordchange/>}/>
        <Route path="change-password" element={<Changepassword/>}/>
        <Route path="/form2" element={<Form2/>}/>
        <Route path="/form3" element={<Form3/>}/>
        <Route path="/form6" element={<Form6/>}/>
        <Route path="/form5" element={<Form5/>}/>
        <Route path="/form4" element={<Form4/>}/>
        <Route path="/form7" element={<Form7/>}/>
        <Route path="/form8" element={<Form8/>}/>
        <Route path="/finaldeclaration" element={<FinalDeclaration/>}/>
        <Route path="/pdf" element={<PDF/>}/>

      </Routes>
      </BrowserRouter>
    </>
  )
}

export default App
