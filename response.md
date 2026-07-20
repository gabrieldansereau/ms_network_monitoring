## Associate Editor

> We have now received two reviews for your manuscript. Apologies that this
> process took so long, it was a challenge to find the interdisciplinary reviews
> required to robustly assess the manuscript. Both reviewers were extremely
> positive about the manuscript and have identified a range of minor revisions
> to improve aspects of the work. Thank you very much for your patience and I
> look forward to seeing the revised manuscript.

- Thank the editor

## Reviewer 1

> This is an interesting manuscript that addresses the challenge of sampling
> species interactions and designing optimal monitoring strategies within the
> Biodiversity Observation Network (BON) framework.
>
> The study is based entirely on simulation models, which is a reasonable—and
> perhaps the only practical—approach for addressing these questions at the
> scale considered. The analyses are carefully designed, the objectives are
> clear, and the results provide useful insights for biodiversity monitoring and
> sampling design. In my view, the manuscript is particularly well suited to
> journals with a strong focus on ecological methods and applied monitoring,
> such as *Journal of Applied Ecology* or *Methods in Ecology and Evolution*.
>
> Overall, the work is well executed. My comments below are primarily focused on
> improving the presentation and clarity of the manuscript.

- Thank the reviewer

> 
>
> --------------------------------------------------------------------------------
>
> lines 420 - 424: Is this paragraph intended to explain Figure 3 BON Examples?
> I couldn't find the mentioned summary in the text; this section should be
> modified for clarity. Also the captions of figure 3 and 4 should mention that
> they are showing examples.

- Yes, explaining Figures 3-4.
- Summary of results is Figure 5

> Figure 5 caption: The caption is difficult to follow, particularly the
> sentence: "The comparison value is based on the number of sites required to
> document 80% of the focal species' interactions (n_0.80), described in
> Equation 2." .It is unclear whether this statement refers to the x-axis or to
> another component of the figure. The comparison metric should be explained
> more explicitly.\

- Explain n0.80 first
- Then mention x-axis is the difference of n0.80 values

> In addition, the interpretation of the comparison summary is confusing. For
> example, the category *"Balanced within range"* appears to be lower than the
> reference value, yet it is classified as equal. The criteria used to
> distinguish "lower," "equal," and "greater" should be clarified. I am also
> puzzled by the magnitude of the reported differences. If the simulations range
> from only 1 to 500 sites, it is not obvious how the differences can exceed
> ±6,000. This point requires further explanation. From the figure itself, the
> reference value appears to correspond to 0, but to the right of this point
> there are both green and pink values representing "greater than" and "equal
> to" the reference. Although I assume confidence intervals are involved in this
> classification, the graphical representation is potentially misleading. I
> would expect a single bar with regions indicating lower, equal, and greater
> outcomes relative to the reference. At minimum, the caption should explain
> more clearly why some scenarios are represented by two bars.

- Reference is centred on 0, indicate exact same n0.80
- Equal values have overlapping confidence intervals, regardless of the sign
- Lower values are negative, beyond the confidence intervals, indicate a more
  efficient sampling
- Higher are opposite
- Confidence intervals vary per simulation (variance), hence we cannot delimit
  with single bars
- Scenarios represented by two bars/marker sets to highlight only potential
  results

> Finally, the color scheme could be improved. Green is typically associated
> with favorable outcomes, whereas in this figure the apparently preferred
> outcome is shown in orange. I suggest reconsidering or inverting the color
> palette to make the interpretation more intuitive.

- Colour choice is nice
- Pink-green is the clearest contrast, used for the most common comparison

> Figure 6 Panel B: appears to present essentially the same information as Panel
> A. Including both panels is therefore somewhat redundant and may create
> confusion for the reader. Unless Panel B provides additional information that
> is not already conveyed in Panel A, I would suggest removing it or more
> clearly highlighting its distinct purpose and interpretation.

- Panel B is summarized version of A, focusing on comparison result sign
- Panel A displays the range in absolute value, along with the linear trend
- Keep only B and move A to supp mat? Looking back, proportion of simulations is
  most important result, not absolute values and linear trend

> Lines 504 - 513: Here you repeat the concept that species interactions require
> more sampling effort. Likewise, the connection to the BON framework is
> reiterated multiple times.

- Rephrase to minimize redundancy while keeping result

> Lines 518: I would suggest removing the phrase "Through our representative
> example in Figure 3". In the Discussion, the focus should be on interpreting
> and synthesizing the findings rather than directing readers to specific
> figures. The statement would read more smoothly if it referred directly to the
> result or pattern observed, without explicitly citing the figure.

- Makes sense. Remove references to Figures in Discussion

> Lines 521–524: This section introduces a question that is immediately answered
> in the following paragraph, creating unnecessary repetition. This rhetorical
> structure may be useful in some forms of writing, but it is not particularly
> effective in a scientific discussion. I suggest stating the main point
> directly and integrating the explanation into a single, concise argument.

