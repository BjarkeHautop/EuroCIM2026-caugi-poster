#import "@preview/peace-of-posters:0.5.6" as pop

#let spacing = 1.2em
#set page("a0", margin: 1.5cm)
#pop.set-poster-layout(pop.layout-a0)
#pop.set-theme(pop.uni-fr)

#set text(size: pop.layout-a0.at("body-size"))

#let box-spacing = 1.2em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

#pop.title-box(
  "caugi: fast and flexible causal graph interface for R",
  authors: [
    Frederik Fabricius Bjerre¹²,
    Johan Larsson²,
    #text(weight: "bold")[Bjarke Hautop Kristensen]¹#super[†], \
    Michael C Sachs¹
  ],
  institutes: [
    ¹ Section of Biostatistics, University of Copenhagen, \
    ² Department of Mathematical Sciences, University of Copenhagen, \
    #super[†] #link("bjarke.hautop@gmail.com")
  ],
  keywords: "R, causal inference, software",
  logo: circle(image("favicon.pdf"), fill: white, inset: -10pt),
)

#columns(2,[

  #pop.column-box(heading: "Motivation")[
    - *Historically* users need to use adjacency matrices, edge lists, or general-purpose packages like `igraph`.  
      - Writing a graph from an adjacency matrix is like writing a novel in binary: possible, but not fun.
    - *`caugi` provides:* a _causality-first_ graph package that emphasizes performance, flexibility, and readable syntax for causal graphs.
  ]

  #pop.column-box(heading: "Basic Usage")[
    #columns(2, [
      Syntax like a picture in your head:
      ```R
      cg <- caugi(
        A %-->% B + C,
        B %-->% D,
        C %-->% D,
        class = "DAG"
      )
      plot(cg)
      ```
      #colbreak()
      #image("dag.png", width: 55%)
    ])
  ]

  #pop.column-box(heading: "Querying and metrics")[
    - *Relational queries*: parents(), ancestors(), neighbors(), etc.  
    - *Structural queries*: is_acyclic(), is_cpdag(), etc.  
    - *Graph manipulations*: add_edge(), remove_node(), etc.  
    - *Graph metrics*: shd(), aid(), etc.  
  ]

  #pop.column-box(heading: "How it works")[
    - *Backend*: Rust implementation for speed and safety.  
    - *Graph storage*: Compressed Sparse Row (CSR) format.  
      - Fast queries; slower graph mutations compared to other formats.  
    - *Result*: Flexible and highly efficient causal graph querying in R.
  ]

  #pop.column-box(heading: "Why caugi?")[
    - *Graph-class safe:* Think type safety, but for graphs.
      - Supports DAGs, PDAGs, ADMGs, UGs, and unknown graphs.
      - Trying to add an edge to a DAG that would create a cycle will throw an error.
    - *Performance:* Fast querying of large graphs.
    - *Intuitive syntax:* Express edges as simple R formulas, e.g., ```R A %<->% B + C```.
  ]
  #colbreak()
  #pop.column-box(heading: "Benchmarks")[
    We benchmarked `caugi` against `bnlearn`, `dagitty`, `ggm` and `igraph` for common graph queries on randomly generated DAGs of varying sizes.
  
  Find example with long running time instead of these sub 1sec examples?

  Insert images ...

  ]
  #v(1fr)
  #pop.column-box(heading: "Contact")[
    - Pkgdown site: #link("https://caugi.org/")[caugi.org]

    #image("qr-url.pdf", width: 50%)
  ]
])
