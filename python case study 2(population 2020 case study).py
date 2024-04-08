# -*- coding: utf-8 -*-
"""
Created on Wed Feb 21 17:59:36 2024

@author: DEBANJAN
"""

import pandas as pd
import matplotlib.pyplot as plt
#step :1 [Import the Dataset]
data = pd.read_csv("/Users/DEBANJAN/Downloads/population_by_country_2020.csv")
# step: 2 [display first few rows of the dataset]this is the first part of analyse the data........
print(data.head())
#step:3 information about the dataset, including data types and missing value this is the second part of data analyse
print(data.info())
#step : 4 [Display summary statistics for numerical columns]this is the third part of analyse of data.
print(data.describe())
#step : 5 [ Convert 'Population (2020)' column to numeric type] This step ensures that the 'Population (2020)' column is treated as numeric data, which is essential for numerical calculations and analysis.
data['Population (2020)'] = pd.to_numeric(data['Population (2020)'], errors='coerce')
#step :6 [ Remove duplicate rows, if any] [preventing any potential biases or inaccuracies in analysis.]
data.drop_duplicates(inplace=True)
#step :7 [Impute missing values in 'Net Change' column with the mean of the column] [helps to maintain the integrity of the dataset and avoid biases in analysis.]
data['Net Change'].fillna(data['Net Change'].mean(), inplace=True)
#step:8 [Remove rows where 'Density (P/Km²)' is greater than 1000, assuming it's an outlier] [that means the values that fall more than three standard deviations from the mean]
data = data[data['Density (P/Km²)'] < 1000]
#step :9 [create new coloum based on the logic] [Calculate 'Population Density' by dividing 'Population (2020)' by 'Land Area (Km²)] [provides additional insights into the dataset and facilitates more in-depth analysis.]
data['Population Density'] = data['Population (2020)'] / data['Land Area (Km²)']
# step :10 [Calculate total migrants per country] [# Considering the migration rate is given per 1000 population]
data['Total Migrants'] = data['Migrants (net)'] * data['Population (2020)'] / 1000

#step :11 [Calculate percentage of urban population] [considering the urben population is given per 100 population]
data['Urban Population (%)'] = data['Urban Pop %'] * data['Population (2020)'] / 100.

#step :12 [Create a bar chart of top 10 countries by population] [to understand and visualize the data in a structured manner]
top_10_population = data.nlargest(10, 'Population (2020)')
plt.figure(figsize=(10, 6))
plt.bar(top_10_population['Country (or dependency)'], top_10_population['Population (2020)'])
plt.title('Top 10 Countries by Population (2020)')
plt.xlabel('Country')
plt.ylabel('Population')
plt.xticks(rotation=45)
plt.show()
#step :13 [Create Pie Chart]
# Calculate total population for each country
country_population = data.groupby('Country (or dependency)')['Population (2020)'].sum()
# Sort countries by population in descending order
country_population = country_population.sort_values(ascending=False)
# Select top 10 countries by population for better visualization
top_10_country_population = country_population.head(10)
# Create a pie chart to visualize the distribution of population across top 10 countries
plt.figure(figsize=(10, 8))
plt.pie(top_10_country_population, labels=top_10_country_population.index, autopct='%1.1f%%', startangle=140)
plt.title('Distribution of Population Across Top 10 Countries', fontsize=25)  # Adjust title fontsize here
plt.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle
plt.show()

# Step 3: Create Histogram
plt.figure(figsize=(20,10))
plt.hist(data['Population (2020)'], bins=5, edgecolor='black')
plt.title('Distribution of Population Sizes Across Countries')
plt.xlabel('Population Size')
plt.ylabel('Frequency')
plt.grid(True)
plt.tight_layout()
plt.show()

# step :14 [Analyze the Updated Data Again]
avg_population_density = data['Population Density'].mean()
print("Average Population Density:", avg_population_density)
