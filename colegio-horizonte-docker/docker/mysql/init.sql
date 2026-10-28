-- Colégio Horizonte - banco criado automaticamente na primeira subida do container
USE colegio_horizonte;

CREATE TABLE ambientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  andar VARCHAR(20) NOT NULL
);

CREATE TABLE equipamentos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  tipo VARCHAR(40) NOT NULL,
  ambiente_id INT,
  vlan INT,
  ip VARCHAR(15),
  FOREIGN KEY (ambiente_id) REFERENCES ambientes(id)
);

INSERT INTO ambientes (nome, andar) VALUES
 ('Recepção / Portaria','Térreo'),
 ('Secretaria','Térreo'),
 ('Coordenação','Térreo'),
 ('Diretoria','Térreo'),
 ('Sala dos Professores','Térreo'),
 ('Biblioteca','Térreo'),
 ('Sala de TI','Térreo'),
 ('Salas de aula 1 a 6','1º andar'),
 ('Laboratório de Informática','1º andar'),
 ('Sala técnica','1º andar');

INSERT INTO equipamentos (codigo, tipo, ambiente_id, vlan, ip) VALUES
 ('FW-01','Firewall/roteador',7,99,'10.10.1.193'),
 ('SW-T-01','Switch 48p PoE+',7,99,'10.10.1.194'),
 ('SW-1A-01','Switch 24p PoE+',10,99,'10.10.1.195'),
 ('SW-LAB-01','Switch 48p',10,99,'10.10.1.196'),
 ('SRV-01','Servidor Docker',7,40,'10.10.1.226'),
 ('NAS-01','Armazenamento',7,40,'10.10.1.227'),
 ('PABX-01','PABX IP',7,40,'10.10.1.228'),
 ('NVR-01','Gravador de câmeras',7,50,'10.10.1.162'),
 ('MF-SEC-01','Multifuncional',2,10,'10.10.1.130'),
 ('PC-TI-01','Computador',7,10,'10.10.1.131'),
 ('MF-PROF-01','Multifuncional',5,20,'10.10.1.2'),
 ('IMP-LAB-01','Impressora',9,30,'10.10.1.66'),
 ('PC-LAB-PROF','Computador',9,30,'10.10.1.67');
