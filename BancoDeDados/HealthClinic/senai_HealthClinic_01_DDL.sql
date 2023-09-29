-- DDL - DATA DEFINITION LANGUAGE - LINGUAGEM DE DEFINICAO DE DADOS

-- CRIAR BANCO DE DADOS

CREATE DATABASE HealthClinic_Tarde;

USE HealthClinic_Tarde;

-- CRIAR AS TABELAS DO BANCO DE DADOS

CREATE TABLE TipoDeUsuario
(
	IdTipoDeUsuario UNIQUEIDENTIFIER PRIMARY KEY,
	NomeTipoDeUsuario VARCHAR(32) NOT NULL UNIQUE,
);

CREATE TABLE Usuario
(
	IdUsuario UNIQUEIDENTIFIER PRIMARY KEY ,
	IdTipoDeUsuario UNIQUEIDENTIFIER FOREIGN KEY REFERENCES TipoDeUsuario(IdTipoDeUsuario) NOT NULL,
	NomeUsuario VARCHAR(64) NOT NULL,
	Email VARCHAR(255) NOT NULL UNIQUE,
	Senha VARCHAR(64) NOT NULL,
);

CREATE TABLE Especialidade
(
	IdEspecialidade UNIQUEIDENTIFIER PRIMARY KEY ,
	NomeEspecialidade VARCHAR(64) NOT NULL UNIQUE,
);

CREATE TABLE Clinica
(
	IdClinica UNIQUEIDENTIFIER PRIMARY KEY ,
	Endereco VARCHAR(128) NOT NULL UNIQUE,
	Unidade VARCHAR (64) NOT NULL UNIQUE,
	CNPJ VARCHAR(14) NOT NULL UNIQUE,
	HoraAbertura TIME NOT NULL,
	HoraEncerramento TIME NOT NULL,
);

CREATE TABLE Medico
(
	IdMedico UNIQUEIDENTIFIER PRIMARY KEY ,
	IdUsuario UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Usuario(IdUsuario) NOT NULL UNIQUE,
	IdEspecialidade UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Especialidade(IdEspecialidade) NOT NULL,
	IdClinica UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Clinica(IdClinica) NOT NULL,
	CRM VARCHAR(6) NOT NULL,
);

CREATE TABLE Paciente
(
	IdPaciente UNIQUEIDENTIFIER PRIMARY KEY ,
	IdUsuario UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Usuario(IdUsuario) NOT NULL UNIQUE,
	DataNascimento DATE NOT NULL,
	Telefone VARCHAR(11) NOT NULL UNIQUE,
	RG VARCHAR(9) NOT NULL UNIQUE,
	CPF VARCHAR(11) NOT NULL UNIQUE,
	CEP VARCHAR(8) NOT NULL,
	Endereco VARCHAR(64) NOT NULL,
);

CREATE TABLE Situacao
(
	IdSituacao UNIQUEIDENTIFIER PRIMARY KEY ,
	TituloSituacao VARCHAR(32) NOT NULL UNIQUE,
);

CREATE TABLE Consulta
(
	IdConsulta UNIQUEIDENTIFIER PRIMARY KEY ,
	IdMedico UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Medico(IdMedico) NOT NULL,
	IdPaciente UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Paciente(IdPaciente) NOT NULL,
	IdSituacao UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Situacao(IdSituacao) NOT NULL,
	[Data] DATE NOT NULL,
	Horario TIME NOT NULL,
);

CREATE TABLE Prontuario
(
	IdProntuario UNIQUEIDENTIFIER PRIMARY KEY ,
	IdConsulta UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Consulta(IdConsulta) NOT NULL UNIQUE,
	Descricao TEXT NOT NULL,
);

CREATE TABLE Comentario
(
	IdComentario UNIQUEIDENTIFIER PRIMARY KEY ,
	IdConsulta UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Consulta(IdConsulta) NOT NULL,
	Descricao VARCHAR(255) NOT NULL,
	Exibe BIT NOT NULL,
);