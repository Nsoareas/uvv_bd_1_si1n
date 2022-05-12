-- Respostas
-- 1
select AVG(salario) as media_salarial, nome_departamento as departamento
from funcionario as f
inner join departamento as dp on (f.numero_departamento = dp.numero_departamento)
group by nome_departamento;


-- 2
select AVG(salario) as media_salarial, sexo
from funcionario
group by sexo;


-- 3
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario,
timestampdiff(year, data_nascimento, curdate()) as idade, 
f.data_nascimento, curdate() as dataAtual,
f.salario, dp.nome_departamento as departamento from funcionario as f
inner join departamento as dp on (f.numero_departamento = dp.numero_departamento);


-- 4
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario, 
timestampdiff(year, data_nascimento, curdate()) as idade,
f.data_nascimento, curdate() as dataAtual,
f.salario as salario,
case
when f.salario < 35.000 then f.salario + (f.salario * 20/100)
when f.salario >= 35.000 then f.salario + (f.salario * 15/100)
end as salario_reajuste
from funcionario as f;


-- 5    
select dp.nome_departamento as departamento, case 
when dp.numero_departamento = 5 then "Fernando"
when dp.numero_departamento = 4 then "Jennifer"
when dp.numero_departamento = 1 then "Jorge"
end as gerente,
CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario,
f.salario from funcionario as f
inner join departamento as dp on (f.numero_departamento = dp.numero_departamento)
order by dp.nome_departamento asc, f.salario desc;

-- 6
/* Não consegui fazer essa questão*/

-- 7
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario, salario,
numero_departamento as departamento
from funcionario as f
left outer join dependente as d on (f.cpf = d.cpf_funcionario)
where cpf_funcionario is null;

-- 8
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario,
t.horas, dp.nome_departamento as departamento, 
p.nome_projeto as projeto
from projeto as p
inner join departamento as dp on (p.numero_departamento = dp.numero_departamento)
inner join trabalha_em as t on (t.numero_projeto = p.numero_projeto)
inner join funcionario as f on (f.cpf = t.cpf_funcionario);


-- 9
select dp.nome_departamento as departamento, 
p.nome_projeto as projeto, 
SUM(t.horas) as horas
from departamento as dp
inner join projeto as p on (p.numero_departamento = dp.numero_departamento)
inner join trabalha_em as t on (p.numero_projeto = t.numero_projeto)
group by nome_departamento, p.nome_projeto 
order by nome_departamento;

-- 10
 /* Não sei se foi intecional, porém, a questão 10 é exatamente igual a questão 1. Para não ter que repetir
 a mesma coisa, peço que use o mesmo script já feito na resposta da 1, caso necessário.*/


-- 11
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario, 
p.nome_projeto as projeto,
t.horas * 50 as total
from funcionario as f
inner join projeto as p on (p.numero_departamento = f.numero_departamento)
inner join trabalha_em as t on (t.numero_projeto = p.numero_projeto)
group by funcionario, nome_projeto
order by funcionario;


-- 12
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario, 
dp.nome_departamento as departamento,
p.nome_projeto as projeto, 
t.horas
from projeto as p
inner join departamento as dp on (p.numero_departamento = dp.numero_departamento)
inner join funcionario as f on (p.numero_departamento = f.numero_departamento)
inner join trabalha_em as t on (p.numero_projeto = t.numero_projeto)
where t.horas is null or t.horas = 0;


-- 13
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario,
timestampdiff(year, f.data_nascimento, curdate()) as idade,
f.sexo as sexo
from funcionario as f
union
select CONCAT(d.nome_dependente, ' ', f.ultimo_nome) as dependente,
timestampdiff(year, d.data_nascimento, curdate()) as idade,
d.sexo as sexo
from dependente as d
left outer join funcionario as f on (f.cpf = d.cpf_funcionario)
order by idade desc;
/* Nao consegui achar oque fiz de errado nesse relatório da questão 13, por isso deixei desse jeito. */ 

-- 14
select dp.nome_departamento as departamento, 
COUNT(cpf) as quantidade_funcionarios
from funcionario as f
inner join departamento as dp on (f.numero_departamento = dp.numero_departamento)
group by nome_departamento;


-- 15 
select CONCAT(f.nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as funcionario, 
dp.nome_departamento as departamento,
p.nome_projeto as projeto
from funcionario as f
inner join departamento as dp on (f.numero_departamento = dp.numero_departamento)
left outer join projeto as p on (p.numero_departamento = dp.numero_departamento)
inner join trabalha_em as t on (f.cpf = t.cpf_funcionario)
group by funcionario, nome_projeto
order by nome_projeto;
