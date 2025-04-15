-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT * FROM article ORDER BY DESIGNATION ASC;
-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT * FROM article ORDER BY PRIX DESC;
-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT * FROM article WHERE DESIGNATION LIKE '%boulon%' ORDER BY PRIX ASC;
-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT * FROM article WHERE DESIGNATION LIKE '%sachet%';
-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT * FROM article WHERE UPPER(DESIGNATION) LIKE UPPER('%sachet%');
-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT * FROM article, fournisseur WHERE article.ID_FOU = fournisseur.ID ORDER BY NOM ASC, PRIX DESC;
-- g. Listez les articles de la société « Dubois & Fils »
SELECT * FROM article, fournisseur WHERE article.ID_FOU=fournisseur.ID AND ID_FOU=3;
-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT NOM, AVG(PRIX) FROM article, fournisseur WHERE article.ID_FOU=fournisseur.ID AND ID_FOU=3 GROUP BY NOM;
-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT NOM, AVG(PRIX) FROM article, fournisseur WHERE article.ID_FOU=fournisseur.ID GROUP BY NOM;
-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT * FROM bon WHERE DATE_CMDE BETWEEN '2019/03/01 12:00:00' AND '2019/04/05 12:00:00';
-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT bon.NUMERO FROM bon, compo, article WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID AND article.DESIGNATION LIKE '%boulon%' GROUP BY bon.NUMERO;
-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT bon.NUMERO, article.DESIGNATION, fournisseur.NOM FROM bon, compo, article, fournisseur WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID AND article.ID_FOU=fournisseur.ID AND article.DESIGNATION LIKE '%boulon%';
-- m. Calculez le prix total de chaque bon de commande
SELECT bon.NUMERO, SUM(article.PRIX*compo.QTE) as Total FROM bon, compo, article WHERE bon.ID=compo.ID_BON AND compo.ID_ART=article.ID GROUP BY bon.NUMERO;
-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT bon.NUMERO, SUM(compo.QTE) FROM bon, compo WHERE bon.ID=compo.ID_BON GROUP BY bon.NUMERO;
-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT bon.NUMERO, SUM(compo.QTE) FROM bon, compo WHERE bon.ID=compo.ID_BON GROUP BY bon.NUMERO HAVING SUM(compo.QTE) >= 25;
-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT SUM(compo.QTE*article.PRIX) AS Total FROM compo JOIN article ON compo.ID_ART = article.ID JOIN bon ON compo.ID_BON = bon.ID WHERE MONTH(bon.DATE_CMDE) = 4;
-- q. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents
SELECT article.DESIGNATION, COUNT(article.DESIGNATION) AS 'Nombre de Fournisseur' FROM article GROUP BY article.DESIGNATION HAVING COUNT(article.DESIGNATION) > 1;
-- r. Calculez les dépenses en commandes mois par mois
SELECT MONTH(bon.DATE_CMDE) AS Month, SUM(compo.QTE*article.PRIX) AS Total FROM compo JOIN article ON compo.ID_ART = article.ID JOIN bon ON compo.ID_BON = bon.ID GROUP BY Month;
-- s. Sélectionnez les bons de commandes sans article
SELECT * FROM bon LEFT JOIN compo ON bon.ID = compo.ID_BON WHERE compo.ID_BON IS NULL;
-- t. Calculez le prix moyen des bons de commande par fournisseur
SELECT fournisseur.NOM, AVG(compo.QTE*article.PRIX) AS 'Prix moyen' FROM bon, fournisseur, compo, article WHERE bon.ID=compo.ID_BON AND article.ID=compo.ID_ART AND bon.ID_FOU=fournisseur.ID AND article.ID_FOU=fournisseur.ID GROUP BY fournisseur.NOM;