/* 
COMANDOS DO SQL 

-- CREATE DATABASE - CRIA UM BANCO DE DADOS
-- CREATE TABLE - CRIA UMA TABELA 
-- USE - INICIA  A EXECUÇÃO DO BANCO DE DADOS 



-- EXECLUÇÃO:
	 DROP DATABESE - SERVE PARA EXCLUIR BANCO DE DADOS 
	 DROP TABLE  - EXCLUIR TABELAS 
-- PODE SER EXCLUIDA MAIS DE UMA TABELA SIMPLISMENTE USANDO A ","

O DROP TABLE SO VAI FUNCIONAR SE ELE TIVER NÃO EM RELACIONAMENTO COM OUTRA TABELA CONECTADA NELA

-- SELECT - VIZUALIZAR OS DADOS REGISTRADOS DENTRO DA TABELA 


--INSERT  - CADASTRAR DADOS DENTERO DA TABELA 
insert into nome da tabela (campo1, campo2, campo3)
values("", 1.2, 4 )





*/




DROP DATABASE deliverynicoleshow;
CREATE DATABASE deliverynicoleshow
DEFAULT CHARACTER SET = utf8mb4
DEFAULT COLLATE = utf8mb4_unicode_ci;
 

USE deliverynicoleshow;


-- Cliente
CREATE TABLE Clientecliente(
  idCliente INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  cpf VARCHAR(20) NOT NULL UNIQUE,           -- usa string (com zeros/formatacao)
  telefone VARCHAR(25),
  email VARCHAR(200) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,               -- armazene hash (bcrypt)
  foto_perfil LONGBLOB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Endereço
CREATE TABLE Endereco (
  idEndereco INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  cep VARCHAR(15) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  estado VARCHAR(50) NOT NULL,
  numero VARCHAR(20) NOT NULL,
  logradouro VARCHAR(255) NOT NULL,
  complemento VARCHAR(255) NOT NULL,
  bairro VARCHAR(100) NOT NULL,
  tipo ENUM('residencial','comercial','outro') DEFAULT 'residencial',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Ligação Cliente <-> Endereco (muitos-para-muitos)
CREATE TABLE Cliente_e_Endereco (
  cliente_idCliente INT UNSIGNED,
  endereco_idEndereco INT UNSIGNED,
  PRIMARY KEY (cliente_idCliente, endereco_idEndereco),
  FOREIGN KEY (cliente_idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (endereco_idEndereco) REFERENCES Endereco(idEndereco) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Categorias de produtos
CREATE TABLE Categorias_produtos(
  idCategoria INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  descontos DECIMAL(10,2) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Banners (marketing)
CREATE TABLE Banners (
  idBanners INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  imagem LONGBLOB,
  data_validade DATE,
  descricao VARCHAR(255),
  link VARCHAR(255),
  categoriasProdutos_id INT UNSIGNED,
  FOREIGN KEY (categoriasProdutos_id) REFERENCES Categorias_produtos(idCategoria) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Cupons
CREATE TABLE Cupom(
  idCupom INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  valor DECIMAL(10,2),
  data_validade DATE,
  quantidade INT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Formas de pagamento
CREATE TABLE Formas_pagamento (
  idFormas_pagamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  codigo VARCHAR(50) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Fretes (tabela de tabelas/valores de frete; opcional)
CREATE TABLE Fretes (
  idfretes INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  bairro VARCHAR(100),
  valor DECIMAL(10,2) DEFAULT 0,
  transportadora VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Marcas
CREATE TABLE Marcas (
  idMarcas INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  imagem VARCHAR(255) NULL   -- recomendo armazenar URL/caminho em vez de blob grande
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Produtos
CREATE TABLE Produtos (
  idProdutos INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  descricao TEXT,
  quantidade INT UNSIGNED DEFAULT 0,
  preco DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  tamanho VARCHAR(45),
  codigo VARCHAR(50) UNIQUE,
  preco_promocional DECIMAL(10,2) DEFAULT NULL,
  Marcas_idMarcas INT UNSIGNED,
  FOREIGN KEY (Marcas_idMarcas) REFERENCES Marcas(idMarcas) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Imagens de Produtos
CREATE TABLE Imagem_produtos (
  idImagem_produtos INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  foto LONGBLOB,
  texto_alternativo VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Produto <-> Imagem (N:N)
CREATE TABLE Produtos_has_Imagem_produtos (
  Produtos_idProdutos INT UNSIGNED,
  Imagem_produtos_idImagem_produtos INT UNSIGNED,
  PRIMARY KEY (Produtos_idProdutos, Imagem_produtos_idImagem_produtos),
  FOREIGN KEY (Produtos_idProdutos) REFERENCES Produtos(idProdutos) ON DELETE CASCADE,
  FOREIGN KEY (Imagem_produtos_idImagem_produtos) REFERENCES Imagem_produtos(idImagem_produtos) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Produto <-> Categoria (N:N)
CREATE TABLE Produtos_e_Categorias_produtos (
  Produtos_idProdutos INT UNSIGNED,
  Categorias_idCategoria INT UNSIGNED,
  PRIMARY KEY (Produtos_idProdutos, Categorias_idCategoria),
  FOREIGN KEY (Produtos_idProdutos) REFERENCES Produtos(idProdutos) ON DELETE CASCADE,
  FOREIGN KEY (Categorias_idCategoria) REFERENCES Categorias_produtos(idCategoria) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Vendas / Pedidos
CREATE TABLE Vendas (
  idVendas INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,       -- quando veio o pedido
  data_entrega DATETIME DEFAULT NULL,                 -- previsão/real entrega
  valor_frete DECIMAL(10,2) DEFAULT 0.00,
  valor_produto DECIMAL(10,2) DEFAULT 0.00,
  valor_total DECIMAL(10,2) DEFAULT 0.00,
  valor_total_desconto DECIMAL(10,2) DEFAULT 0.00,
  situacao ENUM('pendente','confirmado','preparando','a_caminho','entregue','cancelado') DEFAULT 'pendente',
  cod_rastreio VARCHAR(100) DEFAULT NULL,
  Cliente_idCliente INT UNSIGNED NOT NULL,
  Formas_pagamento_idFormas_pagamento INT UNSIGNED,
  Cupom_idCupom INT UNSIGNED,
  Fretes_idfretes INT UNSIGNED,
  endereco_idEndereco INT UNSIGNED,   -- FK para endereço escolhido
  -- Snapshot do endereço no momento do pedido (recomendado para histórico)
  entrega_logradouro VARCHAR(255),
  entrega_numero VARCHAR(20),
  entrega_bairro VARCHAR(100),
  entrega_cep VARCHAR(15),
  FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente) ON DELETE RESTRICT,
  FOREIGN KEY (Formas_pagamento_idFormas_pagamento) REFERENCES Formas_pagamento(idFormas_pagamento) ON DELETE SET NULL,
  FOREIGN KEY (Cupom_idCupom) REFERENCES Cupom(idCupom) ON DELETE SET NULL,
  FOREIGN KEY (Fretes_idfretes) REFERENCES Fretes(idfretes) ON DELETE SET NULL,
  FOREIGN KEY (endereco_idEndereco) REFERENCES Endereco(idEndereco) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Itens do pedido (Vendas <-> Produtos) — guarda preço no momento e subtotal
CREATE TABLE Vendas_has_Produtos (
  Vendas_idVendas INT UNSIGNED,
  Produtos_idProdutos INT UNSIGNED,
  quantidade INT UNSIGNED NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL,    -- preço unitário no momento do pedido
  subtotal DECIMAL(10,2) NOT NULL,      -- unit_price * quantidade
  PRIMARY KEY (Vendas_idVendas, Produtos_idProdutos),
  FOREIGN KEY (Vendas_idVendas) REFERENCES Vendas(idVendas) ON DELETE CASCADE,
  FOREIGN KEY (Produtos_idProdutos) REFERENCES Produtos(idProdutos) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Índices úteis (exemplos)
CREATE INDEX idx_cliente_email ON Cliente(email);
CREATE INDEX idx_produtos_codigo ON Produtos(codigo);
CREATE INDEX idx_vendas_cliente ON Vendas(Cliente_idCliente);
CREATE INDEX idx_produtos_marca ON Produtos(Marcas_idMarcas);




insert into Cliente(nome,cpf,email,senha,telefone)
values("Gabriel Lemos", "07639227143", "lemosbgabriel@gmail.com", "Lemos123", "63991300213");
select * FROM Cliente;

-- comando para alterar o cpf do tipo int para varcha
alter table Cliente modify cpf varchar(11) unique;


-- ISERINDO DADOS NA TABELA ENDERECO 
INSERT INTO Endereco(cep,cidade,estado,numero,logradouro,complementoendereco,bairro,tipo)
VALUES (770807040, "Araguaína", "TO", "1051", "Rua bela Vista", "Casa com muro azul", "São João", "Casa");
ALTER TABLE Endereco ADD complementoendereco VARCHAR(100);
select * FROM Endereco;

-- CONECTANDO O CLIENTE COM O SEU ENDEREÇO
insert into	Cliente_e_Endereco( cliente_idCliente,endereco_idEndereco) values(1, 3);

SELECT * FROM Cliente_e_Endereco;


-- INSERINDO MARCAS 
INSERT INTO Marcas (nome, imagem)
VALUES 
('Nestlé', 'https://www.google.com/imgres?q=nestle&imgurl=https%3A%2F%2Fdestro.fbitsstatic.net%2Fimg%2Fp%2Fchocolate-nestle-classic-duo-em-barra-80g-83971%2F270526.jpg%3Fw%3D500%26h%3D500%26v%3D202501231555%26qs%3Dignore&imgrefurl=https%3A%2F%2Fwww.destromacro.com.br%2Fproduto%2Fchocolate-nestle-classic-duo-em-barra-80g-83971&docid=L-zYOLQgPFJ-pM&tbnid=EQKLbYgvOvIpsM&vet=12ahUKEwjd8fTQheOPAxXhrJUCHeuKH0IQM3oECBkQAA..i&w=500&h=500&hcb=2&ved=2ahUKEwjd8fTQheOPAxXhrJUCHeuKH0IQM3oECBkQAA'),
('Coca-Cola', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.bebidastissot.com.br%2Frefrigerantes%2Fcoca-cola-lata-350ml-12-und%3Fsrsltid%3DAfmBOoqb47v0_oOKg42udHEXZWq_-6jWd6sEX79HxwoO4YA19ncwfsdY&psig=AOvVaw21bV8iOyeU9AMPcb6rLWzB&ust=1758310115632000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCID6sOGF448DFQAAAAAdAAAAABAE');

select * from Marcas;
alter table Marcas modify imagem longblob;

-- INSERINDO PRODUTOS PARA A TABELA DE PRODUTOS
INSERT INTO Produtos (nome, descricao, quantidade, preco, tamanho, codigo, preco_promocional, Marcas_idMarcas)
VALUES
('Chocolate Meio Amargo', 'Chocolate meio amargo 150g', 30, 15.00, '150g', 'CHOC150', NULL, 1),
('Refrigerante Coca-Cola 350ml', 'Lata de refrigerante', 100, 5.00, '350ml', 'COCA350', 4.50, 2);

select * from Produtos;

