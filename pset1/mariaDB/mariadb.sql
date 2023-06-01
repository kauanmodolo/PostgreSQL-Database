-- Kauan Modolo Carriço
-- CC1N
-- MariaDB Script

--Excluindo usuário caso ele já exista e criando o usuário:
DROP USER IF EXISTS 'kauan'@'localhost';
CREATE USER 'kauan'@'localhost' IDENTIFIED BY '9540';

--Criando o banco de dados e excluindo casa ja exista:
DROP DATABASE IF EXISTS uvv;
CREATE DATABASE uvv;

--Atribuindo privilégios ao usuário kauan:
GRANT ALL ON uvv.* TO 'kauan'@'localhost';
FLUSH PRIVILEGES;

--Usar o banco de dados:
USE uvv;


--Criar a tabela produtos:
CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                -- Constraint para permitir apenas valores maiores ou igual a 0 na coluna preco_unitario.
                preco_unitario NUMERIC(10,2) CHECK(preco_unitario >=0),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);
COMMENT ON TABLE produtos IS 'Tabela com dados acerca dos produtos disponíveis.';
COMMENT ON COLUMN produtos.produto_id IS 'Coluna com dados acerca do ID individual de cada produto.';
COMMENT ON COLUMN produtos.nome IS 'Coluna com dados acerca do nome dos produtos.';
COMMENT ON COLUMN produtos.preco_unitario IS 'Coluna com dados acerca do preco da unidade do produto.';
COMMENT ON COLUMN produtos.detalhes IS 'Coluna com dados acerca dos detalhes do produto.';
COMMENT ON COLUMN produtos.imagem IS 'Coluna com dados acerca da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Coluna com dados acerca do mime type da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Coluna com dados acerca do arquivo da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_charset IS 'Coluna com dados acerca do charset da imagem do produto.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Coluna com dados acerca da data da ultima atualizacao da imagem do produto.';

-- Criar a tabela lojas:
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                -- Constraint para que pelo menos uma das colunas (endereco_web ou endereco_fisico) seja preenchida.
                CONSTRAINT pelo_menos_uma CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL),
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas IS 'Tabela com dados acerca das lojas existentes.';
COMMENT ON COLUMN lojas.loja_id IS 'Coluna com dados acerca do ID individual de cada loja.';
COMMENT ON COLUMN lojas.nome IS 'Coluna com dados acerca do nome de cada loja.';
COMMENT ON COLUMN lojas.endereco_web IS 'Coluna com dados acerca do endereco web de cada loja que o tenha.';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Coluna com dados acerca do endereco fisico de cada loja que o tenha.';
COMMENT ON COLUMN lojas.latitude IS 'Coluna com dados acerca da latitude da loja.';
COMMENT ON COLUMN lojas.longitude IS 'Coluna com dados acerca da longitude da loja.';
COMMENT ON COLUMN lojas.logo IS 'Coluna com dados acerca do logo da loja.';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Colunas com dados acerca da mime type da logo de uma loja.';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Coluna com dados acerca do arquivo da logo de uma loja.';
COMMENT ON COLUMN lojas.logo_charset IS 'Coluna com dados acerca do charset da logo de uma loja.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Coluna com dados acerca da data da ultima atualizacao da logo de uma loja.';

-- Criar a tabela estoques:
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                -- Constraint para o valor inserido na coluna quantidade ser maior ou igual a 0.
                quantidade NUMERIC(38) NOT NULL CHECK(quantidade>=0),
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS 'Tabela com dados acerca do estoque da loja.';
COMMENT ON COLUMN estoques.estoque_id IS 'Coluna com dados acerca do ID individual do estoque.';
COMMENT ON COLUMN estoques.loja_id IS 'Coluna com dados acerca do ID individual de cada loja.';
COMMENT ON COLUMN estoques.produto_id IS 'Coluna com dados acerca do ID individual de cada produto.';
COMMENT ON COLUMN estoques.quantidade IS 'Coluna com dados acerca da quantidade de produtos no estoque.';

-- Criar a tabela clientes:
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                -- Constraint para que tenha que inserir um @ no valor da coluna email. 
                email VARCHAR(255) NOT NULL CHECK(email LIKE '%@%'),
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'Tabela com dados acerca dos clientes.';
COMMENT ON COLUMN clientes.cliente_id IS 'Coluna com dados acerca do ID individual dos clientes.';
COMMENT ON COLUMN clientes.email IS 'Coluna com dados acerca do email dos clientes.';
COMMENT ON COLUMN clientes.nome IS 'Coluna com dados acerca do nome dos clientes.';
COMMENT ON COLUMN clientes.telefone1 IS 'Coluna com dados acerca do número de telefone do cliente.';
COMMENT ON COLUMN clientes.telefone2 IS 'Coluna com dados acerca do segundo número de telefone do cliente.';
COMMENT ON COLUMN clientes.telefone3 IS 'Coluna com dados acerca do terceiro número de telefone do cliente.';

-- Criar a tabela envios:
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                -- Constraint para permitir somente os valores citados abaixo na coluna check.
                status VARCHAR(15) NOT NULL CHECK(status IN('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE')),
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios IS 'Tabela com dados acerca dos envios dos pedidos da loja.';
COMMENT ON COLUMN envios.envio_id IS 'Coluna com dados acerca do ID individual de cada envio.';
COMMENT ON COLUMN envios.loja_id IS 'Coluna com dados acerca do ID individual de cada loja.';
COMMENT ON COLUMN envios.cliente_id IS 'Coluna com dados acerca do ID individual dos clientes.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Coluna com dados acerca do endereco de entrega do envio.';
COMMENT ON COLUMN envios.status IS 'Coluna com dados acerca do status do envio efetuado.';

-- Criar a tabela pedidos:
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                -- Constraint para permitir somente os valores citados abaixo na coluna check.
                status VARCHAR(15) NOT NULL CHECK (status IN('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO')),
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE pedidos IS 'Tabela com dados acerca dos pedidos efetuados.';
COMMENT ON COLUMN pedidos.pedido_id IS 'Coluna com dados acerca do ID individual do pedido.';
COMMENT ON COLUMN pedidos.data_hora IS 'Coluna com dados acerca da data e hora da realização dos pedidos.';
COMMENT ON COLUMN pedidos.cliente_id IS 'Coluna com dados acerca do ID individual dos clientes.';
COMMENT ON COLUMN pedidos.status IS 'Coluna com dados acerca do status do pedido efetuado.';
COMMENT ON COLUMN pedidos.loja_id IS 'Coluna com dados acerca do ID individual de cada loja.';

-- Criar a tabela pedidos_itens:
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                -- Constraint para os valores inseridos nas colunas (preco_unitario e quantidade) seja maior ou igual a 0.
                preco_unitario NUMERIC(10,2) NOT NULL CHECK(preco_unitario >=0),
                quantidade NUMERIC(38) NOT NULL CHECK(quantidade >=0),
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedidos_itens IS 'Tabela com dados acerca dos itens dos pedidos.';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Coluna com dados acerca do ID individual do pedido.';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Coluna com dados acerca do ID individual de cada produto.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Coluna com dados acerca do numero da linha do item do pedido.';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Coluna com dados acerca do preco unitario do item do pedido.';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Coluna com dados acerca da quantidade de itens do pedido.';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Coluna com dados acerca do ID individual de cada envio.';

--CRIAÇÃO DAS FOREIGN KEY:
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
