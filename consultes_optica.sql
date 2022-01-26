/* Llista el total de compres d’un client */
SELECT count(id_client) AS 'Total compres' FROM empleat_ha_venut_ulleres WHERE id_client = (SELECT id FROM dades_client WHERE dades_client.nom LIKE 'Karen%');
/* Llista les diferents ulleres que ha venut un empleat durant un any */
select marca.nom, ulleres.model, data_venda from optica.marca, optica.ulleres, optica.empleat_ha_venut_ulleres, optica.empleat WHERE empleat.id = empleat_ha_venut_ulleres.id_empleat AND marca.id = ulleres.id_marca AND ulleres.id = empleat_ha_venut_ulleres.id_ulleres AND empleat.nom = 'Judit' AND data_venda BETWEEN '202-01-01 00:00:00' AND '2020-12-31 23:59:59' ORDER BY data_venda;
/* Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica */
SELECT * FROM proveidor WHERE EXISTS (SELECT id_ulleres FROM empleat_ha_venut_ulleres);