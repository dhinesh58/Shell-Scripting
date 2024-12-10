**AWK Command** 

It's is a powerful text-processing tool used in Unix-like operating systems. It allows you to manipulate and analyze text files, such as extracting and transforming data. Here are some basic usages and examples of the awk command:

***Syntax***
```
awk 'pattern {action}' filename

```

***Print Specific Columns:***

To print specific columns from a file, such as the first and third columns:

```
awk '{print $1, $3}' filename
```