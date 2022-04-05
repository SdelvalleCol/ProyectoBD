const express = require('express');
const router = express.Router();
const path = require('path');
const pool = require('../db/database');
const byscriptjs = require('bcryptjs');
const notifier = require('node-notifier');
var async = require('async');
const { response } = require('express');
const { json } = require('body-parser');

// GENERAL

// Redirección de rutas 

//HOME
router.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../home/login.html'));
})

router.get('/home', (req, res) => {
    res.sendFile(path.join(__dirname, '../home/home.html'));
})

module.exports =router