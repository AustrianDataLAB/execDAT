# ExecDat - Value Proposition

## What is the core value being generated?

The goal of this project is to provide researchers with an easy and efficient way to execute and verify scientific evaluations, regardless of whether the required data and code is local or remote.

This will be achieved through the development of a user-friendly tool, which could take the form of a CLI tool, kubectl plugin, or API endpoint. The tool will enable easy remote execution of code that requires access to remote or local datasets, simplifying the research process and reducing the technical barriers to entry.

## Team

### Project owner / Deputy owner

DAT Team

### Team members

Daniel Hofstätter, Alexander Woda and Thomas Weber

## Problem Space

Why are we doing this?  How do we judge success?

### Problem statement

Researchers face difficulties executing code that requires access to remote or local datasets.

I.e., executing scientific evaluations on those datasets exclusively local might be problematic because users face large dataset sizes and have certain dependencies on, for example Operating Systems or Hardware. Furthermore, the current coupling of code to local hardware leads to limitations in parallel executions, resulting in high evaluation and iteration times.

### Impact of this problem

The impact of the problem is that it can slow down the progress of research and create barriers to entry for researchers with limited technical expertise. The manual setup and management of research environments can be time-consuming, distracting, and prone to errors. This can limit the ability of researchers to explore and analyze data, and ultimately, hinder the development of new scientific insights and breakthroughs. The impact is especially significant in fields such as data science and machine learning, where access to large and complex datasets is crucial for research.

E.g., imagine a scientific paper is published, or going to be published, and reviewers want to verify results in them, maybe even for different datasets. Downloading Gigabytes of data or demanding hours of runtime on limited hardware slows down the review process.

### Who is the customer/ target audience

The target audiences for the proposed software tool are researchers and scientists who require access to remote or local datasets for their research. This includes researchers in fields such as data science, machine learning, and other areas that require extensive data analysis.

For Example:

Everyone interested in research, but with an initial scope limited to Universities (Professors, students, etc.)
Universities to host our service and provide access to staff
Research teams at any organization

### Criteria for Success

We provide simplicity of execution, reusability of environments, proofable validity of results and asynchronicity in the evaluation process. Our solution is to create a user-friendly software tool that simplifies the process, reduces time and effort, and allows researchers to focus on their research questions.

According to these goals, we define the following criteria:

Usability: One simple function call should be enough.
Scalability: Multiple users should be able to do evaluations in parallel.
Flexibility: Should support multiple languages and a variety of operating systems.
Repeatability: Different users should get the same results for the same evaluation.

## MVP

### What needs to be true in order for a prototype to be ready for release?

We can ship an MVP to researchers and scientists, as soon as we have the following MUST-HAVEs:

#### Functional MUST-HAVEs

Remote code execution: The tool enables remote execution of code that requires access to remote datasets.

Parallel execution support: The tool supports parallel execution of scientific evaluations to reduce evaluation and iteration times.

Result size: A maximum size of one Gigabyte in the result file is supported.
User interaction: Only one CLI command and one config file is needed to run a job.
E.g., "execDAT <src_code_dir>" or "kubectl apply -f <spec_file>"

#### Non-Functional MUST-HAVEs

Flexibility: We support at least two different environment configurations.
Scalability: Scales to at least two users each having at least two jobs running.
Validity of results: Two users executing with the same configuration file get the same result.

### What crucial factors are we missing?

Definition of work packages
Technical Overview Diagram
Cluster Access

### What is the key question we would ask to understand if we are on the right track?

Do we simplify the research process?
In a side-by-side comparison, are users preferring to use our service, compared to a local execution of the task on their hardware?

### Who are the alpha testers that we can use for validating our assumptions?

DAT Team
