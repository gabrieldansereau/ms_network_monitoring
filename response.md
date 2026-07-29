## Associate Editor

> We have now received two reviews for your manuscript. Apologies that this
> process took so long, it was a challenge to find the interdisciplinary reviews
> required to robustly assess the manuscript. Both reviewers were extremely
> positive about the manuscript and have identified a range of minor revisions
> to improve aspects of the work. Thank you very much for your patience and I
> look forward to seeing the revised manuscript.

- Thank the editor

--------------------------------------------------------------------------------

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

> lines 420 - 424: Is this paragraph intended to explain Figure 3 BON Examples?
> I couldn't find the mentioned summary in the text; this section should be
> modified for clarity. Also the captions of figure 3 and 4 should mention that
> they are showing examples.

Yes, this paragraph refers to the showcased example in Figures 3 and 4,
representative of the most common results across all independent landscape
configurations. We clarified this by specifically mentioning Figures 3 and 4 in
this paragraph. The summary we referred to is Figure 5, which directly presents
across the 200 independent configurations. We now mention Figure 5 in the
paragraph as well. We added a mention in the captions to clarify that Figures 3
and 4 are showing examples, as suggested.

> Figure 5 caption: The caption is difficult to follow, particularly the
> sentence: "The comparison value is based on the number of sites required to
> document 80% of the focal species' interactions (n_0.80), described in
> Equation 2." .It is unclear whether this statement refers to the x-axis or to
> another component of the figure. The comparison metric should be explained
> more explicitly.

