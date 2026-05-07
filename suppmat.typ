#title("Supplementary Material")

#text(12pt)[
  Optimizing sampling and monitoring of species interactions within Biodiversity Observation Networks - Dansereau et al. 2026
  ]

#show figure.caption: it => {
    set align(left)
    set par(leading: 0.55em, hanging-indent: 0pt)
    text(10pt, it)
  }

#figure(
  image("figures/supp/efficiency_comparison_all.png"),
  caption: [
    Pair-wise within-simulation comparison of efficiency between all samplers and optimization layers. The comparison values are based on the difference of the $n_0.80$ measure for the efficiency curves described in Equation 1. Positive difference values (in blue) indicate that the first compared option led to a more efficient sampling than the second option, while negative values (in orange) indicate that the second option was more efficient.

    *Samplers* WBA: Weighted Balanced Acceptance; SR: Simple Random; US: Uncertainty Sampling;
    *Optimization Layers* RI: Realized interactions; SR: Species richness; PR: Probabilistic range; FR: Focal range
  ],
  numbering: n1 => numbering("S1", 1) 
)