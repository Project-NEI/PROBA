#import "../nei-style/lib.typ": *

#show: typslides.with(
  ratio: "16-9"
)

#front-slide(
  title: "Bayesian Networks",
)


#slide(title:"Bullet Lists")[

  We can _model_ coffee orders with five variables:
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
  #boxed[
    $p(k) = binom(n,k) r^k q^(n-k)$
  ]
  #boxed[
    $integral_(-infinity)^(infinity) p(x) upright(d)x = 1.0$
  ]
]

#slide(title:"Pseudocode")[
#set text(size:20pt)
#pseudocode-list[
  + *define* bfs($G$, $v$):
    + for all $u in V$:
      + $"hops"[u] := infinity$
    + $"hops"[v] := 0$
    + $Q."push_tail"(v)$
    + *while* $Q$ is not empty:
      + $u := Q."pop_head"()$
      + *for all* edges $(u, v) in E$:
        + *if* $"hops"[v] = infinity$:
          + $Q."push_tail"(v)$
          + $"hops"[v] := "hops"[u] + 1$
]
]

#slide(title:"Diagram from DrawIO")[
  #image("test.pdf",height:100%)
]

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


#final-slide[
  #keyvalue("Reading", "Sections 13.1 - 13.3.1")

  #keyvalue("Photo", "Rex Savage")
]
