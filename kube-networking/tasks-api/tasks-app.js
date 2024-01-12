const path = require('path');
const fs = require('fs');

const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');

const filePath = path.join(__dirname, process.env.TASKS_FOLDER, 'tasks.txt');
const taskDelimiter = 'TASK_SPLIT';

const app = express();

app.use(bodyParser.json());

app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST,GET,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization');
  next();
})

const extractAndVerifyToken = async (headers) => {
  if (!headers.authorization) {
    throw new Error('No token provided.');
  }
  const token = headers.authorization.split(' ')[1]; // expects Bearer TOKEN

  const response = await axios.get(`http://${process.env.AUTH_ADDRESS}/verify-token/` + token);
  return response.data.uid;
};

app.get('/tasks', async (req, res) => {
  try {
    const uid = await extractAndVerifyToken(req.headers); // we don't really need the uid
    const data = fs.readFileSync(filePath, 'utf8');
    const entries = data.split(taskDelimiter);
    entries.pop(); // remove last, empty entry
    console.log(entries);
    const tasks = entries.map((json) => JSON.parse(json));
    res.status(200).json({ message: 'Tasks loaded.', tasks: tasks });
  } catch (err) {
    console.log(err);
    return res.status(401).json({ message: err.message || 'Failed to load tasks.' });
  }
});

app.post('/tasks', async (req, res) => {
  try {
    const uid = await extractAndVerifyToken(req.headers); // we don't really need the uid
    const text = req.body.text;
    const title = req.body.title;
    const task = { title, text };
    const jsonTask = JSON.stringify(task);
    fs.appendFileSync(filePath, jsonTask + taskDelimiter, 'utf8');
    res.status(201).json({ message: 'Task stored.', createdTask: task });
  } catch (err) {
    return res.status(401).json({ message: 'Could not verify token.' });
  }
});

app.listen(8000);
