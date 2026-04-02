#import "@preview/peace-of-posters:0.5.6" as pop

#let spacing = 1.2em
#set page("a0", margin: 1.5cm)
#let my-layout = pop.layout-a0 + (
  body-size: 33pt
)

#pop.set-poster-layout(my-layout)
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
  keywords: "R package, causal inference",
  logo: image("logo_backup.svg", width: 130%),
)

#columns(2,[

  #pop.column-box(heading: "Motivation")[
    - Existing packages use low-level representations (e.g., adjacency matrices) and are not specialized for causal graphs.
    - Causal workflows often jump between graph objects, adjacency matrices, and package-specific APIs.
    - *Goal:* provide a graph interface that is expressive,
      safe, and efficient for causal inference.
  ]

  #pop.column-box(heading: "Key Contributions")[
    - *High-performance backend:* Rust implementation with efficient graph
      traversal.
    - *Type-safe graph classes:* Enforce DAG, PDAG, ADMG,
      UG constraints at the graph level.
    - *Expressive syntax:* Compose graphs with concise R formulas.
    - *Scalable queries:* Efficient evaluation of ancestry and neighborhood
      relations in large graphs.
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
      #image("dag.png", width: 60%)
    ])
  ]

  #pop.column-box(heading: "Querying and Metrics")[
    - *Relational queries*: `parents()`, `ancestors()`, `neighbors()`, etc.  
    - *Structural queries*: `is_acyclic()`, `is_cpdag()`, etc.  
    - *Causal queries*: `adjustment_set()`, `d_separated()`, etc.  
    - *Graph metrics*: `shd()`, `aid()`, etc.
    
    *Example queries:*
    ```R
    > parents(cg, "D")
    [1] "B" "C"
    
    > d_separated(cg, "A", "D", Z = c("B", "D"))
    [1] TRUE
    ```
  ]

  #pop.column-box(heading: "How it Works", stretch-to-next: true)[
    - *Backend:* Rust for memory safety and performance.

    - *Storage:* Compressed Sparse Row (CSR)
      - Memory-efficient for sparse graphs
      - Direct slice access #sym.arrow $$O(1)$$ adjacency lookup

    - *Immutable + lazy rebuild:*  
      - Rebuilds in $$O(|V| + |E|)$$ on query after graph modification.

    - *Result:* Fast, predictable queries with consistent graph state.
  ]
  
  #colbreak()

  #pop.column-box(heading: "Graph-class Safe")[
    - Think type safety, but for graphs.
    - Supports DAGs, PDAGs, ADMGs, UGs, and unknown graphs.
    - All graph modifications are checked against class constraints.
      - E.g., adding an edge that creates a cycle in a DAG is prevented.
    - Ensures reliable, consistent graph state throughout analysis.
  ]

  #pop.column-box(heading: "Benchmarks")[
    - Benchmarked `caugi` against `bnlearn`, `dagitty`, `ggm`, and `igraph` for parent and child queries on DAGs #footnote[
      Benchmark environment: R 4.5.3, x86_64-pc-linux-gnu, Linux Mint 22.3,
      CPU: AMD Ryzen 7 8845HS, RAM: 14Gi.
      Using bench package for benchmarking.
    ].
      - We report median runtime from bench package.
    - `caugi` consistently achieved the lowest computation times across graph sizes and degree settings.
    - Additional queries (ancestors, descendants, d-separation) showed the same ranking, with `caugi` often around an order of magnitude faster.
  #image("parents_children_benchmark.svg", width: 100%)
  ]
  #pop.column-box(heading: "Contact", stretch-to-next: true)[
    - Pkgdown site: #link("https://caugi.org/")[caugi.org]
    - GitHub: #link("https://github.com/frederikfabriciusbjerre/caugi/")[frederikfabriciusbjerre/caugi]
    #set align(center)
    #image("qr-url.pdf", width: 50%)
  ]
])

#pop.bottom-box(
	stack(
    dir: ltr,
    h(0.5fr),
		image(height: 120pt, "eurocim-icon.gif"),
    h(1fr),
		image(height: 120pt, "ku-logo.png"),
    h(1fr),
		image("smart-biomed.png", height: 120pt),
    h(0.5fr)
	)
)
