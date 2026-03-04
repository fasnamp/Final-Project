CREATE DATABASE sleep_health_db;
USE sleep_health_db;
alter table  sleep_health_and_lifestyle_dataset rename to sleep_health ;
select * from sleep_health;

#Average Sleep Duration by Gender
select Gender, avg(`Sleep Duration`) as avg_sleep_duration from sleep_health group by Gender;
 # Stress by Occupation
 select Occupation,avg(`Stress Level`) as avg_stress from sleep_health group by Occupation order by avg_stress desc;
 #Most common BMI Category
 select `BMI Category`,count(*) as count from sleep_health group by `BMI Category`;
 # sleep disorder count
 select `Sleep Disorder`,count(*) as count from sleep_health group by `Sleep Disorder`;
 #Age Group Analysis
 select case when Age Between 20 and 30 then '20-30'
when Age Between 31 and 40 then '31-40'
when Age Between 41 and 50 then '41-50'
else '50+'
End as age_group,
avg(`Sleep Duration`) as avg_sleep
from sleep_health group by age_group;

#Occupation vs Average Sleep Duration
select Occupation, avg(`Sleep Duration`) as avg_sleep_duration from sleep_health group by Occupation order by avg_sleep_duration;
#Stress Level vs Sleep Quality
select `Stress Level`,avg(`Quality of Sleep`) as avg_quality from sleep_health group by `Stress Level` order by `Stress Level`;
#High Stress & Poor Sleep
select count(*) as high_stress_poor_sleep from sleep_health where `Stress Level`>=7 and `Quality of Sleep`<=5;
#BMI Category vs Avg Daily Steps
select `BMI Category`, avg(`Daily Steps`) as avg_daily_steps from sleep_health group by `BMI Category` order by avg_daily_steps;
#Blood Pressure Risk Classification
select `Person ID`,`Systolic_BP`,`Diastolic_BP`, CASE
 WHEN `systolic_bp` < 120 AND `diastolic_bp` < 80 THEN 'Normal'
         WHEN `systolic_bp` BETWEEN 120 AND 129 AND `diastolic_bp` < 80 THEN 'Elevated'
         WHEN `systolic_bp` BETWEEN 130 AND 139 OR `diastolic_bp` BETWEEN 80 AND 89 THEN 'High BP Stage 1'
         ELSE 'High BP Stage 2'
       END AS bp_category
FROM sleep_health;

#Top 5 Occupations with Lowest Sleep Quality
select Occupation, max(`Quality of Sleep`) as max_sleep_quality from sleep_health group by Occupation order by max_sleep_quality limit 5 ;
#  Rank by Sleep Duration
SELECT `Person ID`,
       `Occupation`,
       `Sleep Duration`,
       RANK() OVER (ORDER BY `Sleep Duration` DESC) AS sleep_rank
FROM sleep_health;
#Correlation Insight
SELECT
  CASE
    WHEN `Stress Level` >= 7 THEN 'High Stress'
    WHEN `Stress Level` BETWEEN 4 AND 6 THEN 'Medium Stress'
    ELSE 'Low Stress'
  END AS stress_category,
  AVG(`Sleep Duration`) AS avg_sleep_duration
FROM sleep_health
GROUP BY stress_category;


