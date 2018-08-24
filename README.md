---
title: "README.md"
author: "Jinkwan Hong"
date: "2018년 8월 24일"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Overview

This project is to make the following data set into a tidy data set

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Library
data.table

## Input

The data should reside on the specific relative path for the script to run accordingly

./UCI HAR Dataset/test/X_test.txt
./UCI HAR Dataset/test/Y_test.txt
./UCI HAR Dataset/train/X_train.txt
./UCI HAR Dataset/train/Y_train.txt
./UCI HAR Dataset/test/subject_test.txt
./UCI HAR Dataset/train/subject_train.txt
./UCI HAR Dataset/features.txt

## Script
run_analysis.R

## Codebook
./UCI HAR Dataset/features.txt  - Code numbers and matching features
Variable names are assigned according to this document
./UCI HAR Dataset/features_info.txt   - Verbose description about each variables
./UCI HAR Dataset/activity_labels.txt - Activity labels. Activities are matched according to this document

## Output
subject_activity_means.txt.
A tidy data set of the raw data.