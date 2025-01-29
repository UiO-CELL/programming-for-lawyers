# Assignment 1 – The Assignment

Welcome to this assignment of Programming for Lawyers. All the portfolio assignments in this course are individual assignments. While you may discuss the assignment in general terms with other students, you should not share any concrete solutions, like code or text.

We strongly discourage use of AI or code generation tools like ChatGPT, since that will limit your learning. Use of such tools or code that you find on webpages or other sources must be disclosed in your assignment submission, conforming with [UiO policy](https://www.uio.no/english/studies/examinations/sources-citations/).

Please read the whole assignment text before you start working on the assignment.

The assignment should be done in Jupyter Notebook on Python 3. You can run Jupyter Notebook on your own computer by installing Anaconda 3 or use the UiO JupyterHub at [https://jupyterhub.uio.no/](https://jupyterhub.uio.no/). The completed Jupyter Notebook should be submitted in Canvas.

This assignment consists of 5 tasks. Identify the tasks in markdown headings in your notebook.

## Prerequisites

Some of the weekly exercises are tailored specifically to prepare you for this assignment. We recommend that you complete at least these exercises before you start on this assignment.

## HUDOC and the European Court of Human Rights OpenData project

In this assignment you will work with cases from the European Court of Human Rights (ECtHR). These cases are available at the HUDOC website. HUDOC has various filters, for example the option of filtering on non-violation or violation as well as article. However, with a Python program we can make our own custom filters to extract different information and statistics. The ECtHR cases are also available in machine-readable format at the European Court of Human Rights OpenData (ECHR-OD) project. We will use a subset of this data set for this assignment. The cases will refer to the European Convention on Human Rights (ECHR). The data set sometimes uses the term "article" for both Articles and Protocols of the convention.

## Data sets

We will start out with a small data set with only 10 cases and use a larger data set with 2000 cases for the last tasks. Both are subsets of ECHR-OD. These files are located on JupyterHub:

```
/src/data/JUS5080/cases-10.json
/src/data/JUS5080/cases-2000.json

```

If you want to run on your own computer, you will need to download these files:

- [https://www.uio.no/studier/emner/jus/jus/JUS5080/h24/datasets/cases-10.json](https://www.uio.no/studier/emner/jus/jus/JUS5080/h24/datasets/cases-10.json)
	- {Download}`cases-10.json<cases-10.json>`
- [https://www.uio.no/studier/emner/jus/jus/JUS5080/h24/datasets/cases-2000.json](https://www.uio.no/studier/emner/jus/jus/JUS5080/h24/datasets/cases-2000.json)

## Task 1.1 (1 point)

Make a Jupyter notebook named assignment1.ipynb. Paste the following code in a cell of the notebook:

```
import json

def read_json_file(filename):
    with open(filename, 'r') as file:
        text_data = file.read()
        json_data = json.loads(text_data)
        return json_data  

file = '/src/data/JUS5080/cases-10.json'
cases = read_json_file(file)


```

This loads the case data from a shared directory on JupyterHub. If you are running on your own computer rather than JupyterHub, the last line should be:

```
cases = read_json_file('cases-10.json')

```

The following tasks will use the data in the object cases.

## Task 1.2 (2 points)

If you use the variable name "case" to refer to a single case, it will have the case name in `case['docname']`. Each case also has an application number in `case['appno']`. Loop through the list "cases" and print the names and application numbers of all the cases.

Example output:

`CASE OF SKLYAR v. RUSSIA : 45498/11`

## Task 1.3 (4 points)

Each case has a list of parties in the key `parties`. Collect all the parties from all the cases in a list, by looping through the cases.

The list should contain the names directly, not be a list of lists. Finally, print this list of parties.

Example output:

['SKLYAR', 'RUSSIA' ..]

## Task 1.4 (5 points)

Now, we will use a larger subset of the ECHR-OD cases. If you're running on JupyterHub, load the cases like this:

```
cases_2000 = read_json_file('/src/data/JUS5080/cases-2000.json')
```

Write a function `get_parties_by_year(cases)`. The function has one parameter, "cases" a list of cases.

The function should return a dictionary where the keys are years, and the values are lists of all the parties to cases from that year. The dictionary should be constructed by looping through all cases and extracting the year from the 'judgementdate' of each case. You can use the datetime library as described in [part 1 of the lecture notes](https://uio-cell.github.io/programming-for-lawyers/docs/01_basics.html#parsing-dates).

A small example of such a dictionary:

```
{2017: ['SKLYAR',  'RUSSIA'],
 2016: ['A, B AND C',  'A.K.']}
```

Call the function with the argument cases_2000 and print the first 5 parties from the year 1999 from the result.

## Task 1.5 (5 points)

Write a function that has a list of cases as its only parameter. The function should go through the cases in the list and find the 'president' and 'judges' of the panel of judges for each case. After collecting the presidents and judges for all the cases, make a list containing the names that only appear as president, never as judges. Print the number of names in this list.

Return this list of names of people appearing only as president.