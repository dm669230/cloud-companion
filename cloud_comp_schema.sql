-- Enable UUID support
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 🔐 users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    cloud_choice VARCHAR(50) CHECK (cloud_choice IN ('AWS', 'Azure', 'GCP')),
    skill_level VARCHAR(50) CHECK (skill_level IN ('Beginner', 'Intermediate', 'Pro')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    salt VARCHAR(255) NOT NULL
);


-- 📘 learning_paths
CREATE TABLE learning_paths (
    id SERIAL PRIMARY KEY,
    title VARCHAR NOT NULL,
    level VARCHAR CHECK (level IN ('Beginner', 'Intermediate', 'Pro')),
    description VARCHAR,
    cloud_provider VARCHAR CHECK (cloud_provider IN ('AWS', 'GCP', 'Azure'))
);

-- 🎯 tasks
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    path_id INT REFERENCES learning_paths(id) ON DELETE CASCADE,
    title VARCHAR NOT NULL,
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
    question VARCHAR NOT NULL,
    answer VARCHAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🧠 suggestion_logs
CREATE TABLE suggestion_logs (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    suggestion VARCHAR NOT NULL,
    task_id INT REFERENCES tasks(id),
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
