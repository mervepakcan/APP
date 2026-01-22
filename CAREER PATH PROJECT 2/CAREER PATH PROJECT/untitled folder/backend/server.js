import { GoogleGenerativeAI } from "@google/generative-ai";
import express from "express";
import mysql from "mysql2/promise";
import dotenv from "dotenv";
import cors from "cors";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// ✅ Gemini AI Configuration
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-pro" });

// ✅ Database Connection
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: Number(process.env.DB_PORT || 3306),
  connectionLimit: 10,
});

// ✅ Health check
app.get("/api/health", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT 1 AS ok");
    res.json({ ok: true, db: rows[0].ok });
  } catch (err) {
    res.status(500).json({ error: "Database error" });
  }
});

// ✅ Gemini AI Chat Route (Sadece bu kalmalı)
app.post("/api/chat", async (req, res) => {
  try {
    const { message } = req.body;
    if (!message) return res.status(400).json({ error: "Message is required" });

    // AI instruction added here to keep it English and professional
    const prompt = `You are a professional career assistant. Provide short, concise, and motivating advice. Respond ONLY in English. User says: ${message}`;
    
    const result = await model.generateContent(prompt);
    const response = await result.response;
    res.json({ reply: response.text() });
  } catch (error) {
    console.error("Gemini Error:", error);
    res.status(500).json({ error: "AI is busy, please try again later." });
  }
});

// ✅ Register
app.post("/api/register", async (req, res) => {
  const { email, password } = req.body;
  const [exists] = await pool.query("SELECT UserID FROM Users WHERE Email = ?", [email]);
  if (exists.length) return res.status(409).json({ error: "Email already registered" });

  const username = email.split("@")[0];
  const [result] = await pool.query(
    "INSERT INTO Users (Username, Email, Password, UserRole, UserStatus) VALUES (?, ?, ?, 'User', 'Active')",
    [username, email, password]
  );
  res.json({ ok: true, userId: result.insertId });
});

// ✅ Login
app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;
  const [rows] = await pool.query("SELECT UserID, Password FROM Users WHERE Email = ? LIMIT 1", [email]);
  if (!rows.length || password !== rows[0].Password) return res.status(401).json({ error: "Invalid credentials" });
  res.json({ ok: true, userId: rows[0].UserID });
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Backend running at http://localhost:${PORT}`));