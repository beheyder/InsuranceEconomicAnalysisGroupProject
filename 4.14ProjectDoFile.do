*Group 6 do file
* Year dummy variables
generate year2009 = 0
replace year2009 = 1 if year == 2009

generate year2013 = 0
replace year2013 = 1 if year == 2013

* Removing observations if the person is 25 or younger
drop if age <=25
* Changing Health variable to healthy = 1 and unhealthy = 0
* good, very good, and excellent will be considered "good health"
* fair, and poo will be considered "bad health"
generate veryHealthy = 0
replace veryHealthy = 1 if health == 1| health == 2
replace veryHealthy = . if health == .
*replace health = 1 if health == 1 | health == 2 | health == 3
*replace health = 0 if health == 4 | health == 5
summarize veryHealthy

* Insurance coverage dummy variables
generate Insured = 0
replace Insured = 1 if hcovany == 2
replace Insured = . if hcovany == .

generate Uninsured = 0
replace Uninsured = 1 if hcovany == 1
replace Uninsured = . if hcovany == .


* Family income dummy variables
*tabulate fam inc to find quartiles
replace faminc = . if faminc == 995 | faminc == 996 | faminc == 997 | faminc == 999
*tabulate faminc

generate faminc0_29999 = 0
replace faminc0_29999 = . if faminc == .
replace faminc0_29999 = 1 if faminc == 100 | faminc == 110| faminc == 111| faminc == 112| faminc == 120| faminc == 121| faminc == 122| faminc == 130| faminc == 131| faminc == 132| faminc == 140| faminc == 141| faminc == 142| faminc == 150| faminc == 200| faminc == 210| faminc == 220| faminc == 230| faminc == 231| faminc == 232| faminc == 233| faminc == 234| faminc == 300| faminc == 310| faminc == 320| faminc == 330| faminc == 340| faminc == 350| faminc == 400| faminc == 410| faminc == 420| faminc == 430| faminc == 440| faminc == 450| faminc == 460| faminc == 470| faminc == 480| faminc == 490| faminc == 500| faminc == 510| faminc == 520| faminc == 530| faminc == 540| faminc == 550| faminc == 560| faminc == 600| faminc == 700| faminc == 710
*summarize faminc0_29999

generate faminc30000_59999 = 0
replace faminc30000_59999 = . if faminc == .
replace faminc30000_59999 = 1 if faminc == 720| faminc == 730| faminc == 740| faminc == 800| faminc == 810| faminc == 820
*summarize faminc30000_59999

generate faminc60000_99999 = 0
replace faminc60000_99999 = . if faminc == .
replace faminc60000_99999 = 1 if faminc == 830| faminc == 840| faminc == 841
*summarize faminc60000_99999

generate faminc100000_150000plus = 0
replace faminc100000_150000plus = . if faminc == .
replace faminc100000_150000plus = 1 if faminc == 842| faminc == 843
*summarize faminc100000_150000plus


* Race dummy variables
replace race = . if race == 999
*tabulate race

generate white = 0
replace white = . if race == .
replace white = 1 if race == 100

generate black = 0
replace black = . if race == .
replace black = 1 if race == 200

generate nativeAmerican = 0
replace nativeAmerican = . if race == .
replace nativeAmerican = 1 if race == 300

generate asian = 0
replace asian = . if race == .
replace asian = 1 if race == 650| race == 651| race == 652

generate otherRace = 0
replace otherRace = . if race == .
replace otherRace = 1 if race == 700| race == 801| race == 802| race == 803| race == 804| race == 805| race == 806| race == 807| race == 808| race == 809| race == 810| race == 811| race == 812| race == 813| race == 814| race == 815| race == 816| race == 817| race == 818| race == 819| race == 820| race == 830


* Employment status dummy variables
replace empstat = . if empstat == 00

generate employed = 0
replace employed = . if empstat == .
replace employed = 1 if empstat == 01| empstat == 10| empstat == 12

generate unemployed = 0
replace unemployed = . if empstat == .
replace unemployed = 1 if empstat == 20| empstat == 21| empstat == 22
 
generate notInLaborForce = 0
replace notInLaborForce = . if empstat == .
replace notInLaborForce = 1 if empstat == 30| empstat == 31|empstat == 32|empstat == 33|empstat == 34|empstat == 35|empstat == 36


* Education dummy variables
replace educ = . if educ == 000| educ == 001|educ == 999

generate lessThanHighschool = 0
replace lessThanHighschool = . if educ == .
replace lessThanHighschool = 1 if educ == 002| educ == 010| educ == 011| educ == 012| educ == 013| educ == 014| educ == 020| educ == 021| educ == 022| educ == 030| educ == 031| educ == 032| educ == 040| educ == 050| educ == 060| educ == 070| educ == 071| educ == 072

generate highschool = 0
replace highschool = . if educ == .
replace highschool = 1 if educ == 073

generate someCollege = 0
replace someCollege = . if educ == .
replace someCollege = 1 if educ == 080| educ == 081| educ == 090| educ == 091| educ == 092| educ == 100| educ == 110

generate collegePlus = 0
replace collegePlus = . if educ == .
replace collegePlus = 1 if educ == 111| educ == 120| educ == 121| educ == 122| educ == 123| educ == 124| educ == 125

* Illustrative Figures
/*
help graph bar
graph bar (mean) Insured, over(faminc, lab(angle(45)))
graph bar (mean) health, over(Insured)
graph bar (mean) Insured, over(age, lab(angle(90)))
graph bar (mean) veryHealthy, over(Insured)
*/
 
 
summarize

* regressions
*help logit
logit veryHealthy Insured white black nativeAmerican asian employed unemployed highschool someCollege collegePlus faminc30000_59999 faminc60000_99999 faminc100000_150000plus age nchild if year2009 == 1

margins if year2009 == 1, dydx( Insured white black nativeAmerican asian employed unemployed highschool someCollege collegePlus faminc30000_59999 faminc30000_59999 faminc60000_99999 faminc100000_150000plus age nchild) atmeans

logit veryHealthy Insured white black nativeAmerican asian employed unemployed highschool someCollege collegePlus faminc30000_59999 faminc60000_99999 faminc100000_150000plus age nchild if year2013 == 1

margins if year2013 == 1, dydx( Insured white black nativeAmerican asian employed unemployed highschool someCollege collegePlus faminc30000_59999 faminc30000_59999 faminc60000_99999 faminc100000_150000plus age nchild) atmeans


