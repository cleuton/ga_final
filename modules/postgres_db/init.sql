CREATE TABLE IF NOT EXISTS exemplo (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    valor INT
);

INSERT INTO exemplo(nome, valor)
SELECT 'fulano', '500'
WHERE
NOT EXISTS (
SELECT * FROM exemplo WHERE valor = 500
);

INSERT INTO exemplo(nome, valor)
SELECT 'beltrano', '600'
WHERE
NOT EXISTS (
SELECT * FROM exemplo WHERE valor = 600
);

