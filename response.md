---
bibliography: references.bib
---

Dear Editor,

Here is our point-by-point response to the comments from the reviewers, which
were highly useful to improve our manuscript and make our approach easier to
understand. We integrated several of their suggestions in our revised
manuscript. Notably, we added a new paragraph to our Discussion where we discuss
the general applicability of our approach. Given these changes, our manuscript
is further beyond the word limit (10,297 words), which we felt was necessary to
give enough details regarding our Methods and discuss their limitations. We are
open to making additional cuts should it be required.

Thank you for giving us this opportunity to submit a revised version of our
manuscript.

Sincerely,

The Authors

--------------------------------------------------------------------------------

## Associate Editor

> We have now received two reviews for your manuscript. Apologies that this
> process took so long, it was a challenge to find the interdisciplinary reviews
> required to robustly assess the manuscript. Both reviewers were extremely
> positive about the manuscript and have identified a range of minor revisions
> to improve aspects of the work. Thank you very much for your patience and I
> look forward to seeing the revised manuscript.

We thank the editor for letting us submit a revised version of our manuscript.

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

We thank the reviewer for their positive comments and helpful suggestions.

> lines 420 - 424: Is this paragraph intended to explain Figure 3 BON Examples?
> I couldn't find the mentioned summary in the text; this section should be
> modified for clarity. Also the captions of figure 3 and 4 should mention that
> they are showing examples.

Yes, this paragraph refers to the showcased example in Figures 3 and 4,
representative of the most common results across all independent landscape
configurations. We clarified this by specifically mentioning Figures 3 and 4 in
this paragraph. The summary we referred to is Figure 5, which directly presents
the comparison results across the 200 independent configurations. We now mention
Figure 5 in the paragraph as well. We added a mention in the captions to clarify
that Figures 3 and 4 are showing examples, as suggested.

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
using the exact species range)—, pink for "Higher"—the least favourable
outcome—, and orange for "Lower"—the "most favourable" but surprising outcome,
which barely occurs and should stand out as a special case whenever it appears.
The same reasoning also applies on Fig 5—strategies or targets being equal to
the reference is "good" (i.e. we can use either interchangeably), while having a
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

--------------------------------------------------------------------------------

## Reviewer 2

> The manuscript entitled "Optimizing sampling and monitoring of species
> interactions within Biodiversity Observation Networks" is concise in its
> conclusions and detailed in the methods. Arguments are well written and
> relevant, although I included a few suggestions that may add to the debated
> ideas. Concerning the methods, almost all steps for model design and
> construction were listed and explained, but the use of different definitions
> of interactions may confuse the reader in some parts (listed below).

We thank the reviewer for their constructive comments on our work.

> Also, The authors should inform the reader at the beginning of the methods
> section that they only consider higher-degree trophic interactions. I guess a
> vegetation model would perform completely differently, and the same would
> apply if they included primary consumers. Of course the predator-prey
> relationship is one of the most known and intuitive (based on Eurocentric
> ecological foundation) but that is a great limitation of the model, and
> possibly not one of the most relevant interactions in many ecosystems.

We thank the reviewer for raising this important point, which gives us an
opportunity to expand on the general applicability of our approach. We did so in
a new *Results representativity and model applicability* section at the end of
our Discussion. To answer briefly to the elements mentioned in this comment: as
we rely on the niche model, we expect the network structures to most closely
resemble food webs of predator-prey interactions, which we clarified at the
beginning of the Methods and in our Discussion paragraph. However, our approach
is not limited to predator-prey interactions and could very well include primary
consumers and vegetation. The approach is applicable for other network types
(e.g. bipartite networks) provided that a metaweb of interactions and species
presence-absence rasters can be obtained and that interaction rates can be
defined based on species abundances or traits.

> Monitoring efforts always must prioritize cost-effective approaches, and the
> manuscript message points in that direction. However, it also gives a clear
> message about the importance of target choice, which depends completely on the
> actual natural history knowledge about the target. That changes the focus of
> most BONs, which are concerned about community scale because we lack this
> refinement about species natural history.

