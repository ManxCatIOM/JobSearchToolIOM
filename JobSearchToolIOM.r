###############################################################################
###############################################################################
## Programme: JobSearchToolIOM                                               ##
## Version: 1.00                                                             ##
## Analyst: ManxCatIOM                                                       ##
## Date last modified: 10-Sep-2023                                           ##
## Description: This programme searches for the available job vacancies in   ##
##              the Isle of Man so people can with a simple click have all   ##
##              the relevant info in a single CSV file or R DataFrame.       ##
###############################################################################
###############################################################################

#Selection of Key Libraries required
library(rvest)
library(xml2)
library(stringr)

#Start data collection from IOM Job Centre

urlJobSelector <-'https://services.gov.im/job-search/results?AreaId=&ClassificationId=&SearchText=&LastThreeDays=False&JobHoursOption='

#Start web Scrapping process

#Selection of the Job Title

webJobSelector<-read_html(urlJobSelector)                             
webJobSelectorJob<-html_nodes(webJobSelector ,'td a')                 
webJobSelectorJobReadable<-html_text(webJobSelectorJob)
head(webJobSelectorJobReadable)

#Selection of the Employer

webJobSelectorEmployer<-html_nodes(webJobSelector,'td:nth-child(3)')
webJobSelectorEmployerReadable<-html_text(webJobSelectorEmployer)
head(webJobSelectorEmployerReadable)

#Selection of the Hours which also says if full or part time vacancy

webJobSelectorHours<-html_nodes(webJobSelector,'td:nth-child(4)')
webJobSelectorHoursReadable<-html_text(webJobSelectorHours)
head(webJobSelectorHoursReadable)

#Gets the Link of the vacancy, so a person can click in any preferred vanacy

Link<-html_attr(webJobSelectorJob,"href")
Link<-paste("https://services.gov.im",Link,sep="")

#Creates a dataframe

jobList<-data.frame(JobDescription=webJobSelectorJobReadable,
                       Employer=webJobSelectorEmployerReadable,
                       Hours=webJobSelectorHoursReadable,
                       Link)

#Writes dataframe into a CSV

write.csv(jobList,"//chooseYourPath//JobList.csv")
