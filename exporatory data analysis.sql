-- Exploratory Data Analysis

SELECT * 
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- WHICH COMPANIES FIRED 100% OF ITS WORK FORCE
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY company ASC;


-- WHICH COMPANY HAD THE MOST FUNDING AND FIRED ALL EMPLOYEES
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- COUNTRY WHICH HAD THE MOST LAY OFFS?
SELECT T1.COUNTRY, 
SUM(T1.total_laid_off) AS ALL_LAYOFF
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
ON T1.country = T2.COUNTRY
GROUP BY T1.country
order by country ASC;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
group by country
ORDER BY 2 desc;



-- INDUSTRY WHICH THE MOST LAYOFFS?
SELECT T1.industry, 
SUM(T1.total_laid_off) AS ALL_LAYOFF
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
ON T1.industry = T2.industry
GROUP BY T1.industry
order by industry ASC;



-- SIMPLE METHOD
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
group by industry
ORDER BY 2 desc;

-- WHICH COMAPNY HAD MOST LAY OFF

 SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
group by company
ORDER BY 2 desc;

-- WHICH year HAD MOST LAY OFF
 SELECT year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
group by year(`date`)
ORDER BY 2 desc;


-- WHICH stage of company HAD MOST LAY OFF
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
group by stage
ORDER BY 2 desc;


-- which year,month had the most lay offs
SELECT substring(`date`,1,7) as `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by substring(`date`,1,7)
ORDER BY 1 ASC;


-- rolling total of layoffs according to months in ascending order

with Rolling_Total as
(
SELECT substring(`date`,1,7) as `MONTH`, SUM(total_laid_off) as total_layoffs
FROM layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by substring(`date`,1,7)
ORDER BY 1 ASC
)
select `MONTH`, total_layoffs,
sum(total_layoffs) over(order by `month`) as Rolling_Total
from  rolling_total;


-- which company had fired how many employees
SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
group by company, year(`date`)
ORDER BY 3 desc;




with company_year (Company, Years, Total_Layoffs) as 
(
SELECT company, year(`date`), SUM(total_laid_off)
FROM layoffs_staging2
group by company, year(`date`)
), Company_year_rank as
(
select 	*, 
dense_rank() over (partition by years order by total_layoffs desc) as Ranking
from company_year
where years is not null
)
select * 
from Company_year_rank
where ranking <= 5 ;
