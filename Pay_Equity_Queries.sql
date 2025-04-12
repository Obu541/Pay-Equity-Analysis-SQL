SELECT gender, 
       ROUND(AVG(salary), 2) AS avg_salary
FROM hr_data
GROUP BY gender;

SELECT job_level, 
       ROUND(AVG(salary), 2) AS avg_salary
FROM hr_data
GROUP BY job_level
ORDER BY job_level;


SELECT
    job_level,
    IFNULL(ROUND(MAX(CASE WHEN gender = 'M' THEN avg_salary END), 2), 'N/A') AS male_avg_salary,
    IFNULL(ROUND(MAX(CASE WHEN gender = 'F' THEN avg_salary END), 2), 'N/A') AS female_avg_salary,
    CASE 
        WHEN MAX(CASE WHEN gender = 'F' THEN avg_salary END) IS NULL THEN 'N/A'
        WHEN MAX(CASE WHEN gender = 'M' THEN avg_salary END) IS NULL THEN 'N/A'
        ELSE ROUND(
            100.0 * 
            (MAX(CASE WHEN gender = 'M' THEN avg_salary END) - MAX(CASE WHEN gender = 'F' THEN avg_salary END)) /
            MAX(CASE WHEN gender = 'F' THEN avg_salary END), 
            1
        )
    END AS pay_gap_percent
FROM (
    SELECT job_level, gender, AVG(salary) AS avg_salary
    FROM hr_data
    GROUP BY job_level, gender
) AS sub
GROUP BY job_level
ORDER BY job_level;
