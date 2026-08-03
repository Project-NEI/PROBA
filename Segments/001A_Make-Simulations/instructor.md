
### PROBA Activity 1
# Instructor Guide for *Making Simulations*

This will be the students' first lab, so they will need some hand-holding. _Fortunately_, the goals for this session are pretty modest.

## Key Concepts

To explore probability using Python, the student needs a few basic skills. They will learn this foundation today:

- How to generate pseudorandom floating point numbers between 0 and 1.
- How to simulate flipping a coin a million times.
- How to simulate rolling a 100-sided die a million times.
- How to make a basic bar chart.

## References

- The [standard `random` module](https://docs.python.org/3/library/random.html) reference page

---

## Steps

0. The student needs to have a text editor and Python installed on their computer.

1. In a text editor, the student will make a file called `random1.py`.  They are trying to print 20 random numbers between 0 and 1.  Here is a solution:

```python
import random

for _ in range(20):
    print(random.random())
```

When it runs, it looks like this (but, of course, their numbers will be different):

```
$ python3 random1.py
0.4094994240162769
0.5866120149450935
...
0.16618582100435253
0.25114406877794404
```
