SELECT 
    NVL(domain, 'NULL') AS domain,
    COUNT(*) AS ea,
    SUM(COUNT(*)) OVER () AS sum_domain,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS "%"
    
FROM (
    SELECT SUBSTR(email, INSTR(email, '@') + 1) AS domain
    FROM professor
)
GROUP BY domain
ORDER BY domain;

