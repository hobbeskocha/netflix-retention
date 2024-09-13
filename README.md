# Improving Customer Retention for Netflix

## Overview

This is a data analysis project (focussed on MySQL and Power BI) conducted by [Ayush Shrestha](https://www.linkedin.com/in/ayush-yoshi-shrestha/), as part of a team project for BUS AN 512 (Data Management and Visualization) for the University of Washington's Master of Science in Business Analytics program. Other team contributors include
[Hyewon Jeong](https://www.linkedin.com/in/jeonghyewon/),
[Aartdina van den Hoek](https://www.linkedin.com/in/aartdina/),
[Xin Hu](https://www.linkedin.com/in/xinhu-ashley/),
and [Bryant Tsai](https://www.linkedin.com/in/btsai1996/).

The project analyzed a synthetic dataset (originally retrieved from Kaggle [here](https://www.kaggle.com/datasets/arnavsmayan/netflix-userbase-dataset)) of Netflix customer records.

## Business Problem

As competition in the streaming market intensifies, Netflix must leverage its wealth of customer data to refine its retention strategies and maintain audience engagement. Without these efforts, certain customer segments may start disengaging from the platform, which in the worst case would lead to increased churn through unsubscribing. By utilizing data-driven strategies, Netflix can gain insights into retention trends across its customer base, identify high-risk segments prone to churn, and tailor its marketing efforts, content acquisition, and production strategies to re-engage and retain those viewers effectively.

## Pre-processing

For ease of data ingestion into MySQL Workbench, the original CSV file was converted into a SQL DDL script using an online tool. During the conversion, several key parameters were configured to ensure accuracy, including defining the primary key, enforcing data integrity constraints (such as non-null values for certain columns), and adding a DROP TABLE statement at the beginning of the script for easy reusability. This approach streamlined the setup process and ensured the data was properly structured for analysis.

## EDA

Exploratory Data Analysis (EDA) was conducted using MySQL to examine the distribution of customers across available factors, such as geographic region, subscription plan, and preferred device type. Additionally, descriptive statistics, including ranges and averages, were calculated for various segments to assess data spread and central tendencies. This preliminary analysis provided a comprehensive overview of the dataset, positioning us to proceed with an in-depth analysis of customer retention rates.

## Processing

## Analysis

## Findings & Recommendations

While the data contains a wealth of insights, one of the most noteworthy is that North American (NA) customers aged 41-50, which comprise 35% of the NA market, have a 5% lower retention rate, suggesting the opportunity for a 1.75% retention increase through targeted marketing.
