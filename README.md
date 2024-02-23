# Ventiotools:

Ventiotools is an essential tool developed by vent.io to streamline the collection and management of Python packages within the company's ecosystem. This package provides a unified platform for consolidating information about all packages, making it easier for developers, data scientists, and engineers to access, share, and maintain the company's Python libraries.

## Installation

`ventiotools` is available on PyPI. Simply install it with `pip`:

```         
$ pip install ventiotools
```

## Usage

Ventiotools can easily be accessed after installing it via pip:

```         
>>> import ventiotools 
>>>
>>> Your code here... 
```

# Auto_Feature_Engineering:
```         
>>> from ventiotools import auto_feature_engineering
>>>
>>> Your code here... 
```

Auto_Feature_Engineering is a powerful subpackage of Ventiotools built for efficiently creating features from large datasets by harnessing the capabilities of Apache Spark. This package is specifically tailored to handle statistical and time series feature engineering, making it an ideal choice for data scientists and engineers working with extensive datasets.

### General Purpose

This Package serves the purpose of automatically creating additional features for a given dataset. It is parallelized using **Apache Spark**.  
The functionality of the package includes:

1. Data Profiling  
   -> Figure out the datatype of each column in a dataframe based on regular expressions  
   -> Impute missing values in a dataframe (function _impute_missing_values_)
2. Feature Generation  
   -> For **Numerical Variables**, create several aggregations (e.g. sum, min, max, mean, median) with the possibility to group by a certain variable and also having the possibility to only take into account a certain timeframe within the dataset and create rolling, lagging and accumulating statistics for it (for timeseries problems)  
   -> For **Date Variables**, extract information such as month, day of the year etc. and also give the opportunity to encode the variables (as of now, there is only the opportunity to use _sin-cos-encoding_)  
   -> For **Categorical Values**, enable One-Hot-Encoding

The Dataframe is read in using _Databricks Connect_.  
Finally, the Dataframe can be saved as a _Databricks Table_ for further analysis.

### Explanation of each Function

#### featureprep.py

##### profile_data

This function determines the datatype of a column in a dataframe by using regular expressions.  
Currently, it can determine the following datatypes:

- Numerical (for float and int)
- Categorical (for all columns with less than 20 distinct values)
- Integer
- Float
- String
- Date
- Datetime

Input: Dataframe with columns to profile  
Returns: Dictionary with the Datatype and their related columns

##### impute_missing_values

This function serves the purpose to fill missing values with a given value.

Input:
(_df_, _column_types_, _numerical_value_, _categorical_value_)

- df: Dataframe with the missing values
- column*types: The column types as a dictionary (from the \_profile_data* function)
- numerical_value: Value to fill in the missing values in numerical columns (default: mean value of the column)
- categorical_value: categorical_value to fill in the categorical variables (default: "missing")

Returns: Imputed Dataframe

#### feature_generator.py

##### generate_features

This function serves the purpose to generate all the features for numerical, categorical and date variables.  
It calls each function for the variables seperately.  
Input: Dataframe, Configuration File as YAML  
Returns: Dataframe with Additional Features

##### generate_date_features

This function creates additional features for date variables. As of now, it can extract the following values:

- month
- year
- dayofmonth
- dayofweek
- dayofyear
- weekofyear
  The function also gives the opportunity to apply sin-cos encoding to the given values. This is helpful for the extraction of cyclical behaviour.  
  The encoding has to be enabled in the config file.  
  Input: Dataframe, Configuration File as YAML  
  Returns: Dataframe with Additional Features

##### generate_numerical_features

This function creates additional features for numerical variables. As of now, it can apply several statistical functions such as _min_,_max_,_mean_, etc. to a column.  
It can also take into account a certain timeframe within the dataset and create rolling, lagging and accumulating statistics for it (for timeseries problems).  
Input: Dataframe, Configuration File as YAML  
Returns: Dataframe with Additional Features

##### generate_categorical_features

This function creates additional features for categorical variables by applying One-Hot-Encoding to it. This means that for a column with less than 20 distinct values, each value will get their own column (If the value is given, the column will contain 1, else 0)  
This enables several machine learning models to use this function as they can only process numerical values.  
Input: Dataframe, Configuration File as YAML  
Returns: Dataframe with Additional Features

### Outlook

The goal of this package is to automate the time consuming feature engineering process. In the future, the package shall be enhanced to also being able to _select n most important features_ and _train a model on the data with the new features_. Finally, a comparison between the package's output and a model without feature engineering shall be done to demonstrate the advantage of using it.
