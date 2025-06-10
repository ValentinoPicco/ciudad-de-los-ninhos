-- TRABAJO PRACTICO BASE DE DATOS: CIUDAD DE LOS NIÑOS
-- Autores: Levis Joaquin, Llorente Mateo, Picco Valentino.


-- a)
-- cantidad de aportes mensuales del programa
select nombre, count(id_programa) 
from ciudadninios.programa  natural join ciudadninios.aporte  where frecuencia = 'mensual'
group by id_programa;

-- monto total mensual de los aportes al programa
select nombre, sum(monto) 
from ciudadninios.programa  natural join ciudadninios.aporte  where frecuencia = 'mensual'
group by id_programa;

-- b)
select dni
from ciudadninios.aporte
group by dni having count(distinct id_programa) > 2;

-- c)
(select dni, monto, frecuencia, num_tarj as fuente 
from ciudadninios.aporte natural join ciudadninios.donante natural join ciudadninios.medio_pago natural join ciudadninios.tarj_cred 
where frecuencia = 'mensual')
union
(select dni, monto, frecuencia, tipo_cta as fuente 
from ciudadninios.aporte natural join ciudadninios.donante natural join ciudadninios.medio_pago natural join ciudadninios.trans_deb 
where frecuencia = 'mensual')

