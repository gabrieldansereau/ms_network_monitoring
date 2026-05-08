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
    Pair-wise within-simulation comparison of efficiency between all site selection strategies and optimization targets for 200 independent simulations. The comparison is based on the number of sites required to document 80% of the focal species' interactions ($n_0.80$), described in Equation 2. We use the labels $Delta$Option1~–~Option2 to highlight that the comparison value represents the $n_0.80$ for Option 1 minus the $n_0.80$ for Option 2. Negative values (in orange) indicate that the first compared option led to a more efficient sampling than the second one (lower $n_0.80$, faster documentation of interactions), while positive values (in green) indicate it required a higher sampling effort (higher $n_0.80$, slower documentation). Equal values (in pink) have overlapping confidence intervals. The order of the compared options matches Figure 5 and was selected for narrative purposes.

    *Samplers* BS: Balanced Sampling; WS: Weighted Sampling; BWR: Balanced Within Range; TS: Targeted Sampling;
    
    *Optimization Layers* RI: Realized interactions; SR: Species richness; PR: Probabilistic range; FR: Focal range
  ],
  numbering: n1 => numbering("S1", 1) 
)