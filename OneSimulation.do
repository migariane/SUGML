webdoc init OneSimulation, replace logall header(width(800px) stscheme(classic))

/***
<html>
<head>
<title>ELTMLE vs. competitors (RA, IPTW, IPTW-RA, and AIPTW) UNDER SEVERE MISSPECIFICATION</title>
</head>
***/

/***
<body>
<h2>2017 LONDON STATA USERS GROUP MEETING</br>
<h2>2018 BARCELONA STATA USERS GROUP MEETING</br>
<p></p>
*************************************************************************************
*! 2017 STATA USERS GROUP MEETING LONDON</br>
*! 2018 STATA USERS GROUP MEETING BARCELONA</br>
*! ELTMLE: Stata module for Ensemble Learning Targeted Maximum Likelihood Estimation</br>
*! by Miguel Angel Luque-Fernandez, PhD [cre,aut]</br>
*! Bug reports:</br>
*! miguel-angel.luque at lshtm.ac.uk</br>
**************************************************************************************
<p></p>
</h2>
***/

/***
<h2>Content</h4>
<h3>I) Data generation: one sample</br>
<p></p>
II)Dual misspecification: the worts-case scenario</br>
<p></p>
III) Results</br>
<p></p>
<p>Note: Data reproduce a Cancer Epidemiological example. The interpretation of the results is not applicable to real-world</p>

***/

/***
<h3>I) Data generation: one sample</h3>
***/

/***
<p>Setting your path and working directory</p>
***/
clear 
set more off
cd "/Users/MALF/Dropbox/SUML/OneSimulation"
//cd "Set your path"

/***
<p>One simulated dataset:</p>
<p>w1=Socieconomic status, w2=Age, w3=Cancer stage, w4=Comorbidities</p>
<p>Note: the interaction between age and comorbidities</p>
***/
set obs 1000
set seed 777
gen w1    = round(runiform(1, 5)) //Quintiles of Socioeconomic Deprivation
gen w2    = rbinomial(1, 0.45) //Binary: probability age >65 = 0.45
gen w3    = round(runiform(0, 1) + 0.75*(w2) + 0.8*(w1)) //Stage 
recode w3 (5/6=1)	//Stage (TNM): categorical 4 levels
gen w4    = round(runiform(0, 1) + 0.75*(w2) + 0.2*(w1)) //Comorbidites: categorical four levels
gen A     = (rbinomial(1,invlogit(-1 -  0.15*(w4) + 1.5*(w2) + 0.75*(w3) + 0.25*(w1) + 0.8*(w2)*(w4)))) //Binary treatment
gen Y     = (rbinomial(1,invlogit(-3 + A + 0.25*(w4) + 0.75*(w3) + 0.8*(w2)*(w4) + 0.05*(w1)))) //Binary outcome
// Potential outcomes
gen Yt1 = (invlogit(-3 + 1 + 0.25*(w4) + 0.75*(w3) + 0.8*(w2)*(w4) + 0.05*(w1)))
gen Yt0 = (invlogit(-3 + 0 + 0.25*(w4) + 0.75*(w3) + 0.8*(w2)*(w4) + 0.05*(w1)))
// True ATE
gen psi = Yt1-Yt0

/***
<p>TRUE SIMULATED ATE = 17.8%</p>
***/
mean psi

/***
<p>Saving the data in your desktop</p>
***/
save CancerData.dta, replace

/***
<h3>II) ATE estimation</h3>
<p>Note: We misspecified the models excluding the interaction between age and comorbidities</p>
***/

/***
<p>Regression adjustment ATE= 24.1%</p>
***/
teffects ra (Y w1 w2 w3 w4) (A)
estimates store ra

/***
<p>Inverse probability weighting ATE = 37.9%</p>
***/
teffects ipw (Y) (A w1 w2 w3 w4) 
estimates store ipw

/***
<p>IPTW-RA ATE = 31.9%</p>
***/
teffects ipwra (Y w1 w2 w3 w4) (A w1 w2 w3 w4)
estimates store ipwra

/***
<p>AIPTW ATE = 28.8%</p>
***/
teffects aipw (Y w1 w2 w3 w4) (A w1 w2 w3 w4)
estimates store aipw

/***
<h3>III) RESULTS</h3>
***/
quie reg psi
estimates store psi
estout psi ra ipw ipwra aipw

/***
<p>Ensemble Learning Maximum Likelihood Estimation (ELTMLE) ATE = 22.1%</p>
***/
eltmle Y A w1 w2 w3 w4, tmle

/***
<p>RELATIVE BIAS IPTW</p>
***/
display (0.38 - 0.18)/.38 

/***
<p>RELATIVE BIAS AIPTW</p>
***/
display (0.28 - 0.18)/0.28

/***
<p>RELATIVE BIAS ELTMLE</p>
***/
display (0.22 - 0.18)/0.22

/***
<h3><font color="blue">THANK YOU FOR YOUR ATTENTION</font></h3>
</body>
</html>
***/
webdoc close

//webdoc do OneSimulation.do
/*
Copyright (c) 2017  <Miguel Angel Luque-Fernandez>
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

