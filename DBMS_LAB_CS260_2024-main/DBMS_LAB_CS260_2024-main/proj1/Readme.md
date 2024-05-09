Steps:

1. Go to the backend folder in the terminal and write npm install
2. Go to the frontend folder in the terminal and write npm install
3. Go to the backend folder and inside this folder create one .env file
4. Inside .env file and write all this:
   PORT = 8000
   DB_PASSWORD=<mongodb connection string>
   CORS_ORIGIN=\*
   ACCESS_TOKEN_SECRET=lajoirijt //can also enter random string
   ACCESS_TOKEN_EXPIRY=1d
   REFRESH_TOKEN_SECRET=kjokkqAAA //can also enter random string
   REFRESH_TOKEN_EXPIRY=10d
   MAIL_ID=<gmail from which you want to send mail while resetting the password>
   MAIL_PASSWORD=<gmail app password of the above entered mail>
   //will be available after making account on cloudinary  
    CLOUDINARY_CLOUD_NAME=<cloudinary name>
   CLOUDINARY_API_KEY=<cloudinary api key>
   CLOUDINARY_API_SECRET=<cloudinary api secret>

5. go to the terminal and write docker compose up
6. go to browser and search for http://localhost:5173/
