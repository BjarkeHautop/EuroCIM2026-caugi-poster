set.seed(1405)

cg <- caugi(
  A %-->% B + C,
  B %-->% D,
  C %-->% D
)
plot(cg)
library(ggplot2)

generate_graphs <- function(n, m, seed = NULL) {
  cg <- caugi::generate_graph(n = n, m = m, class = "DAG", seed = seed)
  ig <- caugi::as_igraph(cg)
  ggmg <- caugi::as_adjacency(cg)
  bng <- caugi::as_bnlearn(cg)
  dg <- caugi::as_dagitty(cg)
  list(cg = cg, ig = ig, ggmg = ggmg, bng = bng, dg = dg)
}

n <- 1000
graphs <- generate_graphs(n, m = n * 100, seed = 1405) # dense graph
cg <- graphs$cg
ig <- graphs$ig
ggmg <- graphs$ggmg
bng <- graphs$bng
dg <- graphs$dg

test_node_name <- "V1"

bm_parents_children <- bench::mark(
  caugi = {
    caugi::parents(cg, test_node_name)
    caugi::children(cg, test_node_name)
  },
  igraph = {
    igraph::neighbors(ig, test_node_name, mode = "in")
    igraph::neighbors(ig, test_node_name, mode = "out")
  },
  bnlearn = {
    bnlearn::parents(bng, test_node_name)
    bnlearn::children(bng, test_node_name)
  },
  ggm = {
    ggm::pa(test_node_name, ggmg)
    ggm::ch(test_node_name, ggmg)
  },
  dagitty = {
    dagitty::parents(dg, test_node_name)
    dagitty::children(dg, test_node_name)
  },
  check = FALSE, # igraph returns igraph object
  max_iterations = 1000
)

plot(bm_parents_children)

bm_parents_children_np <-
  bench::press(
    n = c(100, 500, 1000, 2500, 5000, 7500, 10000),
    d = c(5, 10),
    {
      m <- as.integer(d * n)

      graphs <- generate_graphs(n, m = m, seed = 1405 + n + d)
      cg <- graphs$cg
      ig <- graphs$ig
      ggmg <- graphs$ggmg
      bng <- graphs$bng
      dg <- graphs$dg

      test_node_name <- "V1"

      bench::mark(
        caugi = {
          caugi::parents(cg, test_node_name)
          caugi::children(cg, test_node_name)
        },
        igraph = {
          igraph::neighbors(ig, test_node_name, mode = "in")
          igraph::neighbors(ig, test_node_name, mode = "out")
        },
        bnlearn = {
          bnlearn::parents(bng, test_node_name)
          bnlearn::children(bng, test_node_name)
        },
        ggm = {
          ggm::pa(test_node_name, ggmg)
          ggm::ch(test_node_name, ggmg)
        },
        dagitty = {
          dagitty::parents(dg, test_node_name)
          dagitty::children(dg, test_node_name)
        },
        check = FALSE
      )
    },
    .quiet = TRUE
  )

plot_parameterized_benchmark <- function(bm) {

  bm_mod <- within(
    bm,
    {
      expr <- as.character(expression)
      median <- as.numeric(median)
    }
  )

  ggplot(bm_mod, aes(n, median, color = expr)) +
    geom_line() +
    geom_point() +
    scale_y_log10() +
    facet_wrap(~d, labeller = labeller(d = function(x) paste0("avg. degree = ", x))) +
    labs(
      x = "n",
      y = "Time (s)",
      color = NULL
    ) +
    theme(
      # Increase facet label size
      strip.text = element_text(size = 12),

      # Add space between panels
      panel.spacing = unit(1, "lines")
    )
}

p <- plot_parameterized_benchmark(bm_parents_children_np)
p
ggsave(
  filename = "parents_children_benchmark.svg",
  plot = p,
  width = 12,
  height = 7,
  units = "in"
)
