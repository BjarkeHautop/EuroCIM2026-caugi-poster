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
  keywords: "R package, causal inference",
  logo: image("logo_backup.svg", width: 130%),
)

#columns(2,[

  #pop.column-box(heading: "Motivation")[
    - Existing packages use low-level representations (e.g., adjacency matrices) and are not specialized for causal graphs.
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
      #image("dag.png", width: 55%)
    ])
  ]

  #pop.column-box(heading: "Querying and Metrics")[
    - *Relational queries*: `parents()`, `ancestors()`, `neighbors()`, etc.  
    - *Structural queries*: `is_acyclic()`, `is_cpdag()`, etc.  
    - *Causal queries*: `adjustment_set()`, `d_separated()`, etc.  
    - *Graph metrics*: `shd()`, `aid()`, etc.
  ]

  #pop.column-box(heading: "How it Works")[
    - *Backend:* Rust for memory safety and performance.

    - *Storage:* Compressed Sparse Row (CSR)
      - Memory-efficient for sparse graphs
      - Direct slice access #sym.arrow $$O(1)$$ adjacency lookup

    - *Immutable + lazy rebuild:*  
      - Rebuilds in $$O(|V| + |E|)$$ on query after graph modification.

    - *Result:* Fast, predictable queries with consistent graph state.
  ]

  #pop.column-box(heading: "Graph-class Safe", stretch-to-next: true)[
    - Think type safety, but for graphs.
    - Supports DAGs, PDAGs, ADMGs, UGs, and unknown graphs.
    - Adding edges that violate class constraints results in errors.
  ]

  #colbreak()
  #pop.column-box(heading: "Benchmarks")[
    We benchmarked `caugi` against `bnlearn`, `dagitty`, `ggm` and `igraph` for common graph queries on randomly generated DAGs of varying sizes.
  
  #image("parameterized-benchmark-parents-children.png", width: 100%)

  #image("benchmark-ancestors-decendants.png", width: 60%)

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
