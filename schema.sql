-- PostgreSQL / Neon
-- Chỉ sử dụng VND nguyên.
-- Hash mật khẩu trong ứng dụng trước khi lưu.
-- Schema cho database mới, không phải migration cho dữ liệu hiện có.

CREATE TABLE users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT NOT NULL UNIQUE
        CHECK (length(trim(username)) > 0),
    email TEXT NOT NULL UNIQUE
        CHECK (length(trim(email)) > 0),
    password_hash TEXT NOT NULL
        CHECK (length(trim(password_hash)) > 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE wallets (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    name TEXT NOT NULL CHECK (length(trim(name)) > 0),
    opening_balance BIGINT NOT NULL DEFAULT 0
        CHECK (opening_balance >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE (user_id, name),
    UNIQUE (user_id, id)
);

CREATE TABLE categories (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    name TEXT NOT NULL CHECK (length(trim(name)) > 0),
    type TEXT NOT NULL CHECK (type IN ('income', 'expense')),

    UNIQUE (user_id, name, type),
    UNIQUE (user_id, id, type)
);

CREATE TABLE transactions (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id),
    wallet_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
    amount BIGINT NOT NULL CHECK (amount > 0),
    note TEXT,
    occurred_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id, wallet_id)
        REFERENCES wallets (user_id, id),

    FOREIGN KEY (user_id, category_id, type)
        REFERENCES categories (user_id, id, type)
);