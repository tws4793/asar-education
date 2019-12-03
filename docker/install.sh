#!/usr/bin/bash
while IFS=" " read -r package; 
do 
  R -e "install.packages('"$package"', dependencies = TRUE, repos = 'http://cran.rstudio.com')"; 
done < "requirements.txt"