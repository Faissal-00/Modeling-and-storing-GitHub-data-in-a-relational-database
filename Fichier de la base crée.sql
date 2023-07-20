create database GithubDB;
use GithubDB;

select * from Contributor;
select * from Language;
select * from Owner;
select * from Repository;
select * from repository_Contributor;



--Vérifier le nombre total de lignes dans chaque table
SELECT COUNT(*) AS total_rows FROM Contributor;
SELECT COUNT(*) AS total_rows FROM Language;
SELECT COUNT(*) AS total_rows FROM Owner;
SELECT COUNT(*) AS total_rows FROM Repository;
SELECT COUNT(*) AS total_rows FROM Repository_Contributor;






--Vérifier s'il y a des doublons dans la table language
SELECT language_Id, language_name, COUNT(*) AS count
FROM Language
GROUP BY language_Id, language_name
HAVING COUNT(*) > 1;



--Obtenir le langage le plus utilisé dans les dépôts
SELECT TOP 1 language_name, COUNT(*) AS total_repositories
FROM Repository
INNER JOIN Language ON Repository.language_Id = Language.language_Id
GROUP BY language_name
ORDER BY total_repositories DESC;


--Obtenir le propriétaire ayant le plus de dépôts 
SELECT TOP 1 owner_name, COUNT(*) AS total_repositories
FROM Owner
INNER JOIN Repository ON Owner.owner_Id = Repository.owner_Id
GROUP BY owner_name
ORDER BY total_repositories DESC;



--Get the list of repositories with their owners

SELECT Repository.repository_name, Owner.owner_name
FROM Repository
INNER JOIN Owner ON Repository.owner_Id = Owner.owner_Id;




--Get the list of repositories with their languages and owners
SELECT Repository.repository_name, Language.language_name, Owner.owner_name
FROM Repository
INNER JOIN Language ON Repository.language_Id = Language.language_Id
INNER JOIN Owner ON Repository.owner_Id = Owner.owner_Id;




--Get the list of contributors and their contributions for a specific repository
SELECT Contributor.contributor_name, Repository_Contributor.contributions_count
FROM Contributor
INNER JOIN Repository_Contributor ON Contributor.contributor_Id = Repository_Contributor.contributor_Id
INNER JOIN Repository ON Repository_Contributor.repository_Id = Repository.repository_Id
WHERE Repository.repository_name = 'notepad--';



--Get the list of repositories with their contributors and contributions
SELECT Repository.repository_name, Contributor.contributor_name, Repository_Contributor.contributions_count
FROM Repository
INNER JOIN Repository_Contributor ON Repository.repository_Id = Repository_Contributor.repository_Id
INNER JOIN Contributor ON Repository_Contributor.contributor_Id = Contributor.contributor_Id;



SELECT
    R.repository_name,
    R.repository_url,
    C.contributor_name,
    L.language_name,
    RC.contributions_count
FROM
    Repository R
INNER JOIN
    Repository_Contributor RC ON R.repository_Id = RC.repository_Id
INNER JOIN
    Contributor C ON RC.contributor_Id = C.contributor_Id
LEFT JOIN
    Language L ON R.language_Id = L.language_Id;