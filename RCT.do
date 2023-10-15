/*
Prenom: Ibrahima

Nom: Diallo

Niveau : ISE 3


			/ PROGRAM EVALUATION FOR INTERNATIONAL DEVELOPMENT
// PROFESSOR Omar SENE
/* preliminary stuff*/
*/

clear all
set scheme s1mono
set more off
set seed 12345


webuse set // on met le lien vers la base 

************************************************************************************************************************************************************************************************************************* 

use "C:\Users\Hp\OneDrive\Bureau\ISE_3\suivi_evaluaion_impact\E1-CohenEtAl-data"



webuse E1-CohenEtAl-data-my-raw-

data-copy,replace

****** Question 1: How many observations are in the data set?

count

*** 575

**Question 2: What is the mean of the variable act_any (to three decimal places)?

sum act_any
di r(mean)

***** .739

**Question 3: The variable act_any is a dummy for assignment to any treatment (positive subsidy). How many people received a positive subsidy?

count if act_any== 1

***425


**Question 4: What is the standard deviation of the variable c_act?

sum c_act
di r(sd)

*** .474


** Question 5: The variable c_act is a dummy for using ACT treatment during a malaria episode. How many respondents report using ACT treatment for malaria?

count if c_act ==1

***.196

**Question 6: Regress c_act on act_any. What is the R-squared?

regress c_act act_any

return list

matrix V= r(table)
matrix list V

di V[1,1] // pour afficher un element de la matrix
** R2=3.12% donc nous avons un pouvoir predictif tres faible des variation de y (la proportion des individus qui se soigne avec le act_any s'il sont atteint du palidisme' (qui aumente de 19%)) qui sont expliquer par les variation de X


***Question 7: What is the coefficient associated with the act_any variable?
to act_any

di _b[act_any]

***.19
*la proportion des indicuté qui se soigne avec le act_any s'il sont atteint du palidisme' (qui aumente de 19%)

***Question 8: What is the associated standard error?
di _se[act_any]

***.044

***Question 9: What do you get when you divide the coefficient by the standard error?

di _b[act_any]/ _se[act_any]


****4.29
***Question 10: What is the t-statistic associated with the act_any variable?

di V[3,1]

** Email du prof    sene.omar@outloot.fr


************************************************************************************************************************************************************************************************************* home work*******************************************************

***Use the describe, summarize, and tabulate commands to familiarize yourself with the other variables in the data set.

describe // nous avons 575 individus et 23 variables


*************
*What are the mean and median levels of education among householde heads?
summarize b_h_edu
* la moyennne du niveau d'education du chef de menage  est 5.30 et la median est de 3.94

*************
*What proportion of households live more than 2 km from the nearest chemist?  
gen distant_2km = (b_dist_km > 2)
tabulate distant_2km

* 27,48 des menage sont plus de 2Km du la pharmacie soit 158 menages
*************
*For how many obesrvations is information on household size, the education level of the household head, and distance to the nearest chemist missing?
gen missing_household_size = missing(b_hh_size)
gen missing_education = missing(b_h_edu)
gen missing_distance = missing(b_dist_km)

tabulate missing_household_size 
tab missing_education 
tab missing_distance
**  taille du chef de menage pas de valeurs manquante 
**  education 3 valeurs manquante
**  ditance 1 valeurs manquante

*************
*Calculate the mean of c_act in the treatment group (observations with act_any==1) and in the comparison group (observations with act_any==0).
mean c_act if act_any == 1
mean c_act if act_any == 0

* la moyennne de c_act si act_any==1 est de 0,391
* la moyennne de c_act si act_any==0 est de 0,200

*How do these means relate to yourregression results above, when you regressed c_act on act_any?
regress c_act act_any
*le résultats de la régression confirment l'effet positif de chaque traitement sur c_act et quantifient l'ampleur de cet effet, ce qui est cohérent avec les différences observées dans les moyennes pour les groupes de traitement.
*************
* Now use the ttest command to test the hypothesis that the mean of c_act is the same in the treatment and comparison groups. How do these results compare to your regression results?
ttest c_act, by(act_any)

*les résultats du test t et de la régression suggèrent tous deux qu'il y a une différence statistiquement significative dans les moyennes de c_act entre les deux groupes définis par act_any

*************
*The variable coartemprice indicates the randomly-assigned ACT price (and, implicitly, the associated level of price subsidy). What price/subsidy levels are included in the experiment?
tabulate coartemprice
* nous avons 4 niveau de prix 
*40
*60
*100
*500
*************
*The variables act40, act60, act100, and act500 are dummies for individual randomly assigned prices/treatments. Summarize the mean level of c_act in each of the treatment arms (you already summarized the mean of c_act in the treatment group above).
summarize c_act if act40 == 1
summarize c_act if act60 == 1
summarize c_act if act100 == 1
summarize c_act if act40 == 0
summarize c_act if act60 == 0
summarize c_act if act100 == 0
*c_act if act40 == 1 la moyenne est de 0,443
*c_act if act60 == 1 la moyenne est de 0,371
*c_act if act100 == 1 la moyenne est de 0,364
*c_act if act40 == 1 la moyenne est de 0,310
*c_act if act60 == 1 la moyenne est de 0,332
*c_act if act100 == 1 la moyenne est de 0,332

*************
*Regress c_act on the dummies for the three subsidy levels (act40, act60, act100). How do the regression results compare to the means that you calculated for each treatment group?
regress c_act act40 act60 act100

*Coefficient pour act40 : 0,2427481
*Coefficient pour act60 : 0,1712121
*Coefficient pour act100 : 0,1641975
*La comparaison des coefficients de régression avec les moyennes calculées montre que les coefficients de régression représentent l'effet moyen attendu de chaque traitement sur c_act.
*************







