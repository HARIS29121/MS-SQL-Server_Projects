SELECT *
FROM Portfolio_Projects..CovidDeaths
ORDER BY location,date

SELECT *
FROM Portfolio_Projects..CovidVaccinations
ORDER BY location

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM Portfolio_Projects..CovidDeaths
ORDER BY 1,2

--Looking for total_cases and total_deaths
-- Shows the death percentage of the Covid infected people

SELECT location,date,total_cases,total_deaths,([total_deaths]/[total_cases]*100) AS Death_Percentage
FROM Portfolio_Projects..CovidDeaths
WHERE location='India'
ORDER BY 1,2

-- Looking at Total_cases Vs Population
-- Shows the percentage of population got infected by Covid

SELECT location,date,total_cases,population,([total_cases]/[population]*100) AS infection_Percentage
FROM Portfolio_Projects..CovidDeaths
WHERE location='India'
ORDER BY 1,2

SELECT location,date,total_cases,population,([total_cases]/[population]*100) AS infection_Percentage
FROM Portfolio_Projects..CovidDeaths
WHERE location='United States'
ORDER BY 1,2

--Looking for countries with highest infection rate compared to population

SELECT location,population,MAX(total_cases) MaxCases, MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM Portfolio_Projects..CovidDeaths
GROUP BY location,population
ORDER BY PercentagePopulationInfected DESC

-- Looking for countries with highest death rate compared to population

SELECT location,population,MAX(CAST (total_deaths AS INT)) AS MaxDeaths, MAX((total_deaths/population))*100 AS PercentagePopulationDead
FROM Portfolio_Projects..CovidDeaths
GROUP BY location,population
ORDER BY PercentagePopulationDead DESC

-- Exploration based on Continents

SELECT continent,MAX(CAST (total_deaths AS INT)) AS MaxDeaths, MAX((total_deaths/population))*100 AS PercentagePopulationDead
FROM Portfolio_Projects..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY PercentagePopulationDead DESC

-- Which country reports highest number of Covid Cases.

SELECT TOP(5)continent,location,MAX(total_cases) as Total_Cases
FROM CovidDeaths
WHERE continent IS NOT NULL
Group by continent,location
ORDER BY Total_Cases DESC

-- Countries with no Covid Cases.

SELECT continent,location,MAX(total_cases) as Total_Cases
FROM CovidDeaths
WHERE continent IS NOT NULL AND Total_Cases IS NULL
Group by continent,location
ORDER BY Total_Cases DESC

-- Total Covid Cases and deaths in the World as of now.

WITH T1 AS (
SELECT continent,location,MAX(total_cases) as Total_Cases,MAX(CAST(total_deaths AS int)) AS Total_Deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
Group by continent,location)
SELECT SUM(Total_cases) AS Worldwide_Total_Covid_Cases, SUM(Total_deaths) AS Worldwide_Total_Covid_Deaths FROM T1

-- Joining the CovidDeaths & CovidVaccinations tables

SELECT *
FROM Portfolio_Projects..CovidDeaths Dea
JOIN Portfolio_Projects..CovidVaccinations Vac
ON Dea.location = Vac.location
AND Dea.date = Vac.date

-- Vaccinations and population over Countries

SELECT Dea.location,Dea.population,MAX(Vac.total_vaccinations) AS Total_Vaccinations,(MAX(Vac.total_vaccinations) / Dea.population)*100 AS Vaccination_Percentage
FROM Portfolio_Projects..CovidDeaths Dea
JOIN Portfolio_Projects..CovidVaccinations Vac
ON Dea.location = Vac.location
AND Dea.date = Vac.date
WHERE Dea.continent IS NOT NULL
GROUP BY Dea.location,Dea.population
ORDER BY Dea.population DESC

-- Looking for new_vaccinations every day and also creating rolling total for new vaccinations

SELECT Dea.continent,Dea.location,Dea.date,Dea.population,Vac.new_vaccinations,
SUM(CAST(Vac.new_vaccinations AS bigint)) OVER(PARTITION BY Dea.location ORDER BY Dea.location,Dea.date) AS Total_Vaccinations
FROM Portfolio_Projects..CovidDeaths Dea
JOIN Portfolio_Projects..CovidVaccinations Vac
ON Dea.location = Vac.location
AND Dea.date = Vac.date
WHERE Dea.continent IS NOT NULL
ORDER BY 2,3

