/* Observação: Fiquei em dúvida se você já deixaria um ambiente preparado para só colocar os scripts de criação 
de tabela ou se queria também os scripts de criação de banco de dados e esquema, então deixei no comentário e 
peço que caso seja necessário use o script do comentário abaixo para criar o BD e o esquema.
Para a criação da base de dados e schema:
CREATE DATABASE uvv;
COMMENT ON DATABASE uvv
    IS 'criação da database uvv.';
CREATE SCHEMA elmasri
    AUTHORIZATION nicolas;
COMMENT ON SCHEMA elmasri
    IS 'criação do schema ''elmasri'' com autorização para meu usuário ''nicolas''.';
SELECT CURRENT_SCHEMA();
SHOW SEARCH_PATH;
SET SEARCH_PATH TO elmasri, "$user", public;
SHOW SEARCH_PATH; 
ALTER USER nicolas
SET SEARCH_PATH TO elmasri, "$user", public;
*/

-- Tabela das informações dos funcionarios.
create table funcionario(
cpf char(11) not null, 
nome varchar(15) not null,
nome_meio char(1),
ultimo_nome varchar(15) not null,
data_nascimento date,
endereco varchar(30),
sexo char(1),
salario decimal(10,2),
cpf_supervisor char(11) not null,
numero_departamento integer not null,
primary key (cpf)
/*
 criando tabela funcionário sem as foreign keys pois serão colocadas depois.
*/
);

comment on column elmasri.funcionario.cpf is 'Cpf do funcionário e PK da tabela';
comment on column elmasri.funcionario.nome is 'Primeiro nome';
comment on column elmasri.funcionario.nome_meio is 'Nome do meio';
comment on column elmasri.funcionario.ultimo_nome is 'Ultimo nome';
comment on column elmasri.funcionario.data_nascimento is 'Data de nascimento';
comment on column elmasri.funcionario.endereco is 'Endereço';
comment on column elmasri.funcionario.sexo is 'Sexo';
comment on column elmasri.funcionario.salario is 'Salário';
comment on column elmasri.funcionario.cpf_supervisor is 'CPF do supervisor, é uma FK';
comment on column elmasri.funcionario.numero_departamento is 'Número do departamento';

-- Tabela das informações sobre departamento.
create table departamento(
numero_departamento integer not null,
nome_departamento varchar(15) not null,
cpf_gerente char(11) not null,
data_inicio_gerente date not null,
PRIMARY KEY (numero_departamento),
unique (nome_departamento),
Foreign key (cpf_gerente) references funcionario (cpf)
/*
 criando tabela departamento já com uma das foreign keys.
*/
);

comment on column elmasri.departamento.numero_departamento is 'Número do departamento e PK da tabela';
comment on column elmasri.departamento.nome_departamento is 'Nome do departamento, é uma AK';
comment on column elmasri.departamento.cpf_gerente is 'Cpf do gerente, é uma FK';
comment on column elmasri.departamento.data_inicio_gerente is 'Data do início do gerente'; 

-- Tabela sobre a localização dos departamentos.
create table localizacoes_departamento(
numero_departamento integer not null,
local varchar(15) not null,
PRIMARY KEY (numero_departamento, local),
foreign key (numero_departamento) references departamento (numero_departamento)
/*
 criando tabela localizacoes_departamento já com a foreign key.
*/
);

comment on column elmasri.localizacoes_departamento.numero_departamento is 'Número do departamento e PK da tabela';
comment on column elmasri.localizacoes_departamento.local is 'Local, é a segunda PK da tabela';

-- Tabela com as informações sobre projetos.
create table projeto(
numero_projeto integer not null,
nome_projeto varchar(15) not null,
local_projeto varchar(15),
numero_departamento integer not null,
PRIMARY KEY (numero_projeto),
unique (nome_projeto),
foreign key (numero_departamento) references departamento (numero_departamento)
/*
 criando tabela projeto já com a foreign key.
*/
);

comment on column elmasri.projeto.numero_projeto is 'Número do projeto, é a PK da tabela';
comment on column elmasri.projeto.nome_projeto is 'Nome do projeto, é uma AK';
comment on column elmasri.projeto.local_projeto is 'Localização do projeto.';
comment on column elmasri.projeto.numero_departamento is 'Número do departamento, é uma FK';


-- Tabela sobre local e horas trabalhadas por funcionário.
create table trabalha_em(
cpf_funcionario char(11) not null,
numero_projeto integer not null,
horas decimal(3,1) not null,
PRIMARY KEY (cpf_funcionario, numero_projeto),
foreign key (cpf_funcionario) references funcionario (cpf),
foreign key (numero_projeto) references projeto (numero_projeto)
/*
 criando tabela trabalha_em já com as foreign keys adicionadas.
*/
);

