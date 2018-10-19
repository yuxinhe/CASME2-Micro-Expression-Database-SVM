# CASME2-Micro-Expression-Database-SVM
after preprocessing, lbp-top was used to extract features and SVM classification.
The code is mainly for implementing the methods mentioned in the CASME II: An Improved Spontaneous Micro-Expression Database and the Baseline Evaluation.
getlabel.m is a function to obtain CASME2 label
LBPTOP.m is a function to obtain the feature of Micro-Expression, Copyright 2009 by Guoying Zhao & Matti Pietikainen
main_CASME2_LBPTOP.m is mainly to use getlabel.m and LBPTOP.m to extract data label and features, and 5*5 block
main_CASME2_recognition.m is used libsvm and leave one out to obtain rate.
We ended up with a 54% recognition rate for the CASME2 database, and I believe that tuning parameters can also be improved.

The code is for my understanding of the article and is for academic research only.
yu xinhe ,Email 18818217180@163.com