The statement and "comparison value" indeed refer to the x-axis. We agree this
was unclear, especially given that x-axis value is the *difference* between two
$n_{0.80}$ values for the options being compared. We changed the sentence to
explicitly mention the comparison: "*The comparison value (x-axis) is the
difference between the* $n_{0.80}$ *(number of sites required to document 80% of
the focal species' interactions, see Equation 2) for a given strategy or target
and the* $n_{0.80}$ *of its reference.*" We believe that further explaining the
measure is not necessary, as the $n_{0.80}$ value is already described in the
Methods and Equation 2, and would make the caption even more difficult to
follow.

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

We apologize for the confusion, which resulted in part from the lack of clarity
over the difference measure mentioned in the previous point. To better explain,
we need to distinguish three elements: the $n_{0.80}$ value, the comparison
value (position on the x-axis) and the overlap of the confidence intervals (the
marker colour and associated category). First, the $n_{0.80}$ measures the
number of sites required to sample 80% of the interactions. It may go beyond the
number of sites evaluated in our simulations (1-500) because it is derived from
an accumulation curve fitted to the simulation results (described in details in
the Methods, section *Step 3: Defining a comparable measure for sampling
efficiency*). Next, a difference value of 0 (x-axis on Figure 5) indicates that
the option under comparison (e.g. Balanced Within Range) had the exact same
$n_{0.80}$ as the reference. Positive values indicate that the $n_{0.80}$ was
higher while negative values indicate it was lower. However, the order of
magnitude of the difference is specific to each independent simulation—the
$n_{0.80}$ values compared may be 500 and 600 in one simulation but 3000 and
4000 in another—thus, we cannot represent a single bar or "regions" for the
categories. Therefore, we use the confidence intervals of the
$n_{0.80}$(described in the Methods) to classify the results in the three
categories : Equal (overlapping intervals between the compared option and the
reference), Lower and Higher (non overlapping intervals).

To address this concisely, we updated Figure 5's caption to:

- First describe what the positive and negative values represent
- Then describe the colours, categories, and classification based on the
  confidence intervals
- Finally describe the right side summary panels, which display the percentage
  of simulations falling into each comparison category (these were not
  previously described in the caption).

The last addition regarding the summary panels also makes it more intuitive that
some scenarios are represented by two bars because they have results falling
into two categories (Equal and Higher), whereas others have results in a single
category (Lower). As the caption is already quite convoluted, we prefer not to
add an additional explanation for this.

> Finally, the color scheme could be improved. Green is typically associated
> with favorable outcomes, whereas in this figure the apparently preferred
> outcome is shown in orange. I suggest reconsidering or inverting the color
> palette to make the interpretation more intuitive.

We thank the reviewer for this suggestion. We reconsidered and updated the
colour palette, although in a different way than suggested.

Our colour choice is intended to optimize the contrast between the most common
comparison results on Figs 5-6, namely "Equal" and "Higher". Pink and green
offer the clearest contrast and is our preferred option among many tested for
Figs 5-6. However, the reviewer's comment helped us realize we were using green
for "Higher" although it represents the least favourable option, which is
counter-intuitive. This was especially striking on Fig 6 B for the
overestimation results (right-side on the x-axis).

Given this, we decided to inverse the colours for "Equal" and "Higher". Our new
palette has: green for "Equal"—the "default" comparison result and a favourable
outcome in the context of Fig 6 (as over/underestimation is as efficient as the
using the exact species range), pink for "Higher"—the least favourable outcome,
and orange for "Lower"—the "most favourable" but surprising outcome, which
barely occurs and should stand out as a special case whenever it appears. The
same reasoning also applies on Fig 5—strategies or targets being equal to the
reference is "good" (i.e. we can use either interchangeably), while having a
lower $n_{0.80}$ is even better, but rather unexpected.

Note that marker positions are slightly different on Fig 6A as we updated the
label order in the legend, which triggered a change in the random jitter (x-axis
position offset) of all markers. We confirm that the results did not change and
that the markers have the exact same y-axis position. Panel B confirms this, as
the proportion of simulations associated to each outcome stayed the same.

> Figure 6 Panel B: appears to present essentially the same information as Panel
> A. Including both panels is therefore somewhat redundant and may create
> confusion for the reader. Unless Panel B provides additional information that
> is not already conveyed in Panel A, I would suggest removing it or more
> clearly highlighting its distinct purpose and interpretation.

We respectfully disagree with the suggestion to remove Panel B, as we believe
the two panels play a distinct, complementary role. The reviewer's
interpretation is correct regarding some the information being shared: Panel B
essentially summarizes the proportions presented on Panel A in a more accessible
way, focusing on only on the variation of the proportions between the comparison
outcomes. Yet, this information is more precise than on Panel A, as the
proportions are shown at all 2% interval increments. The tolerance to up to 10%
overestimation, abrupt change beyond this threshold, and contrast with the much
slower, progressive shift in the underestimation case all serve as key results
in our manuscript, which Panel B clearly supports. Nonetheless, we reworded some
sentences in this paragraph to mention the abrupt and progressive changes, and
we hope it better highlights Panel B's purpose.

Meanwhile, we also want to reinforce the relevance of Panel A, whose role is to
display the magnitude of the change in efficiency with over/underestimation
compared to the reference $n_{0.80}$. The key result is the clear linear trend
with overestimation, following the addition of non-informative sites, which
contrasts with the high variance observed with underestimation. We realized that
the implications of these findings were barely discussed; therefore, we briefly
expanded on them in the second-to-last section of the Discussion.

> Lines 504 - 513: Here you repeat the concept that species interactions require
> more sampling effort. Likewise, the connection to the BON framework is
> reiterated multiple times.

We streamlined this section to remove redundancy.

> Lines 518: I would suggest removing the phrase "Through our representative
> example in Figure 3". In the Discussion, the focus should be on interpreting
> and synthesizing the findings rather than directing readers to specific
> figures. The statement would read more smoothly if it referred directly to the
> result or pattern observed, without explicitly citing the figure.

We removed the figure citation in this paragraph and updated the text to refer
to the result observed. We followed this recommendation throughout the
discussion, keeping figure citations for cases where results are taken as
specific examples or where we want to clearly highlight the result supporting a
statement.

> Lines 521–524: This section introduces a question that is immediately answered
> in the following paragraph, creating unnecessary repetition. This rhetorical
> structure may be useful in some forms of writing, but it is not particularly
> effective in a scientific discussion. I suggest stating the main point
> directly and integrating the explanation into a single, concise argument.

We agree that this point could be stated in a more effective way. We removed the
rhetorical questions and directed stated the need for further investigation to
ensure an actual implementation of the monitoring strategies.

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