- Replace rhetorical questions by: ... leaving open questions of determining the
  information most efficient to target sites in sampling designs and the
  precision required.

## Reviewer 2

> The manuscript entitled "Optimizing sampling and monitoring of species
> interactions within Biodiversity Observation Networks" is concise in its
> conclusions and detailed in the methods. Arguments are well written and
> relevant, although I included a few suggestions that may add to the debated
> ideas. Concerning the methods, almost all steps for model design and
> construction were listed and explained, but the use of different definitions
> of interactions may confuse the reader in some parts (listed below).

- Thank the reviewer

> Also, The authors should inform the reader at the beginning of the methods
> section that they only consider higher-degree trophic interactions. I guess a
> vegetation model would perform completely differently, and the same would
> apply if they included primary consumers. Of course the predator-prey
> relationship is one of the most known and intuitive (based on Eurocentric
> ecological foundation) but that is a great limitation of the model, and
> possibly not one of the most relevant interactions in many ecosystems.

- Model is not limited to predator-prey relationship
- Focus on predator-prey is choice, but can go further than that

> Monitoring efforts always must prioritize cost-effective approaches, and the
> manuscript message points in that direction. However, it also gives a clear
> message about the importance of target choice, which depends completely on the
> actual natural history knowledge about the target. That changes the focus of
> most BONs, which are concerned about community scale because we lack this
> refinement about species natural history.

- Emphasis on Target choice is a change in focus, but comparable to some BONs
  (e.g. China-BON)
- Interactions are costly enough that it might be required
- Our work explores if it is actually necessary and improvements to expect if we
  were to do so

> Another caveat that could be reinforced is the effect of species richness and
> the limitation of those models for species-rich ecosystems (e.g. tropical
> forests). In this case, it is almost impossible to pinpoint a key species
> considering a large body of literature since Paine's work about trophic
> interactions and richness. Thus, the approach proposed in this manuscript may
> be restricted for species-poor and well-connected ecosystems. That and other
> limitations of the applied models were modestly touched upon in the
> discussion, but should be better developed. The most important contribution of
> any model is its limitations, from which others can build new strategies. The
> idea behind this manuscript is great and well executed, but the authors could
> add a little more on the cons than the pros of their approach.

- Discuss

> Line 149 - NLMs and species interaction samples: Makes sense to indicate the
> grain size, since spatially-autocorrelated distributions are considered.

- Not spatial
- Add a comparison?

> Line 154 - what type of realistic spatially-correlated distributions were
> applied? I'd like to understand if fragmented habitats are considered or if
> the model only deals with continuous gradients, disregarding potential
> enclaves or hot spots and other abrupt changes between landscape domains
> (which are a common feature).

- Mention the Diamond-Square algorithm on L163 and examples on Figures 3-4
- Essentially represents fragmented habitats with potential enclaves and abrupt
  changes, not continuous

> Line 172 - The feasible interactions are only based on trophic interactions,
> which depend on natural history information. Thus, how would that work for
> species high places? How species richness affects models? Were herbivory
> interactions considered or just animal-animal interactions? Otherwise, I would
> state clearly that only trophic interactions \> third degree are considered
> here.

- Implementation without plant-herbivore interactions through niche model
- Conceptually compatible if a metaweb including herbivore interactions is
  available, or if we integrate them in some ways

> Line 179 - detected, realized and possible interactions are all conditioned by
> species abundances. Rare species interaction should be relevant for risk
> extinction on alien invasive species, which may be more ecologically relevant
> than the direct consumption of abundant prey, or even if invasive species are
> not abundant but voracious (e.g. lionfish).

- ?
- Describe it's a model assumption
- Briefly discuss implications

> Line 202 - the determination of location is key considering that this model
> could be used for sampling at different scales, and also links with the
> question about line 149 above

- Discuss

> Line 245 - sampled interactions = detected interactions? Is it possible to
> clarify or use the same definitions from generated models? This can be
> confusing.

- No, sampled interactions = realized interactions, hence the additional term
- Explain focus on sampled interactions as long-term target through repeated
  monitoring
- Different intent than Figure 1 with detected interactions, where we aim to
  show difference in expected scale of magnitude

> Line 254 - it is always hard to define thresholds, and 80% seems a good number
> for interactions, but how realistic should this number be based on real data?
> Are the authors aware of expected values for a given richness value (the
> applied 75 taxa) or a range? Are these considered detected interactions?

- Discuss

> Line 276 - Please include exploratory outputs in a supplementary material
> because only fixed parameters were applied.

- TODO

> Line 281 - Move this explanation before the indication of parameters values,
> in line 270. I'd prefer to have the details about the simulations before the
> model explanation, together with the interactions definitions. This way, we
> may have the idea before the execution, although I understand that the model
> construction steps are key to understanding how it was tested. That's more of
> a reflection because I deleted some comments after reaching this sentence, but
> still left some to illustrate how this order affected the reading.

- Need to consider two types of parameter values: ecological ones (connectance,
  landscape, species) vs SIS.jl specific ones