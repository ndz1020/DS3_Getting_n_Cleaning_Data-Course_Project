# Getting and Cleaning Data - Course Project

## Introduction

This repository contains my course project work for "Getting and Cleaning Data", the third course the Data Science Specialization on Coursera.  What follows first are my notes on the original data.


## About the raw data

The 561 features are unlabeled and stored in the x_test.txt. 
The activity labels are in the y_test.txt file. 
The test subjects are in the subject_test.txt file.

The same holds for the training set.

## About the script and the tidy dataset

A script named run_analysis.R was created.  It will merge the training and test data sets together. 
Prerequisites for this script are:
1. the UCI HAR Dataset must be extracted, and
2. the UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"

Labels are added after merging training and test, but only the needed ones to calculate the mean and the standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

## About the Code Book

The CodeBook.md file explains the transformations performed and the resulting data and variables.
