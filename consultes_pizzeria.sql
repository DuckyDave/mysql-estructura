USE pizzeria;
/* Llista quants productes de tipus 'Begudes' s'han venut en una determinada localitat */
SELECT sum(comanda.num_begudes) AS 'Total de begudes venudes en una localitat determinada' FROM comanda WHERE EXISTS (SELECT localitat.nom FROM localitat LEFT JOIN botiga ON localitat.id = botiga.id_localitat WHERE localitat.nom = 'Igualada');
/* Llista quantes comandes ha efectuat un determinat empleat */
SELECT count(comanda.id) AS 'comandes efectuades', comanda.tipus AS 'tipus' FROM comanda INNER JOIN empleat ON comanda.id_empleat = empleat.id WHERE empleat.nom = 'Albert' GROUP BY comanda.tipus;