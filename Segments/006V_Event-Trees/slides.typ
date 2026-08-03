// Boilerplate
#import "../nei-style/lib.typ": *


#show: typslides.with(
  ratio: "16-9",
  title: "Bayesian Networks",
  subtitle: "Understanding how one random variable can affect another",
)

// Slides

#slide(title:"Bullet Lists")[

  We can model coffee orders with *five* variables:
  - $t_0 in {1,2,3}$
  - $r in RR$
  - $p in QQ$
  - $arrow(x) in RR^2$
  - $hat(y) in RR times QQ$

  Each variable _is important!_
]

#focus-slide[
  The shop is doing well, but different baristas excel at different coffees.

  When a customer walks in, we want to route the order to the _right_ barista.
]

#slide(title:"Tables and Columns")[

    A _Bayesian Network_ encodes dependencies as a directed graph, and each node has a CPT.

    #divider()

    #cols(columns: (2fr, 3fr))[

    *Root node example:*

    $P("Weather")$

    #table(
      columns: 2,
      align: center,
      inset: 6pt,
      [*Weather*], [*P*],
      [Cold], [0.25],
      [Mild], [0.50],
      [Hot], [0.25],
    )
    ][
      *Non-root example:*

      $P("Coffee" | "Tolerance", "Weather")$

      _(showing 2 of 9 rows)_

      #table(
        columns: 4,
        align: center,
        inset: 6pt,
        [*T,W*], [*Esp*], [*Latte*], [*Flat White*],
        [Low, Cold], [0.60], [0.20], [0.20],
        [High, Hot], [0.20], [0.25], [0.55],
      )
    ]



]


#slide(title:"Boxes and Equations")[
  For a random variable whose domain is $RR$, the following is _always_ true:

  #boxed[
    $integral_(-infinity)^(infinity) p(x) upright(d)x = 1.0$
  ]

  Where $p$ is the probability density function of the random variable $x$.

  This is analogous to the the discrete case:

  #boxed[
    $sum_(x in X) P(x) = 1.0$
  ]
]

#slide(title:"Pseudocode")[
#set text(size:20pt)
#pseudocode-list[
  + define bfs($G$, $v$):
    + for all $u in V$:
      + $"hops"[u] := infinity$
    + $"hops"[v] := 0$
    + $Q."push_tail"(v)$
    + while $Q$ is not empty:
      + $u := Q."pop_head"()$
      + for all edges $(u, v) in E$:
        + if $"hops"[v] = infinity$:
          + $Q."push_tail"(v)$
          + $"hops"[v] := "hops"[u] + 1$
]
]

#slide(title:"Diagram from DrawIO")[
  #image("test2.pdf",height:100%)
]

// #slide(title:"Photo with credit and blockquote")[
#focus-slide[
#cols(columns: (1fr, 3fr))[
  #image("dogpic.jpg")
  #credit[Photo by Basile Morin]
][
  #blockquote(author: "Samuel Butler")[
    "The greatest pleasure of a dog is that you may make a fool of yourself with him, and not only will he not scold you, but he will make a fool of himself too."
  ]
]]

#slide(title:"Code")[
```c
#include <stdio.h>

int main() {
    int a, b, c;  // Declare variables
    a = 3;        // Initialize variables
    b = 4;
    c = a + b;    // Do addition
    printf("%d + %d = %d\n", a, b, c);
    return 0;
}
```
]


#final-slide(title:"Bayesian Networks")[
  #keyvalue("Reading", "Sections 13.1 - 13.3.1")

  #keyvalue("Tomorrow's Lab", "Making Full Joint Distributions")
]