comment on column elmasri.trabalha_em.cpf_funcionario is 'Cpf do funcionário, é uma das PK da tabela e uma FK';
comment on column elmasri.trabalha_em.numero_projeto is 'Número do projeto, é a segunda PK da tabela e uma FK';
comment on column elmasri.trabalha_em.horas is 'Horas trabalhadas';

-- Tabela sobre dependentes de cada funcionário.
create table dependente(
cpf_funcionario char(11) not null,
nome_dependente varchar(15) not null,
sexo char(1),
data_nascimento date,
parentesco varchar(15),
primary key (cpf_funcionario, nome_dependente),
foreign key (cpf_funcionario) references funcionario (cpf)
/*
 criando tabela dependente já com a foreign key.
*/
);

comment on column elmasri.dependente.cpf_funcionario is 'CPF do funcionário, é uma das PK e uma FK';
comment on column elmasri.dependente.nome_dependente is 'Nome do dependente, é a segunda PK da tabela';
comment on column elmasri.dependente.sexo is 'Sexo';
comment on column elmasri.dependente.data_nascimento is 'Data de nascimento'; 
comment on column elmasri.dependente.parentesco is 'Parentesco'; 

-- Inserção de dados em funcionario.
INSERT INTO funcionario
VALUES      (12345678966,'João','B','Silva','1965-01-09','R. das Flores,751,São Paulo,Sp','M',30000,33344555587,5),
            (33344555587, 'Fernando','T','Wong','1955-12-08','R. da Lapa,34,São Paulo,SP','M',40000,88866555576,5),
            (99988777767, 'Alice','J','Zelaya','1968-01-19','R. Souza Lima,35,Curitiba,PR','F',25000,98765432168,4),
            (98765432168, 'Jennifer','S','Souza','1941-06-20','Av. Arthur de Lima,54,S.A,SP','F',43000,88866555576,4),
            (66688444476, 'Ronaldo','K','Lima','1962-09-15','R. Rebouças,65,Piracicaba,SP','M',38000,33344555587,5),
            (45345345376, 'Joice','A','Leite','1972-07-31','Av. Lucas Obes,74 São Paulo,SP','F',25000,33344555587,5),
            (98798798733, 'André','V','Pereira','1969-03-29','R. Timbira,35,São Paulo, SP','M',25000,98765432168,4),
            (88866555576, 'Jorge','E','Brito','1937-11-10','R. do Horto,35,São Paulo,SP','M',55000,98765432168,1);

-- Inserção de dados em departamento.
INSERT INTO departamento
VALUES      (5,'Pesquisa',33344555587,'1988-05-22'),
            (4, 'Administração',98765432168,'1995-01-01'),
            (1, 'Matriz', 88866555576,'1981-06-19');


-- Inserção de dados em localizacoes_departamento.
INSERT INTO localizacoes_departamento
VALUES      (1,'São Paulo'),
            (4,'Mauá'),
            (5,'Santo André'),
            (5,'Itu'),
            (5,'São Paulo');
        
-- Inserção de dados em projeto.
INSERT INTO projeto
VALUES      (1,'ProdutoX','Santo André',5),
            (2,'ProdutoY','Ittu',5),
            (3,'ProdutoZ','São Paulo',5),
            (10,'Informatização','Mauá',4),
            (20,'Reorganização','São Paulo',1),
            (30,'Novosbenefícios','Mauá',4);

-- Inserção de dados em dependente.
INSERT INTO dependente
VALUES      (33344555587,'Alicia','F','1986-04-05','filha'),
            (33344555587,'Tiago','M','1983-10-25','filho'),
            (33344555587,'Janaína','F','1958-05-03','esposa'),
            (98765432168,'Antonio','M','1942-02-28','marido'),
            (12345678966,'Michael','M','1988-01-04','filho'),
            (12345678966,'Alicia','F','1988-12-30','filha'),
            (12345678966,'Elizabeth','F','1967-05-05','esposa');

-- Inserção de dados em trabalha_em.
INSERT INTO trabalha_em
VALUES     (12345678966,1,32.5),
           (12345678966,2,7.5),
           (66688444476,3,40.0),
           (45345345376,1,20.0),
           (45345345376,2,20.0),
           (33344555587,2,10.0),
           (33344555587,3,10.0),
           (33344555587,10,10.0),
           (33344555587,20,10.0),
           (99988777767,30,30.0),
           (99988777767,10,10.0),
           (98798798733,10,35.0),
           (98798798733,30,5.0),
           (98765432168,30,20.0),
           (98765432168,20,15.0),
           (88866555576,20,0.0);

alter table departamento
add constraint departamento_funcionario foreign key (cpf_gerente) references funcionario (cpf)
/*
 adicionando a outra foreign key da tabela departamento.
*/
;

alter table funcionario
add constraint funcionario_funcionario foreign key (cpf_supervisor) references funcionario (cpf)
/*
 adicionando as foreign keys da tabela funcionario.
*/
;

alter table funcionario
add constraint funcionario_ndp foreign key (numero_departamento) references departamento (numero_departamento);
