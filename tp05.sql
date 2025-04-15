-- a. Mettez en minuscules la désignation de l'article dont l'identifiant est 2
UPDATE article SET article.DESIGNATION=LOWER(article.DESIGNATION) WHERE article.ID=2;
-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
UPDATE article SET article.DESIGNATION=UPPER(article.DESIGNATION) WHERE article.PRIX>10;
-- c. Baissez de 10% le prix de tous les articles qui n'ont pas fait l'objet d'une commande.
UPDATE article SET article.PRIX=(article.PRIX-(article.PRIX*10/100)) WHERE article.ID NOT IN (SELECT DISTINCT ID_ART FROM compo);
-- d. Une erreur s'est glissée dans les commandes concernant Française d'imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE compo SET compo.QTE=(compo.QTE*2) WHERE compo.ID_BON IN (SELECT ID FROM bon WHERE bon.ID_FOU=1);
-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme substring et position.
UPDATE article SET article.DESIGNATION=SUBSTRING(article.DESIGNATION,1,POSITION("(" IN article.DESIGNATION)-1) WHERE article.DESIGNATION LIKE "%(%";