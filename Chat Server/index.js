const express = require('express');
var http=require('http');

const app = express();
const port=process.env.PORT || 5000;
var server=http.createServer(app);

var io=require("socket.io")(server);

//middleware
app.use(express.json());


//Connection on socket.io
io.on("connection",(socket)=>{
    console.log("connected");
    console.log(socket.id,"has joined");
    socket.on("/test",(msg)=>{
        console.log(msg);
    })
})

//listening server on the port
server.listen(port,()=>{
    console.log("server started");
})