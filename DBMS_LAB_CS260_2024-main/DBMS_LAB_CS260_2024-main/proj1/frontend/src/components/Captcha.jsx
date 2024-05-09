import React, { useState } from 'react';

function Captcha({captcha}) {
  const [captchaText, setCaptchaText] = useState(generateRandomText());
  captcha(captchaText);
  // Function to generate a random text string (you can customize this)
  function getRandomValue() {
    return Math.floor(Math.random() * 4) + 6;
  }

  function generateRandomText() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    for (let i = 0; i < getRandomValue(); i++) {
      const randomIndex = Math.floor(Math.random() * characters.length);
      result += characters.charAt(randomIndex);
    }
    return result;
  }

  return (
      <div className="captcha-text text-white font-bold tracking-widest text-xl text-center p-1">
        {captchaText}
        </div>
  );
}

export default Captcha;