We addressed this comment in the first section of our Discussion. We recognize
that the emphasis we put on Target choice represents a change in focus, yet we
would argue that it is comparable to multiple BONs and community-oriented
monitoring initiatives. Notably, China-BON was designed to maximize site
complementarity in terms of species coverage [@Xu2017OptMon] and the monitoring
program led by the Alberta Biodiversity Monitoring Institute included a dynamic
off-grid ensemble of sites to explore specific research hypotheses
[@Burton2014FraAda]. Targeted approaches can also play a role in bottom-up BONs
aiming to assemble information from multiple sources, such as CAN-BON
[@Gonzalez2025BioObs]. Interactions are costly enough to sample that targeted
approaches making use of available natural history might be crucial to start
monitoring integrating them into developing monitoring programs, where they are
currently lacking [e.g. European BON, @Kissling2024ModEff].

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

We thank the reviewer for this invitation to discuss the limitations of our
approach. We did so in the new paragraph in the Discussion.

> Line 149 - NLMs and species interaction samples: Makes sense to indicate the
> grain size, since spatially-autocorrelated distributions are considered.

Our neutral landscapes have a fixed extent (100 x 100 pixels) but no intrinsic
physical grain sizes, as in common NLM implementations [@Etherington2015NlmPyt;
@Etherington2022BinSpa]. Similar to @Simpkins2018AssPer, we did not link them to
an explicit spatial scale to represent generic species distributions applicable
over multiple scales. We consider each pixel as a unit where local interactions
can be sampled, similar to recent representation of networks and metawebs in
spatial contexts. In a monitoring context, relevant scales could be either
national (e.g. trophiCH metaweb in Switzerland, @RejiChacko2025SpeLos) or
continental (e.g. TETRA-EU metaweb in @Braga2019SpaAna), and cover different
interaction types (e.g. national metaweb of plant-frugivore interactions in New
Zealand, @Garcia-Callejas2025SpeTra). We rearranged this paragraph to make the
simulation context clearer from the start.

> Line 154 - what type of realistic spatially-correlated distributions were
> applied? I'd like to understand if fragmented habitats are considered or if
> the model only deals with continuous gradients, disregarding potential
> enclaves or hot spots and other abrupt changes between landscape domains
> (which are a common feature).

We updated the paragraph to better describe the generated distributions. To
answer more directly: the neutral landscapes were generated using the
Diamond-Square algorithm, a fractal landscape generator producing continuous,
autocorrelated variation along the simulated surface (controlled by an
autocorrelation parameter). Fragmentation emerges when the landscapes are
thresholded to produce habitat classes, creating habitat patches and potential
enclaves (see the representative example on Figures 3-4). Such models better
represent fragmented and patchy habitats, similar to natural landscapes
[@With1997AppNeu; @Wang2008NeuLan]. They do not represent gradients, nor do they
represent abrupt changes (e.g. straight lines and rectangular) as in
human-dominated landscapes [although other neutral models exist to do do, see
@Etherington2015NlmPyt; @Etherington2022BinSpa].

> Line 172 - The feasible interactions are only based on trophic interactions,
> which depend on natural history information. Thus, how would that work for
> species high places? How species richness affects models? Were herbivory
> interactions considered or just animal-animal interactions? Otherwise, I would
> state clearly that only trophic interactions \> third degree are considered
> here.

We recognize that this part required some clarification. The feasible
interactions represent the trophic interactions of food webs whose structure can
be reproduced by the niche model. Reviewed food webs recognized as well
described by the niche model cover various types of interactions, including
herbivory [@Williams2000SimRul; @Williams2008SucIts; @Hale2024HigRes]. However,
the model notably underestimates the proportion of herbivores and decreases in
performance as richness increases [as do alternative topological models,
@Williams2008SucIts]. This is in part why we limited our simulations to
parameters within the range of reviewed foods (S = 75 species, C = 0.20). Given
that the niche model poorly matched an extremely rich, highly-resolved food webs
[too few basal species and herbivores, @Hale2024HigRes], our conclusions likely
should not be applied in such cases. We added a mention for this our new
Discussion paragraph regarding the limitations of our conclusions. Nonetheless,
we would still highlight that this does not invalidate our entire approach: our
frameworks remains conceptually compatible to evaluate monitoring expectations
if a realistic metaweb including herbivore interactions (e.g. an empirical
metaweb, or assembled using another topological model) was provided instead of
the ones generated by the niche model.

