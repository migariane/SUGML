# ELTMLE presentation at the SUGM:
## 2017 London Stata Users Group Meeting
## 2018 Barcelona Stata Users Group Meeting

# Content of the repository:
1. Complete version of the slides including a short introduction to the Causal Inference field.
2. Stata webdoc document including one-sample simulation to compare ELTMLE vs. other double-robust estimators under dual missepecification. You have to download the html document and then open it using your favorite browser, alternatively you can visit the following link:
   https://migariane.github.io/eltmle_one_sim.html

Note: GitHub helps scientists to implement reproducible research (version control with GitHub is FUN!)

# eltmle: Ensemble Learning Targeted Maximum Likelihood Estimation (Implementation for Stata software)  

**Modern Epidemiology** has been able to identify significant limitations of classic epidemiological methods, like outcome regression analysis, when estimating causal quantities such as the average treatment effect (ATE) or the marginal odds ratio, for observational data.       

For example, using classical regression models to estimate the ATE requires making the assumption that the effect measure is constant across levels of confounders included in the model, i.e. that there is no effect modification. Other methods do not require this assumption, including g-methods (e.g. the **g-formula**) and targeted maximum likelihood estimation (**TMLE**).     

The latter estimator has the advantage of being **doubly robust**. Moreover, TMLE allows inclusion of **machine learning** algorithms to minimise the risk of model misspecification, a problem that persists for competing estimators. Evidence shows that TMLE typically provides the **least unbiased** estimates of the ATE compared with other double robust estimators.           

The following link provides access to:  

1. a comprehensive Statistics in Medicine (SIM) TMLE tutorial: https://onlinelibrary.wiley.com/doi/full/10.1002/sim.76282. 
2. the complete code and supplementary files from the SIM article: https://github.com/migariane/SIM-TMLE-tutorial.  
3. an online TMLE tutorial using Rmarkdown: http://migariane.github.io/TMLE.nb.html     
    

**eltmle** is a Stata program implementing the targeted maximum likelihood estimation for the ATE for a binary or continuous outcome and binary treatment. Future implementations will offer more general settings. **eltmle** includes the use of a "Super Learner" called from the **SuperLearner** package v.2.0-21 (Polley E., et al. 2011). The Super-Learner uses V-fold cross-validation (10-fold by default) to assess the performance of prediction regarding the potential outcomes and the propensity score as weighted averages of a set of machine learning algorithms. We used the default SuperLearner algorithms implemented in the base installation of the **tmle-R** package v.1.2.0-5 (Susan G. and Van der Laan M., 2017), which included the following: i) stepwise selection, ii) generalized linear modeling (glm), iii) a glm variant that included second order polynomials and two-by-two interactions of the main terms included in the model.    

# Installation note    

ssc install etmle  
 
or alternatively to install eltmle directly from github you need to use a Stata module for installing Stata packages from GitHub, including previous releases of a package. You can install the latest version of the github command by executing the following code in your Stata session.  
  
**Note**: you need a Stata version greater or equal than 13.2, otherwise you can install the package manually downloading the files from the Github repository and placing it in your Stata ADO PERSONAL folder:   

    net install github, from("https://haghish.github.io/github/")

    then, you can install eltmle simply using the following code in Stata:
    
    github install migariane/eltmle  
   
        .which eltmle   

        .help eltmle   

    In case you want to uninstall the package type:    
	
        .ado uninstall eltmle   
     
 
# Author 
[Author and Developer]
Miguel Angel Luque-Fernandez, MA, MPH, MSc, PhD  
Biomedical Research Institute of Granada, University of Granada, Granada, Spain.  
LSHTM, NCDE, Cancer Survival Group, London, UK      
Email: miguel-angel.luque@lshtm.ac.uk 
https://maluque.netlify.com  


 
