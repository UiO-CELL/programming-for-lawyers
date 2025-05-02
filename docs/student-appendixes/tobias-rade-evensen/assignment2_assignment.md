# Assignment 2 – The Assignment

Welcome to assignment 2 of Programming for Lawyers. All the portfolio assignments in this course are individual assignments. While you may discuss the assignment in general terms with other students, you should not share any concrete solutions, like code or text.

We strongly discourage use of AI or code generation tools like ChatGPT, since that will limit your learning. Use of such tools or code that you find on webpages or other sources must be disclosed in your assignment submission, conforming with [UiO policy](https://www.uio.no/english/studies/examinations/sources-citations/).

Please read the whole assignment text before you start working on the assignment.

The assignment should be done in Jupyter Notebook on Python 3. You can run Jupyter Notebook on your own computer by installing Anaconda 3 or use the UiO JupyterHub at [https://jupyterhub.uio.no/](https://jupyterhub.uio.no/). The completed Jupyter Notebook should be submitted in Canvas. This assignment consists of 7 tasks. Please identify the tasks in markdown headings in your notebook.

Make a Jupyter notebook named `assignment2.ipynb`.

## Data sets

We will work with tabular data in CSV files. We will start out with the small data set with only 10 cases. These files are located on JupyterHub:

```
/src/data/JUS5080/cases-10.csv
/src/data/JUS5080/cases-2000.csv

```

If you want to run on your own computer, you will need to download these files: [https://www.uio.no/studier/emner/jus/jus/JUS5080/h24/datasets/](https://www.uio.no/studier/emner/jus/jus/JUS5080/h24/datasets/)
- {Download}`cases-10.json<cases-10.json>`

## ECtHR and pandas

In this assignment we will work with data about the same cases as in assignment 1. This time you will solve the tasks using pandas and tabular data instead of JSON data. One of the main features of pandas is efficient data processing without loops. All the tasks in this exercise can be solved without using for or while loops. (You can use loops if you don't find any other way to solve the task, but there is probably a simpler way.)

## Task 2.1 (2 points)

Make a function that takes a filename as parameter. The function should open this file with pandas' function read_csv() and return the resulting DataFrame. Use the column "docname" as index with an argument to read_csv: `index_col='docname'`

The function should print an error message if there is an exception when opening the file, for example if the file doesn't exist. Now, use this function in a separate cell to load the file `cases-10.csv` into the object `cases`. Display the head (first 5 rows) of the table.

In the first tasks we will work with this data set. If you want to skip this task, you can load the cases with the code below. If you skip this task, you will get 0 points for it.

```
import pandas as pd
cases = pd.read_csv('/src/data/JUS5080/cases-10.csv', index_col='docname')
cases_2000 = pd.read_csv('/src/data/JUS5080/cases-2000.csv', index_col='docname')
```

## Task 2.2 (2 points)

The table 'cases' has several columns for different articles, starting with the string 'article'. These columns specify if the article is relevant for the case. The value is 1 if the article is relevant, otherwise it is 0. For example, the column named 'article=1' states whether article 1 is relevant, 'article=2' is for article 2 and so on.

Select the cases (rows) where article 8 of the ECHR is relevant, i.e., where the column named 'article=8' contains a 1. Display the selection with the function display().

## Task 2.3 (2 points)

1. Use a `filter` with a `regex` to select only the columns that have names _starting_ with 'article'. You can use an anchor in the regex.
2. Next, narrow your selection by only including the protocols to the ECHR, i.e. columns containing a 'p', such as p1.
3. Then, sum the columns to get a count of how many cases refer to each protocol.
4. Plot the result in a bar chart.

## Larger data set

Now, we will use a larger subset of the ECtHR cases, cases-2000.csv. Use your function from task 2.1 to read this table into a DataFrame cases_2000.

## Task 2.4 (3 points)

The table contains several columns of conclusions, with names starting with 'ccl_article'. For article N, the column name is 'ccl_article=N'. These columns have 3 possible values:

|Value|Meaning|
|---|---|
|1|violation|
|-1|no violation|
|0|no data/not relevant|

Make a plot of the number of non-violations for each article. (The number of cases where the court concluded with "no violation"). To do this, you can first select the conclusion columns that contain 'ccl_article'. Then, you should remove the 1 entries that signify "violation". You can do this by replacing every 1 with 0. To make the bars go up instead of down, you should then replace every -1 with 1. Finally, find the sum of the columns to get the total number of violations for each article.

Plot the result as a bar chart. For better readability, you might increase the figure size with the argument `figsize=(width,height)` to the `plot()` function, for example `figsize=(12,5)`.

## Task 2.5 (4 points)

1. Parse the 'decisiondate' column in cases_2000 into machine-readable format.
2. Get the year part of the dates
3. Use the `value_counts` function to find the number of decisions each year
4. Sort the results by year
5. Plot the results in a bar chart

## Task 2.6 (5 points)

As in task 2.4 we will look at the columns containing conclusions, with column names starting with 'ccl_article'. Write a function that finds the case(s) with the highest number of violations of a given article. By most violations we mean the most articles (including protocols) the Court found to beviolated.

The function should have two parameters:

- a pandas DataFrame of cases
- an article number

The function should print the article number, and the maximum number of violations found for this article. The function should return a DataFrame/selection that contains one or more cases that are tied for this highest number of violations.

Hint: When you have selected the columns you want to use, you need to count the 1's in each row. The function .value_counts() can't be used, since it counts in the wrong direction. Instead, you can use the `.sum()` function on the columns axis after replacing some entries similarly to task 2.4.

Use this function on the larger data set (cases_2000) and article 5. Display the DataFrame of cases that is returned by the function.

## Task 2.7 (1 point)

We sometimes need to convert data to different data formats. Use pandas to save the data set cases_2000 in Excel format as cases-2000.xlsx. Pandas uses the library openpyxl for Excel support, so you might need to install this. Paste this into a cell, and run it:

```
!pip install openpyxl

```

(However, you don't need to use openpyxl in your code, pandas does everything for you.)

We haven't covered this in the lectures, but you can look it up in your favorite search engine or read the [pandas documentation](https://pandas.pydata.org/docs/reference/io.html).