> Line 179 - detected, realized and possible interactions are all conditioned by
> species abundances. Rare species interaction should be relevant for risk
> extinction on alien invasive species, which may be more ecologically relevant
> than the direct consumption of abundant prey, or even if invasive species are
> not abundant but voracious (e.g. lionfish).

We clarified earlier in the Methods that our approach is applicable when
interaction rates can be defined based on species abundances or on species
traits (a new addition to SpeciesInteractionSamplers.jl which we did not explore
here but detailed in @Catchen2023MisLin). We believe that conditioning encounter
and detection rates on abundances is most relevant in a BON monitoring context
when the focus is to comprehensively document the interactions in a study area.
Rare interactions as described are indeed relevant, but will nonetheless be
influenced by species abundances, and might be better served by targeted
monitoring efforts oriented specifically towards species at risk of extinction
or invasive species.

> Line 202 - the determination of location is key considering that this model
> could be used for sampling at different scales, and also links with the
> question about line 149 above

As mentioned earlier, we clarified that our model is intended to represent
national and continental monitoring while keeping the flexibility to represent
multiple scales. Determining the location of interaction realization and
detection is indeed key, but as we describe in this paragraph, this is an
advantage of our simulations as an exploratory approach, given that all
locations are known from the process-based model.

> Line 245 - sampled interactions = detected interactions? Is it possible to
> clarify or use the same definitions from generated models? This can be
> confusing.

In this context, the proportion of "sampled interactions" corresponds to the
proportion of **realized interactions** of the focal species that can be sampled
for every generated BON design. In Simulation Studies II and III, we focus on
realized interactions as long-term targets which would be sampled over time
following repeated monitoring efforts at sites in the BON. We clarified the
wording in this section of the Methods (Step 3 of the General Model) and in the
sections for Simulations study II and III, though we prefer keeping "proportion
of sampled interactions" elsewhere.

> Line 254 - it is always hard to define thresholds, and 80% seems a good number
> for interactions, but how realistic should this number be based on real data?
> Are the authors aware of expected values for a given richness value (the
> applied 75 taxa) or a range? Are these considered detected interactions?

We added a reference to two studies where the 80% was used in a similar way.
@Chacoff2012EvaSam and @Costa2016SamCom both reported the sampling effort
required to to reach 80%, 90% and 100% of the estimated interactions in
plant-pollinator and seed dispersal networks. Meanwhile, evaluating the
proportion of sampled interactions in an empirical context usually requires
estimating an asymptotic richness values with an estimator such as Chao 2. We
prefer not to report on values in our Methods section given the widely variable
contexts, but we note here that 80% is within the range of studies in different
systems : an average 79% after 5 sampling days in seed dispersal networks
[@Costa2016SamCom], 82% of interactions in plant-hummingbird networks
[@Vizentin-Bugoni2016InfSam], 80 ± 17% in host-parasitoid networks
[@Henriksen2019EffNet], etc. We also note that our 80% threshold only sets the
reported $n_{0.80}$ value in our results but should generally not change the
overlap of the confidence intervals used to compare the monitoring strategies.

> Line 276 - Please include exploratory outputs in a supplementary material
> because only fixed parameters were applied.
>
> Line 281 - Move this explanation before the indication of parameters values,
> in line 270. I'd prefer to have the details about the simulations before the
> model explanation, together with the interactions definitions. This way, we
> may have the idea before the execution, although I understand that the model
> construction steps are key to understanding how it was tested. That's more of
> a reflection because I deleted some comments after reaching this sentence, but
> still left some to illustrate how this order affected the reading.

We followed the second suggestion and mentioned earlier that we chose to keep
internal parameters constant to focus only on variation in monitoring outcomes
due to BON designs. We removed the mention of the exploratory simulations, as
they were performed early on in the development phase of our simulations, on a
preliminary version of our analyses, and would not bring much support for the
current results if provided in supp. mat. Nonetheless, this point ties-in with
what we added in our new discussion paragraph: as we chose fixed parameters
within the range of well-characterized empirical food webs, we expect our
results to be representative of trophic networks well-aligned with the niche
model.