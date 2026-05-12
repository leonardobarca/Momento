USE momento;

-- 1.2 Agora que você faz parte da equipe, quantos funcionários temos ao total na empresa?
SELECT count(funcionario_id) FROM funcionarios;

-- 1.3 Quantos funcionários trabalham especificamente no Departamento de Tecnologia?
SELECT count(*) FROM funcionarios WHERE departamento_id = 6; -- 5

-- 1.4 Liste todos os departamentos que existem na empresa. Quantos são?
SELECT count(departamento_id) FROM departamentos; -- 13

-- 1.5 Quantos escritórios a Momento possui? Em quais países?
SELECT count(escritorio_id) FROM escritorios; -- 9
SELECT (pais_id) FROM escritorios; 

-- 2.1 Quantos funcionários trabalham no Departamento de Vendas?
SELECT count(*) FROM funcionarios WHERE departamento_id = 8; -- 6

-- 2.2 Qual é o custo total com salários do Departamento de Vendas?
SELECT SUM(salario) FROM funcionarios WHERE departamento_id = 8; -- R$61500

-- 2.3 Qual é a média salarial da empresa, excluindo os cargos de CEO, CMO e CFO?
SELECT AVG(salario) AS media_salarial FROM funcionarios WHERE cargo_id NOT IN (4, 7, 10); -- 8470.75

-- 2.4 Qual é a média salarial do Departamento de Tecnologia?
SELECT AVG(salario) AS media_salario_tecnologia FROM funcionarios WHERE departamento_id = 6; -- 5760

-- 2.5 Qual departamento possui a maior média salarial? -- nesse aqui usei IA mas entendi certinho muito legal realmente -- departamento 13, media de 21815
SELECT departamento_id, AVG(salario) AS media_salario
FROM funcionarios
GROUP BY departamento_id
ORDER BY media_salario DESC
LIMIT 1;

-- 2.6 Qual departamento possui o menor número de funcionários?
SELECT departamento_id,
COUNT(*) AS total 
FROM funcionarios GROUP BY departamento_id
ORDER BY total ASC
LIMIT 1;

-- 3.1 Quantos funcionários da empresa Momento possuem cônjuges?
SELECT COUNT(*) FROM dependentes WHERE relacionamento LIKE 'cônjuge'; -- 4

-- 3.2 Quantos funcionários possuem filhos registrados?
SELECT COUNT(*) FROM dependentes WHERE relacionamento LIKE 'filha(o)'; -- 32

-- 3.3 Qual funcionário foi contratado há mais tempo na empresa?
SELECT primeiro_nome, sobrenome, data_contratacao AS datinha
FROM funcionarios 
ORDER BY datinha ASC
LIMIT 1; -- Steven wayne, foi contratado em 1987-06-17

-- 3.4 Qual funcionário foi contratado há menos tempo na empresa?
SELECT primeiro_nome, sobrenome, data_contratacao AS datinha
FROM funcionarios 
ORDER BY datinha DESC
LIMIT 1; -- EU! fui contratado 2025-11-29

-- 3.5 Liste os 5 funcionários com mais tempo de casa, ordenados pela data de contratação.
SELECT primeiro_nome, sobrenome, data_contratacao AS datinha
FROM funcionarios 
ORDER BY datinha ASC
LIMIT 5; -- Steven	Wayne	1987-06-17, Jennifer	Whalen	1987-09-17, Neena	Kochhar	1989-09-21, Alexander	Hunold	1990-01-03, Bruce	Ernst	1991-05-21

-- 3.6 Quantos funcionários foram contratados na década de 1990 (entre 1990-1999)?
SELECT COUNT(*) AS velho_de_casa 
FROM funcionarios WHERE data_contratacao BETWEEN '1990-01-01' AND '1999-12-31';

-- 3.7 Como a média salarial da Momento evoluiu ao longo dos anos? Agrupe por ano de contratação e calcule a média salarial.
SELECT YEAR(data_contratacao) AS ano, AVG(salario) AS dinheirao
FROM funcionarios
GROUP BY YEAR(data_contratacao)
ORDER BY ano ASC;

-- 4.1 Qual é o custo total de suprimentos em cada escritório? Ordene do mais caro ao mais barato.
SELECT SUM(custo) as custo_total
FROM suprimentos
GROUP BY (escritorio_id)
ORDER BY custo_total DESC;

-- 4.2 Qual escritório possui a maior quantidade de diferentes tipos de suprimentos?
SELECT escritorio_id, COUNT(quantidade_comprada) AS numero_suprimentos FROM suprimentos
GROUP BY (escritorio_id)
ORDER BY numero_suprimentos DESC
LIMIT 1; -- escritorio id: 2500 | numero suprimentos: 10

-- 4.3 Qual é o suprimento mais caro (considerando preço unitário) em toda a empresa?
