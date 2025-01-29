# Assignment 3 – The Assignment
## Introduction

Welcome to assignment 3 of Programming for Lawyers. All the portfolio assignments in this course are individual assignments. While you may discuss the assignment in general terms with other students, you should not share any concrete solutions, like code or text.

We strongly discourage use of AI or code generation tools like ChatGPT, since that will limit your learning. Use of such tools or code that you find on webpages or other sources must be disclosed in your assignment submission, conforming with [UiO policy](https://www.uio.no/english/studies/examinations/sources-citations/).

Please read the whole assignment text before you start working on the assignment.

The assignment should be done in Jupyter Notebook on Python 3. You can run Jupyter Notebook on your own computer by installing Anaconda 3 or use the UiO JupyterHub at [https://jupyterhub.uio.no/](https://jupyterhub.uio.no/). The completed Jupyter Notebook should be submitted in Canvas.

This assignment consists of six tasks. Please identify the tasks by number in your notebook.

## Prerequisites

In this assignment, you will work with the same ECHR-OD JSON data as an assignment 1. We have provided functions to convert the facts section of the cases into text. Please [get the file assignment3.ipynb here](https://uio.instructure.com/courses/52633/files/3074823?wrap=1 "assignment3.ipynb") [Download get the file assignment3.ipynb here](https://uio.instructure.com/courses/52633/files/3074823/download?download_frd=1).

This assignment requires some libraries, most of which should be available on JupyterHub. If you want to do the assignment on your own computer, you will need to install top2vec by executing this command on [Anaconda Prompt](https://docs.anaconda.com/anaconda/user-guide/getting-started/#cli-hello):

```
conda install -c conda-forge top2vec

```

## Dataset

The data are located on JupyterHub:

```
/src/data/JUS5080/cases-1000.json

```

If you want to run your code on your own computer, you will need to download the data: [https://www.uio.no/studier/emner/jus/jus/JUS5080/h23/datasets/](https://www.uio.no/studier/emner/jus/jus/JUS5080/h23/datasets/)
- {Download}`cases-1000<cases-1000.json>`

## Unsupervised learning — top2vec

top2vec is an unsupervised clustering algorithm for topic modeling. It produces clusters of documents that are called topics. Each cluster/topic is represented by a centroid, as discussed in Unsupervised Learning (uio-cell.github.io). Importantly, top2vec is nondeterministic. This means that you will get different results each time you run it.

There is a tutorial for top2vec here, which covers most of task 3.1, 3.2, and 3.3: [https://github.com/ddangelov/Top2Vec](https://github.com/ddangelov/Top2Vec)

## Precode

Copy the code below into your Jupyter Notebook. It contains functions to extract the decision text from the cases in the ECHR-OD data set. You will need it to do the assignment.

In [1]:

```
import json

def read_json_file(filename):
    'Read json data from a file'
    with open(filename, 'r') as file:
        text_data = file.read()
        json_data = json.loads(text_data)
        return json_data
```

In [2]:

```
def json_to_text(doc, include_headings=True):
    '''
    Extract content text from JSON tree structure.
    https://echr-opendata.eu/doc/

    Params:
        doc: ECHR JSON element
        include_headings: Whether to include the section headings
    '''
    def json_to_text_helper(doc):
        result = []
        if not doc['elements'] or include_headings:
            result.append(doc['content'].strip().replace('\xa0', ' '))  # replace non-breaking space
        for element in doc['elements']:
            result.extend(json_to_text_helper(element))
        return result
    return '\n'.join(json_to_text_helper(doc))

def get_facts(case):
    'Get the "Facts" section of the case text'
    content = case['content']
    docname = list(content)[0]
    document = content[docname]

    for section in document:
        if section.get('section_name') == 'facts':
            return json_to_text(section)
    return ''

def get_conclusion(case, article):
    '''
    Get the conclusion of the case regarding the specified article
    '''
    conclusions = case['conclusion']
    for conclusion in conclusions:
        if conclusion.get('article', '').startswith(article):
            return conclusion['type']
    return 'no conclusion'
```

## Task 3.1 (2 points)

Load the data set cases-1000.json, and an extract the facts from each case with the function get_facts() that we have provided.

The data set of 1000 cases takes up memory, and the memory on JupyterHub is quite limited. To save memory, you should avoid storing the data set twice, both the original version and the version processed with `get_facts(case)`. You can accomplish this by using the same variable name for the processed cases as for the original data set, thus overwriting the variable. Another way is to use the `del`-statement to delete the original variable once you are done with it.

## Task 3.2 (4 points)

1. Make a model by training top2vec on this list of texts.

This should look something like `model = Top2Vec(documents)`, perhaps with some more arguments. This will take some minutes. Top2vec has a parameter `min_count` with a default value of 50. Words that occur less than `min_count` times in all the documents in total are ignored. You might want to set a lower value, for example `min_count = 10`. You can play around with the value and see which one works best.

2. Print the number of topics found, and the number of documents in each topic, i.e. the topic sizes.

## Task 3.3 (4 points)

Visualize the clusters/topics with top2vec's word cloud function. Make one word cloud per topic.

## Task 3.4 Make an exercise (5 points)

Make an exercise that could be used as a weekly exercise or portfolio assignments task for your fellow students. The exercise should:

- concentrate on a problem relevant to the legal sector
- be limited to topics taught in this course, such as JSON data, pandas, or other topics from the curriculum
- demonstrate knowledge of some of the techniques taught in this course, such as lists, dictionaries, loops etc.
- be possible to solve with a few lines of code, for example 10 to 25 lines of code
- have a difficulty appropriate for students learning to program
- if you use data: include any necessary data either as part of the Jupyter Notebook, or with a link to an open data set that can be downloaded

This task will be graded based on these factors:

- how interesting the problem is
- how well specified the task description is
- how hard the problem is

## Task 3.5 Make a solution for your exercise (5 points)

Make a solution for the exercise you made in the previous task.

This task will be graded based on these factors:

- how well written/readable the solution is
- how hard the problem is
- how well the solution works