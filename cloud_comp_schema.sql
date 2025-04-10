-- Enable UUID support
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 🔐 users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    cloud_choice TEXT CHECK (cloud_choice IN ('AWS', 'Azure', 'GCP')),
    skill_level TEXT CHECK (skill_level IN ('Beginner', 'Intermediate', 'Pro')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 📘 learning_paths
CREATE TABLE learning_paths (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    level TEXT CHECK (level IN ('Beginner', 'Intermediate', 'Pro')),
    description TEXT,
    cloud_provider TEXT CHECK (cloud_provider IN ('AWS', 'GCP', 'Azure'))
);

-- 🎯 tasks
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    path_id INT REFERENCES learning_paths(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    order_index INT NOT NULL,
    details JSON,
    has_auto_suggest BOOLEAN DEFAULT FALSE
);

-- ✅ progress
CREATE TABLE progress (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    task_id INT REFERENCES tasks(id) ON DELETE CASCADE,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP
);

-- 💬 questions_asked
CREATE TABLE questions_asked (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    question TEXT NOT NULL,
    answer TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🧠 suggestion_logs
CREATE TABLE suggestion_logs (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    suggestion TEXT NOT NULL,
    task_id INT REFERENCES tasks(id),
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
