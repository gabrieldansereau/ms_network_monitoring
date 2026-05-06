// Simple numbering for non-book documents
#let equation-numbering = "(1)"
#let callout-numbering = "1"
#let subfloat-numbering(n-super, subfloat-idx) = {
  numbering("1a", n-super, subfloat-idx)
}

// Theorem configuration for theorion
// Simple numbering for non-book documents (no heading inheritance)
#let theorem-inherited-levels = 0

// Theorem numbering format (can be overridden by extensions for appendix support)
// This function returns the numbering pattern to use
#let theorem-numbering(loc) = "1.1"

// Default theorem render function
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  if full-title != "" and full-title != auto and full-title != none {
    strong[#full-title.]
    h(0.5em)
  }
  body
}
// Some definitions presupposed by pandoc's typst output.
#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms.item: it => block(breakable: false)[
  #text(weight: "bold")[#it.term]
  #block(inset: (left: 1.5em, top: -0.4em))[#it.description]
]

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let fields = old_block.fields()
  let _ = fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => {
          let subfloat-idx = quartosubfloatcounter.get().first() + 1
          subfloat-numbering(n-super, subfloat-idx)
        })
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => block({
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          })

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let children = old_title_block.body.body.children
  let old_title = if children.len() == 1 {
    children.at(0)  // no icon: title at index 0
  } else {
    children.at(1)  // with icon: title at index 1
  }

  // TODO use custom separator if available
  // Use the figure's counter display which handles chapter-based numbering
  // (when numbering is a function that includes the heading counter)
  let callout_num = it.counter.display(it.numbering)
  let new_title = if empty(old_title) {
    [#kind #callout_num]
  } else {
    [#kind #callout_num: #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block,
    block_with_new_content(
      old_title_block.body,
      if children.len() == 1 {
        new_title  // no icon: just the title
      } else {
        children.at(0) + new_title  // with icon: preserve icon block + new title
      }))

  align(left, block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1)))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt)[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}


// syntax highlighting functions from skylighting:
/* Function definitions for syntax highlighting generated by skylighting: */
#let EndLine() = raw("\n")
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
   let blocks = []
   let lnum = start - 1
   let bgcolor = rgb("#f1f3f5")
   for ln in sourcelines {
     if number {
       lnum = lnum + 1
       blocks = blocks + box(width: if start + sourcelines.len() > 999 { 30pt } else { 24pt }, text(fill: rgb("#aaaaaa"), [ #lnum ]))
     }
     blocks = blocks + ln + EndLine()
   }
   block(fill: bgcolor, width: 100%, inset: 8pt, radius: 2pt, blocks)
}
#let AlertTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let AnnotationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let AttributeTok(s) = text(fill: rgb("#657422"),raw(s))
#let BaseNTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let BuiltInTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let CharTok(s) = text(fill: rgb("#20794d"),raw(s))
#let CommentTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let CommentVarTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ConstantTok(s) = text(fill: rgb("#8f5902"),raw(s))
#let ControlFlowTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let DataTypeTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DecValTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let DocumentationTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))
#let ErrorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let ExtensionTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let FloatTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let FunctionTok(s) = text(fill: rgb("#4758ab"),raw(s))
#let ImportTok(s) = text(fill: rgb("#00769e"),raw(s))
#let InformationTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let KeywordTok(s) = text(weight: "bold",fill: rgb("#003b4f"),raw(s))
#let NormalTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let OperatorTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let OtherTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let PreprocessorTok(s) = text(fill: rgb("#ad0000"),raw(s))
#let RegionMarkerTok(s) = text(fill: rgb("#003b4f"),raw(s))
#let SpecialCharTok(s) = text(fill: rgb("#5e5e5e"),raw(s))
#let SpecialStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let StringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let VariableTok(s) = text(fill: rgb("#111111"),raw(s))
#let VerbatimStringTok(s) = text(fill: rgb("#20794d"),raw(s))
#let WarningTok(s) = text(style: "italic",fill: rgb("#5e5e5e"),raw(s))


#let CERG(
  // The paper's title.
  title: "Paper Title",

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),
  affiliations: (),

  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  // A list of index terms to display after the abstract.
  keywords: (),

  // The article's paper size. Also affects the margins.
  paper-size: "us-letter",

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // Additional arguments from YAML
  citecolor: none,

  // The paper's content.
  body
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(author => author.name))

  // Set figure captions
  show figure.caption: it => {
    set align(left)
    set par(leading: 0.55em, hanging-indent: 0pt)
    text(10pt, it)
  }

  // Let figures float
  set figure(placement: auto)

  // Configure the page.
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (80pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    }
  )

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Code
  show raw: set text(font: "Iosevka", rgb("#232323"))

  // References
  // Not working with citecolor option
  // show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  // show cite: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show cite: set text(fill: blue)

  // Bibliography
  // show bibliography: set text(7pt)
  set bibliography(title: "References")


  // Set the body font.
  // set text(font: "STIX Two Text", size: 11pt)

  // Paragraph options
  set par(leading: 0.8em, spacing: 1.6em, justify: false)
  show heading.where(level: 1): set text(14pt, rgb("#114f54"),weight: "medium")
  show heading.where(level: 2): set text(13pt, rgb("#2e5385"),weight: "regular", style: "italic")
  show heading.where(level: 1): it => block(width: 100%)[
    #v(1.2em)
    #block(it.body)
    #v(1em)
  ]
  show heading.where(level: 2): it => block(width: 100%)[
    #block(it.body)
    #v(1em)
  ]

  // Display the paper's title.
  text(18pt, rgb("#1d8265"), weight: "medium",  title)
  v(8.35mm, weak: true)

  show "\@": "@"


  if authors.len() > 0 {
    box(inset: (y: 10pt), {
      authors.map(author => {
        text(12pt, author.name)
        h(1pt)
        if "affiliations" in author {
          super(author.affiliations)
        }
      }).join(", ", last: " and ")
    })
  }
  v(2mm, weak: true)
  if affiliations.len() > 0 {
    box(inset: (y: 12pt), {
      affiliations.map(affiliation => {
        text(12pt, weight: "semibold", super(affiliation.number))
        h(2pt)
        text(12pt, affiliation.name)
      }).join(linebreak())
    })
  }
  v(2mm, weak: true)
  if authors.len() > 0 {
    box(inset: (y: 10pt), {
      authors.map(author => {
       if "corresponding" in author {
          text(10pt, "Correspondence to ")
          text(10pt, author.name)
          h(5pt)
          sym.dash.em
          h(5pt)
          raw(author.email)
        }
      }).join("")
    })
  }

  v(8.35mm, weak: true)

    // Display abstract and index terms.
  if abstract != none [
    #set par(first-line-indent: 0em)
    #set text(weight: 600)
    _Abstract_:
    #set text(weight: 400)
    #abstract

    #if keywords != () [
        #set text(weight: 600)
      _Keywords_: 
      #set text(weight: 400)
      #keywords.join(", ")
    ]
    #v(2pt)
  ]

  v(1cm)

  // Start two column mode and configure paragraph properties.
  // show: columns.with(2, gutter: 14pt)
  // set par(justify: true, first-line-indent: 0em, spacing: 1.5em)
  set page(numbering: "1 of 1")

  // Line numbers 
  set par.line(numbering: "1")

  // Display the paper's contents.
  body
}
#let brand-color = (:)
#let brand-color-background = (:)
#let brand-logo = (:)

#set page(
  paper: "us-letter",
  margin: (x: 1.25in, y: 1.25in),
  numbering: "1",
  columns: 1,
)

#show: CERG.with(
  title: "Optimizing sampling and monitoring of species interactions within Biodiversity Observation Networks",
  abstract: [Optimal monitoring strategies should be designed to efficiently monitor all essential facets of biodiversity. Yet, species interactions are often overlooked in monitoring designs compared to spatial coverage and species richness, partly due to the inherent difficulty of sampling and monitoring interactions compared to species distributions. Here, we used simulations to test the efficiency of monitoring species interactions within Biodiversity Observations Networks (BONs). We tested several methods for designing and optimizing BONs to monitor species interactions and examined efficiency when increasing the number of monitored sites. We showed that the required sampling effort is considerably higher for interactions, especially when considering that interaction realization and detection realistically depend on species abundance. Thus, expectations to monitor a relevant proportion of interactions within a BON should be lower than expectations to monitor its species. However, from a single-species perspective, optimizing monitoring designs based on a known species range proved an efficient strategy to retrieve its interactions, outperforming designs based on total species or interaction richness. Only optimizations based on detailed knowledge of where realized interactions occurred allowed better performance, highlighting the need for better knowledge of where interactions are likely to take place and integration of factors influencing interaction realization, such as species abundances, for further efficiency gains. Our results were consistent even when the total species range was over- or underestimated by 10%, highlighting a tolerance in the precision of the information required for optimization. Therefore, our results highlight how attainable levels of information can lead to efficiency improvements when designing BONs. With the right target and optimization strategy, available information, such as species ranges, can guide observation network designs to monitor species interactions as central biodiversity components.],
    authors: (
                                    (
                    name: "Gabriel Dansereau",
                    affiliations: [1,2],
                    email: "gabriel.dansereau\@umontreal.ca",
                                        corresponding: true,
                                        orcid: ""
                ),
                                                (
                    name: "Michael D. Catchen",
                    affiliations: [1,2],
                    email: "",
                                        orcid: ""
                ),
                                                (
                    name: "Ceres Barros",
                    affiliations: [3,4,5],
                    email: "",
                                        orcid: ""
                ),
                                                (
                    name: "Timothée Poisot",
                    affiliations: [1,2],
                    email: "",
                                        orcid: ""
                ),
                        ),
    affiliations: (
                                    (
                    name: "Université de Montréal, Département de sciences biologiques, Montréal QC, Canada",
                    number: "1",
                ),
                                                (
                    name: "Québec Centre for Biodiversity Science, , Montréal QC, Canada",
                    number: "2",
                ),
                                                (
                    name: "Canadian Forest Service, Natural Resources Canada, Victoria BC, Canada",
                    number: "3",
                ),
                                                (
                    name: "Department of Forest Resources Management, University of British Columbia, Vancouver BC, Canada",
                    number: "4",
                ),
                                                (
                    name: "Département des sciences du bois et de la forêt, Université Laval, Quebec QC, Canada",
                    number: "5",
                ),
                        ),
  keywords: ("biodiversity monitoring", "species interaction networks", "biodiversity observation networks", "sampling design"),
)

// Define functions for easier citations
#import "@preview/citesugar:0.1.0"
#let citeb(key, supplement: none, style: auto) = {
    show regex("[\(\)\[\]]"): none
    cite(key, supplement: supplement, style: style)
}
= Introduction
<introduction>
Biodiversity monitoring should encompass all facets of biodiversity. Article 7 of the Convention on Biological Diversity @UnitedNations1992ConBio calls for Parties to "\[i\]dentify components of biological diversity important for its conservation and sustainable use", and "\[m\]onitor, through sampling and other techniques, the components of biological diversity". Biodiversity Observation Networks (BONs) are promising initiatives to improve monitoring across scales and biodiversity facets. BONs are coordinated monitoring networks designed to harmonize observation systems, assist reporting on international assessments, and reinforce scientific basis in biodiversity monitoring @Navarro2017MonBio@Gonzalez2023GloBio. BONs can be thematic (Marine BON, Freshwater BON), national (China BON, French BON, Colombia BON) or regional (Asia-Pacific, Europe); some represent networks of monitoring sites for systematic monitoring (China BON) while others represent biodiversity data hubs (French BON) @Xu2017OptMon@Navarro2017MonBio. Additional BONs are currently in the development or planification stages, notably in Europe @Kissling2024ModEff and in Canada @Gonzalez2025BioObs@Simard2024ResSui, and could eventually be interlinked into the Global Biodiversity Observation System (GBiOS), a globally connected network providing capacity to monitor biodiversity change @Gonzalez2023GloBio and guiding actions needed for targets and goals of the Kunming-Montreal Global Biodiversity framework @CBD2022DecAdoa.

Recent work highlighted the need for improved sampling designs in BONs and proper adjustment to monitoring goals. First, current sampling designs over large scales are often too sparse, at too coarse a scale, too infrequent, and without temporal replication @Santana2025LarBio. For example, recommendations for more effective spatial sampling designs in Europe included i) stratified random sampling (with stratification across environmental, anthropogenic and political gradients or classes, ii) incorporation of existing monitoring sites, iii) filling of spatial gaps @Kissling2024ModEff. Second, ecological monitoring design relies on site selection algorithms more often discussed regarding their capacity to achieve spatial balance and representative samples, and less frequently for achieving an ecological monitoring goal @Norman2025SitSel. Species richness is the most commonly used biodiversity measure in monitoring contexts @Hillebrand2018BioCha, including in discussions over sampling designs. On one hand, maximizing richness can efficiently capture functional and phylogenetic diversity in conservation networks @Willig2023ProBio. On the other hand, the use of species richness to measure biodiversity change and guide biological conservation has also been criticized, mainly since trends in species richness do not properly capture local changes, neglecting species identities and functional roles, and do not providing information on persistence of biodiversity and ecosystem services @Hillebrand2018BioCha@FletcherJr.2025SpeRic@Aguiar2024UntBio. Thus, there is a need to better adjust BON sampling designs to biodiversity facets beyond species richness.

Species interactions are a central component of biodiversity @Valiente-Banuet2015SpeLos@Harvey2017BriEco@McCann2007ProBio, critical for ecosystem functioning and health, yet are undervalued in biodiversity monitoring and conservation @Jordano2016ChaEco@Dansereau2025OveDis. Interactions mediate community and ecosystem responses to change @Garzke2019TroInt and can improve our ability to predict responses to climate change @Abrego2021AccSpe. They have their own spatial and macro-ecological dynamics @Windsor2023UsiEco@Mestre2022DisFoo@Baiser2019EcoRul@Dansereau2024SpaExp, and may be lost (or change) faster than species @Valiente-Banuet2015SpeLos@Dore2021RelEff. Despite a lack of data at global scales and uneven data availability across different interaction types and environments @Hortal2015SevSho@Poisot2021GloKno, we now have sufficient conceptual tools to support the added value of species interactions in designing efficient management actions @Dansereau2025OveDis@Moracho2025RebEco. Therefore, integrating species interactions into existing monitoring programs, such as BONs, is something we need to undertake in the near future.

Prior investigations of interaction sampling did not address how efficiently we should expect to monitor interactions within the BON framework, nor did studies on the effectiveness of BONs pay particular attention to the sampling of species interactions. Instead, much focus has been given on how to assess sampling completeness and diversity metrics (e.g.~#citeb(<Chacoff2012EvaSam>) #citeb(<Chiu2023QuaEst>)) and how sampling effort affects network properties (e.g.~#citeb(<McLeod2021SamAsy>)). Recent empirical @Caron2024TraMod and theoretical @Poisot2023GuiPre results have established that knowing the network structure (i.e.~network properties) does not always allow to know the list of interactions (and vice versa), therefore justifying the need to sample interactions as their own biological entities. A central challenge to do so is that the sampling effort required to document interactions is much higher than for species (e.g.~500% vs 64% in #citeb(<Chacoff2012EvaSam>)). Moreover, evaluating sampling completeness for interactions is more complex than for species, as it requires assessing the proportion of forbidden links (i.e.~links that cannot occur) due to life history or morphological restrictions, which in turn requires knowledge of species natural history and traits @Jordano2016SamNet. While some quantitative network properties such as connectance are less affected by sampling completeness, network composition and binary measurements derived from it will vary widely if interactions are missed (e.g.~number of links, #citeb(<Vizentin-Bugoni2016InfSam>) #citeb(<Poisot2012DisSpe>)).

One way to define expectations for interaction monitoring within BONs is to consider variation in local sampling from an explicitly spatial perspective---that is, quantifying sampling effort from specific sites where interactions are sampled---and use such expectations to improve monitoring efficiency. Previous evaluation of sampling effort relating to interactions were not explicitly spatial in a way that directly ties to biodiversity monitoring: they investigated expected variations using dataset resampling (to measure the effect on network composition and properties, #citeb(<Poisot2012DisSpe>) #citeb(<Henriksen2019EffNet>)), focused on the effect of scale (showing that many network structure metrics are robust across spatial scales, #citeb(<Wood2015EffSpa>)), or assessed the ability to capture regional properties (showing that sampling larger to smaller lakes better captures regional metaweb properties, #citeb(<McLeod2021SamAsy>)). We now have frameworks and models to describe and investigate the variation and detection of interaction networks in space and time @Poisot2015SpeWhy@Cirtwill2019QuaFra@Catchen2023MisLin, and therefore the next step is to consider how to optimize monitoring for species interactions. Simulations offer opportunities to explore such optimizations: for example, to anticipate sampling effects on estimated network properties compared to a known reference @deAguiar2019RevBia, determine optimal sampling frequency for monitoring @Daugaard2024DepFor, and examine how monitoring efficiency and trends detection is influenced by the number of monitoring sites under a range of scenarios and monitoring schemes @Ficetola2018OptMon.

In this manuscript, we address three key questions. First, what expectations should we have for monitoring species interactions across space within Biodiversity Observation Networks? Second, what effect does sampling design strategies have on the efficiency with which we can document interactions? Finally, what available information (e.g.~from existing monitoring programs) could be used to optimize the design of future BONs for interactions and how precise should such information be to expect efficiency improvements?

We use spatially explicit community simulations to test the efficiency of monitoring species interactions within BONs, and explore various algorithmic and design options for network sampling optimization. We aim to define realistic expectations for monitoring species interactions, in comparison to more commonly evaluated elements such as species richness and species ranges. We examine how to assess and compare monitoring efficiency using simulations. We conclude with recommendations on how this should influence the design of BONs to improve the monitoring of species interactions as an important biodiversity component.

= Methods
<methods>
We used simulations to generate species interaction networks, species ranges, and biodiversity observations networks (BONs) with the goal of evaluating monitoring potential for interaction networks within BONs. We first detail the steps for the general model we used (#ref(<fig-concept>, supplement: [Figure])). We then go over the simulations we performed to investigate the monitoring of species interactions within BONs, aiming to 1) establish baseline expectations for the monitoring of interactions; 2) assess opportunities to improve the monitoring efficiency using different site selection algorithms and optimization targets; and 3) evaluate how precisely we need to know a species ranges to use it as a target for monitoring design.

#figure([
#box(image("figures/conceptual_figure.png"))
], caption: figure.caption(
position: bottom, 
[
Conceptual diagram of the workflow and simulations. We used the spatio-temporal model by #cite(<Catchen2023MisLin>, form: "prose") to generate landscapes with spatial variation in species and interaction composition. We then designed biodiversity observation networks (BONs) across the simulated landscapes using a combination of site selection algorithms (samplers) and optimization targets. We measured the efficiency of the BON designs for sampling species interactions using a comparable measure (the number of sites required to document 80% of the interactions) across all simulations.
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-concept>


== General model
<general-model>
We followed the approach and process-based, spatio-temporal model introduced by #cite(<Catchen2023MisLin>, form: "prose") (building on #citeb(<Cirtwill2019QuaFra>)) to simulate interaction realization and detection while accounting for spatial variation in species occurrences, implemented in #NormalTok("SpeciesInteractionSamplers.jl");. This model broadly captures the different processes involved into turning a #emph[potential] interaction (i.e.~a biologically feasible interaction) into a #emph[realized] one (i.e.~an interaction that took place at a specified location), as outlined in #cite(<Morales-Castilla2015InfBio>, form: "prose"). To this generative model, we added the design of Biodiversity Observation Networks and the evaluation of sampling efficiency between and across simulations for species interactions (#ref(<fig-concept>, supplement: [Figure])).

=== Step 1: Generating interaction networks with spatial variation
<step-1-generating-interaction-networks-with-spatial-variation>
First, we simulated networks with variation in species and interaction composition across a simulated landscape (#ref(<fig-concept>, supplement: [Figure]), Step 1), with the intent to replicate the ecological context in which biodiversity monitoring could take place. To do so, we generated species ranges representing the distribution of species across the landscape using neutral landscape models (NLMs, #citeb(<Gardner1987NeuMod>) #citeb(<Etherington2015NlmPyt>). NLMs are used to generate landscapes replicating realistic spatially-autocorrelated distributions and representing useful baselines to explore ecological processes in a spatial context @Hesselbarth2024ComMet. NLMs have been used to generate realistic landscapes in contexts relating to biodiversity distribution and preservation, for instance to compare avian diversity between conservation approaches in coffee-growing landscapes @Valente2022LanLan or to assess the potential of a suggested umbrella species in an ecotone @Duchardt2023UsiNeu. NLMs have also been used with species interactions, for example to evaluate the effect of landscape structure in cross-species disease transmission between interacting species @Forero-Munoz2025SpaLan. Here, we generated species ranges following the implementation in SpeciesInteractionSamplers.jl @Catchen2023MisLin, which 1) uses the Diamond-Square algorithm (#citeb(<Fournier1982ComRen>)\; also used similarly and described by #citeb(<Forero-Munoz2025SpaLan>)) to generate a probabilistic spatially-autocorrelated range for a species (default autocorrelation parameter h=0.85); 2) draws a threshold based on a Beta distribution (default $alpha$ = 10, $beta$ = 10); 3) converts the probabilistic range into a binary one, considering all sites with values higher than the threshold as presence and those with lower values as absence, and 4) repeating the process independently for all species (here 75 species). In the end, this process generates communities of known composition and species richness at every site in the simulated landscape.

Next, using the spatio-temporal model presented by #cite(<Catchen2023MisLin>, form: "prose"), we defined the #strong[feasible interactions] between the species by generating a metaweb using the niche model @Williams2000SimRul. The niche model defines interactions by assigning species a niche position and feeding range, similarly to body-size relationships between predator and prey, and generates networks with structural properties similar to empirical food webs @Williams2000SimRul@Gravel2013InfFoo@Delmas2019AnaEco. It is widely used as a generative model, including in the context of investigating interaction sampling @Poisot2012DisSpe@Wood2015EffSpa.

Combining the species ranges and the metaweb, we verified where species with feasible interactions co-occur, to build a list of #strong[possible interactions] @Catchen2023MisLin at every location in our landscape. Next, we defined #strong[realized interactions] by conditioning possible interactions to species abundances. Rare and low-abundance species are less likely to interact in a location because they are less likely to encounter one another when compared to abundant species, leading to neutrally forbidden links @Catchen2023MisLin@Canard2012EmeStr. The neutral model introduced by #cite(<Catchen2023MisLin>, form: "prose") first generates a distribution of species relative abundances from a log-normal distribution (followed by many empirical communities, #citeb(<Preston1948ComRar>)\; the variance is controlled by a parameter $sigma$). It then defines an interaction rate between species pairs based on the product of their relative abundances, scaled by a fixed realization energy parameter ($epsilon.alt$) determining the total expected number of interactions. Finally, they draw realized interactions from a Poisson distribution parametrized on the interaction rate (see #citeb(<Catchen2023MisLin>) for full details).

Finally, we defined the set of #strong[detected interactions] by also conditioning the detection of realized interactions on species abundances. Even if an interaction is realized in a location, sampling must occur at the moment of interaction for its detection; this is again less likely for low probability events, like interactions between rare occurring species. #cite(<Catchen2023MisLin>, form: "prose") first establish a per-species detection probability conditioned on relative abundance and a fixed scaling parameter ($alpha$), compute the interaction-level detection rate as the product of the per-species probability, then draws the detected interactions from a Binomial distribution parametrized on the number of realized interactions and the interaction detection rates.

The result of the general model is a #strong[landscape configuration] with spatial variation in species and interaction composition and detection. Species composition, realized interactions, and detected interactions are based on the process model and known at all locations, allowing to compare the efficacy and efficiency of sampling strategies at retrieving interactions within the landscape configuration.

=== Step 2: Designing Biodiversity Observation Networks
<step-2-designing-biodiversity-observation-networks>
We designed #strong[Biodiversity Observation Networks (BONs)] across the simulated landscape and measured their efficiency at monitoring the generated species interaction networks. The objective of this step is to select the sites that will form the monitoring network---a BON being a monitoring network for biodiversity, and for which we here focus specifically on species interactions---similar to BON examples with systematic grid designs at national scales (e.g.~China BON, #citeb(<Xu2017OptMon>) #citeb(<Yi2022ChiBio>)) and subnational ones (Québec and Alberta in Canada, #citeb(<Simard2024ResSui>) #citeb(<Burton2014FraAda>)). #cite(<Norman2025SitSel>, form: "prose") presented an overview of the design and site selection process accounting for ecological monitoring goals. The design process uses a site selection algorithm to designate candidate sites for the monitoring network. Key features of the site selection algorithms include the ability to balance sites across space for equal representation (see #citeb(<Benedetti2017SpaBal>) #citeb(<Kermorvant2019SpaBal>) for reviews), to stratify across regions or populations, to include auxiliary site information (environmental or biological) to weight inclusion probability, and to produce master samples including current monitoring site or from which to select a subset of sites for a specific monitoring project @vanDam-Bates2018UsiBal@Robertson2024WelSam.

Based on the landscape configurations generated in Step 1, we can use #strong[site selection algorithms] (generally referred to as #emph[samplers]) to distribute monitoring sites across the landscape, then measure each design's efficiency at monitoring species interactions. Some algorithms can optimize the location of sites given different information such as species ranges, species richness or presence of realized interactions. For example, we can design BONs using the Balanced Acceptance Sampling algorithm @Robertson2013BasBal when the aim is to balance sites across our simulated landscapes, given its computational efficiency and its ability to weight site inclusion probabilities using a layer of weights. On the other hand, active learning methods like the Uncertainty Sampling algorithm @Lewis1994SeqAlg can be used to optimize sampling given information on element uncertainty @Settles2009ActLea. Instead of focusing on uncertainty, we can apply the algorithm to target the sites that provide the highest information gain for the BON, given a layer of 'information' values to maximize. Examples of active learning relating to biodiversity monitoring and sampling site selection include improving species range estimation from a smaller number of actively selected sites @Lange2023ActLea and minimizing field data collection costs based on distances between samples @Malek2019OptFie.

=== Step 3: Defining a comparable measure for sampling efficiency
<step-3-defining-a-comparable-measure-for-sampling-efficiency>
As interaction composition is known at all locations in our simulated landscapes, we can determine the #strong[proportion of interactions] (noted $p$) of the focal species that can be sampled for every generated BON design (e.g.~a BON of 50 sites using a specific site selection algorithm). This proportion can be seen as a 'snapshot' view of a given BON design's sampling efficiency for that simulated landscape. The proportion of sampled interactions should increase with the number of sites in the BON ($n$), although the exact value of $p$ can fluctuate given randomness in the site selection algorithm. To remove this randomness and ensure a consistent comparison across independent simulations, we state that the #strong[proportion of sampled interactions for a given number of sites in the BON], noted $p \( n \)$, follows an accumulation curve described by the equation:

#math.equation(block: true, numbering: equation-numbering, [ $ p \( n \) = frac(n, a + n) $ ])<eq-eff>

where $a$ is the single parameter describing the shape of the sampling curve. The lower the value for $a$, the faster we reach a high proportion of monitored interactions. We can identify the value of $a$ yielding the curve with the best fit with a simulation's results, as described in #link(<sec-simulation-study-II>)[Simulation Study II].

Next, we derived an interpretable efficiency measure based on #ref(<eq-eff>, supplement: [Equation]). Although the parameter $a$ can be directly compared across samplers, optimization targets and independent simulations, its value is not intuitive in a monitoring context. Instead, we used the #strong[number of sites required to sample 80% of the interactions], which can directly be tied to sampling effort and design. Solving #ref(<eq-eff>, supplement: [Equation]) for $n$, we obtain:

#math.equation(block: true, numbering: equation-numbering, [ $ n_p \( a \) = frac(p dot.op a, 1 - p) $ ])<eq-n_at_p>

where $n_p \( a \)$ represents the number of sites required to sample a proportion of interactions $p$, following an efficiency curve described by the parameter $a$. Here, we fixed $p = 0.80$ (80% of the interactions), an arbitrary threshold representing a highly effective monitoring outcome, for which we obtain $n_0.80 = 4 dot.op a$ using #ref(<eq-n_at_p>, supplement: [Equation]). $n_0.80$ measures the speed at which interactions are documented, and therefore the sampling efficiency of a BON design within a given landscape. We then used $n_0.80$ values to compare site selection algorithms and optimization targets to identify which ones are more efficient---i.e.~allow reaching a high proportion of monitored interactions more quickly.

== Simulation studies
<simulation-studies>
We performed three simulation studies to investigate the efficiency of monitoring species interactions within BONs. Across our simulations, we used landscapes of 100 x 100 pixels, 75 species, and a connectance of 0.2 to generate metawebs using the niche model. The connectance and number of species are within the range of values of well-characterized empirical food webs @Williams2000SimRul@Dunne2002NetStr@Dunne2004NetStr@Smith-Ramesh2017GloSyn commonly used for reference @Williams2008SucIts@Baiser2010ConDet@Wood2015EffSpa. These parameters are also within the range of previous simulation studies on spatial ecological network dynamics, #emph[e.g.] #cite(<Thompson2017DisGov>, form: "prose"). We used the following parameters for the spatio-temporal model implemented in SpeciesInteractionSamplers.jl @Catchen2023MisLin: landscape autocorrelation of $h$ = 0.85, Beta distribution with $alpha$ = 10 and $beta$ = 10 to threshold landscapes, variance of log-normal distribution for relative abundances $sigma$ = 1.2, realization energy $epsilon.alt$ = 50,000, and detection scaling $alpha$ = 50. Exploratory simulations showed that model parameters such as metaweb connectance and landscape autocorrelation did not have an important effect on the proportion of sampled interactions and the accumulation observed when increasing the number of sites in the BON. The activation energy $epsilon.alt$ and detection scaling $alpha$ parameters determine the total number of expected and detected interactions @Catchen2023MisLin, and therefore influenced the absolute numbers observed. Here, we chose to use a single fixed value to focus on differences between sampling strategies---influenced in the same way by the parameter values---and refer readers to #cite(<Catchen2023MisLin>, form: "prose") for the detailed discussion over the parameters' effect. We implemented our simulations in #emph[Julia] v1.11.9 @Bezanson2017JulFre. All the code used to implement the simulations and perform the analyses is archived on Zenodo @Dansereau2026GabNet. Full computations were run on compute clusters provided by Calcul Québec and the Digital Research Alliance of Canada.

=== Simulation study I: Establishing baseline expectations for the monitoring of interactions
<simulation-study-i-establishing-baseline-expectations-for-the-monitoring-of-interactions>
Our first simulation study aimed to establish baselines for the monitoring of interactions across space, defining expectations for how we could document a metaweb of interactions using a BON. We aimed to represent the case of existing BONs (e.g.~Québec, China) designed to cover a wide range of taxa and environmental conditions without specific considerations for species interactions. We tested the case of spatially balanced BONs with evenly spread sites across the landscape configurations, which is generally considered an effective way to cover environmental space @Kermorvant2019SpaBal. We used the Balanced Acceptance Sampling algorithm @Robertson2013BasBal@Robertson2017ModBal to generate candidate BONs with a number of sites between 1 and 500 at intervals of 10 sites, with 50 replicates for each number of sites, yielding 2,550 BON designs in total. For every design, we used the general model (Step 1) to generate an independent landscape configuration: a specific metaweb, a set of species ranges, an abundance distribution for the species, and realized interactions. In every one, we evaluated the sampling efficiency of the BON design in terms of sampling interactions from the metaweb and in terms of documenting species richness. For species richness, we assumed that all species present at sites in the BON were sampled, then compared the number of species sampled in the BON against the total species richness across the landscape (always 75 species). For interactions, we evaluated each interaction type separately (possible, realized and detected), counting the number of distinct interactions sampled in the BON, then evaluated each number in proportion to the metaweb (specific to the landscape configuration, but generated with the same connectance of 0.2 using the niche model). As a whole, these simulations compared four sampling targets (species richness, possible interactions, realized interactions, and detected interactions), establishing baselines for the monitoring of each.

=== Simulation study II: Evaluating strategies to optimize the monitoring of interactions for a focal species
<sec-simulation-study-II>
Interaction network sampling and monitoring may be targeted at a focal species because of its endangered status (e.g.~#citeb(<Rioux2022TroNic>), because it is at the centre of conservation or restoration programmes (e.g. #link("https://bearconnect.org/")[BearConnect]), or even due to human-nature conflicts (e.g.~#citeb(<Baranowska2025LowCon>)). Hence, we also investigated sampling efficiency from a focal species perspective, by simulating a virtual observer that would aim to sample all the interactions of a focal species (here known from the metaweb), but might have different information on how to optimize the sampling design. Thus, the idea of our focal sampling exploration is to represent a simplified case with a clear objective (retrieving a species' interactions) and where we do have prior knowledge about the system, either through empirical data or model predictions, which can be used to optimize sampling.

Optimizing focal sampling relies on two elements: the site selection algorithm (sampler) used and the information provided for optimization. A species range represents an attainable level of information an interested observer could have, for instance based on expert knowledge or species distribution models. Therefore, we investigated the case where an observer knows the species range across the landscape (presence or absence) and tries to optimize the BON design to retrieve the interactions. We tested four strategies for comparison: a #emph[Balanced Sampling] spreading sites across the entire study area (using Balanced Acceptance Sampling, hereafter BAS), a balanced sampling only within the range of the focal species (hereafter called #emph[Balanced Within Range]), a #emph[Weighted Sampling] favouring the species range in site selection among all sites in the study area (adjusting the inclusion probability in BAS), and a #emph[Targeted Sampling] selecting sites with higher 'information' values in the layer provided (using Uncertainty Sampling). Next, we tested four information targets for optimization with the Targeted Sampling strategy (all with the Uncertainty Sampling algorithm): the exact #emph[focal species range] (our attainable information knowledge for the observer), a #emph[probabilistic range] for the focal species (representing a less-informed case, similar to the output of a species distribution model), #emph[species richness] across the landscape (to represent a holistic level of information about the system, which an observer might have based on detailed knowledge about biodiversity in a region) and finally the location of #emph[realized interactions] for the focal species across the landscape (to represent a best-case scenario, where an observer would know exactly the right information to target).

We performed 200 independent simulations with independent landscape configurations (as described in Simulation study I). In each simulation, we selected the species with the highest degree (number of interactions) in the metaweb as the focal species for the simulation (as it was previously shown as an efficient strategy for sampling and conservation, #citeb(<Pires2017FriPar>) #citeb(<deAguiar2019RevBia>)). We then generated BONs of 1 to 500 sites (at interval increments of 10 sites) using the three balanced strategies (Balanced Sampling, Balanced Within Range, Weighted Sampling) and four optimization targets for the Targeted Sampling strategy (focal species range, probabilistic range, species richness, realized interactions), with 50 replicates for every number of sites. For each BON generated, we extracted the number of unique realized interactions sampled across all sites for the focal species. We then performed a grid search across possible values of $a$ (from #ref(<eq-eff>, supplement: [Equation])) to identify the value yielding the curve with the best fit to the simulation's results. To do so, we extracted the median result (proportion of sampled interactions) across replicates for every number of sites in the BONs. We then evaluated 10,000 evenly spaced values for $a$ between $e^(- 5)$ and $e^15$ and selected the value yielding the curve minimizing the sum of squared errors to the simulation results. We searched for values of $a$ on an exponential scale as it allowed for more gradual control over the curve shape and adjusted the limits to ensure they went beyond the fitted values on both the lower and higher side. After selecting the best-fit value for $a$, we evaluated the sampling efficiency for the simulation using the $n_0.80$ measurement described in Step 3 (number of sites required to document 80% of the interactions).

Finally, we defined a confidence interval for our $n_0.80$ efficiency measurement. As the best-fit for $a$ is based on the median result across replicates, we used the confidence interval of the median to define a lower and upper bound for values of $a$. We calculated the order statistics delimiting an 90% equal-tailed interval using the normal approximation to the binomial distribution @Gibbons2010NonSta ---e.g., at n=50, the 90% confidence interval for the median goes from the 19th and to the 31st value---and extracted the corresponding results from our simulations. We performed separate grid searches for the parameter $a$ using the lower and upper confidence intervals bounds of the median, thus delimiting the lower and upper bounds for $a$, and subsequently bounds for $n_0.80$. This approach returns a confidence interval for the sampling efficiency, which we used to compare site selection algorithms and optimization targets within a specific landscape configuration, given that the monitoring context is unique in each one (different metawebs and species ranges). Doing so, we identified which site selection algorithms or optimization target were equal and which were more efficient (thus quickly reaching a high proportion of monitored interactions), while also quantifying the magnitude the difference between strategies in a comparable way between independent simulations.

=== Simulation study III: Assessing the precision required when estimating a species range
<simulation-study-iii-assessing-the-precision-required-when-estimating-a-species-range>
Building on the Balanced Within Range strategy from Simulation study II, we assessed how precisely an observer should know the focal species range to achieve an efficient monitoring. To do so, we compared the Balanced Within Range strategy, where the balanced sampling design is only generated across the exact focal species' range, with alternative scenarios where we over- and underestimated the species range for the BON design. We tested estimation offsets from 0 to 50% of the true range size, at 2% increment intervals, generating balanced designs within the over- or underestimated range. For a given landscape configuration, we extracted the true range size, calculated the number of sites to add or remove to reach the offset percentage, then used the non-thresholded probabilistic range (Step 1) to add the absence sites closest to the threshold (for overestimation) or remove the presence sites closest to the threshold (for underestimation).

We followed the same approach as in Simulation study II to design BONs and measure efficiency using the same 200 simulations with independent landscape configurations. We generated BONs of 1 to 500 sites for all the estimation offset ranges (again with 50 replicates at all number of sites) and measured the efficiency at documenting interactions. We then compared the $n_0.80$ values of each estimation offset range to the $n_0.80$ for the true species range, which we expected would be the most efficient, and used the confidence intervals to determine which estimation offsets differed from the true range.

= Results
<results>
=== Simulation study I: Lower sampling expectations for species interactions than species richness
<simulation-study-i-lower-sampling-expectations-for-species-interactions-than-species-richness>
Our results for the baseline spatially-balanced sampling designs highlight a marked difference between the proportions of sampled species and interactions (#ref(<fig-nbons>, supplement: [Figure])). Sampled species saturated very quickly, with all species sampled with less than 25 sites in a BON across the landscape. Possible interactions, which only depend on co-occurrence of species with a feasible interaction in the metaweb, also saturated quickly reaching over 90% of interactions in the metaweb with 25 sites and increased asymptotically afterwards. In contrast, realized and detected interactions, which account for the impact of species abundances on interaction realization and detectability, reached much lower proportions, both remaining under 25% of the all metaweb interactions at 100 sampling sites and under 50% at 500 sites. While the proportion of sampled realized and detected interactions would keep increasing with a higher number of sites ($n_0.80$ around 2100 and 7300, respectively), the speed at which they accumulate is notably lower than for species richness or possible interactions, highlighting the need for a much higher sampling effort for interactions within spatially-balanced BONs.

#figure([
#box(image("figures/nbon_bands.png"))
], caption: figure.caption(
position: bottom, 
[
Proportion of sampled species and interactions for a given number of sampling sites in a spatially-balanced Biodiversity Observation Network (BON) across the simulated landscape (Simulation Study I). Proportions were calculated with respect to the total species richness and the total number of interactions in the metaweb. Lines indicate the median proportion for a given number of sites, while the shaded bands delimit the 5th and 95th percentiles across replicates (50 independent replicates per number of sites; 2,550 in total).
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-nbons>


=== Simulation study II: Higher efficiency for Targeted Sampling and Balanced Within Range compared to spatially balanced strategies
<simulation-study-ii-higher-efficiency-for-targeted-sampling-and-balanced-within-range-compared-to-spatially-balanced-strategies>
To better illustrate the results of Simulation Study II, we first showcase the results for a representative landscape configuration (metaweb, species ranges, realized interactions). The conclusions for this landscape configuration are consistent with the most common results across all simulations (200 independent simulations with different landscape configurations), which we summarize right after the showcased one.

Our focal sampling experiment showed the Balanced Within Range and Targeted Sampling strategy to be most efficient at optimizing BON-design based on a known species range and while aiming to maximize the sampling of interactions of a single focal species (#ref(<fig-samplers>, supplement: [Figure])). Balanced sampling, representing a spatially balanced design across space unrelated to the focal species (similar to the baseline in Simulation Study I), performed the worst among the algorithms tested. Weighted Sampling maintained a better spatial balance across the landscape but performed notably worse than Targeted Sampling and Balanced Within Range at maximizing the efficiency for the focal species. Targeted Sampling and Balanced Within Range performed similarly.

Optimizing on the known species range, our proxy for an attainable level of information an interested user might have, was more efficient at sampling the focal species' interactions than optimizing based on the probabilistic species range or on species richness, effectively sampling more than half of the species' interactions (#ref(<fig-layers>, supplement: [Figure])). In contrast, optimization based on the location of realized interactions (our best-case scenario requiring a higher level information) expectedly performed better, retrieving most of the species' interactions.

#figure([
#box(image("figures/focal_samplers.png"))
], caption: figure.caption(
position: bottom, 
[
Efficiency of site selection strategies at sampling realized interactions for a given focal species within Biodiversity Observation Networks (BONs). This figure compares four sampling strategies: three balanced strategies (across the entire area, across the focal species range only, and using weights to favour the species range) and a targeted strategy using the species ranges as a fixed optimization target (the species range). Solid lines indicate the median proportion for a given number of sites (50 replicates per number of sites), while the shaded bands delimit the 5th and 95th percentile across replicates. The panels on the right illustrate examples of BONs with 50 sites (coloured points) generated by each strategy over the same landscape (species presences in yellow, absence in purple, masked area in white). This showcased example is representative of the most common results across independent simulations.
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-samplers>


#figure([
#box(image("figures/focal_optimized.png"))
], caption: figure.caption(
position: bottom, 
[
Efficiency of optimization targets at sampling realized interactions for a given focal species within Biodiversity Observation Networks (BONs). This figure compares four optimization targets with a fixed targeted sampler (Uncertainty Sampling). Solid lines indicate the median proportion for a given number of sites, while the shaded bands delimit the 5th and 95th percentile across replicates. The panels on the right illustrate examples of BONs with 50 sites (coloured points) generated by each strategy over the target landscape (areas in yellow indicate a higher value for targeting, e.g.~presence or richness, while areas in purple indicate a lower value).
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-layers>


Comparing optimization options by simulation clearly highlighted a consistently more efficient approach across landscape and metaweb contexts (#ref(<fig-eff-comp>, supplement: [Figure])\; see also Supp. Mat. for all pair-by-pair comparisons), consistent with the showcased single-simulation example (#ref(<fig-samplers>, supplement: [Figure]), #ref(<fig-layers>, supplement: [Figure])). Targeted Sampling was more efficient than Weighted Sampling in 63% of simulations (lower value for $n_0.80$, indicating a faster documentation of interactions), and both were more efficient than Balanced Acceptance in all simulations (#ref(<fig-eff-comp>, supplement: [Figure])A). Targeted Sampling and Balanced Within Range were equally efficient in all cases. Among optimization targets used with Targeted Sampling (#ref(<fig-eff-comp>, supplement: [Figure])B), optimizing on the focal species range was more efficient than on the probabilistic range or on species richness (78% and 90%, respectively), but always less efficient than optimizing on realized interactions.

#figure([
#box(image("figures/efficiency_comparison.png"))
], caption: figure.caption(
position: bottom, 
[
Within-simulation comparison of efficiency between samplers and optimization targets for 200 independent simulations. The comparison value is based on the number of sites required to document 80% of the focal species' interactions ($n_0.80$), described in #ref(<eq-n_at_p>, supplement: [Equation]). Negative values (in orange) indicate that the compared option led to a more efficient sampling than its reference (faster documentation of interactions), while positive values (in green) indicate it required a higher sampling effort. Equal values (in pink) have overlapping confidence intervals. The reference is the same on the two subpanels (Targeted Sampling using the focal species range) and was chosen to simplify the number of comparisons displayed. All one-by-one comparisons are available in Supp. Mat.
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-eff-comp>


=== Simulation Study III: Tolerance to 10% over- and underestimation of the focal species range
<simulation-study-iii-tolerance-to-10-over--and-underestimation-of-the-focal-species-range>
Our results highlight a tolerance in the precision of the species range estimation required for the Balanced Within Range strategy. Overestimating the range size from 0 to 50% led to a linear increase in the value of $n_0.80$ compared to the $n_0.80$ value obtained using the Balanced Within Range strategy on the exact species range (#ref(<fig-estimations>, supplement: [Figure])A, right side). The $n_0.80$ was equal to the true range until a 10% overestimation offset (based on overlapping confidence intervals), at which point it started to be higher across all simulations, indicating a lesser efficiency (#ref(<fig-estimations>, supplement: [Figure])B). In contrast, underestimating the species range showed a lesser increase of $n_0.80$ from 0 to -50% based on the median result across simulations, with a wider range of possible outcomes (#ref(<fig-estimations>, supplement: [Figure])A, left side). Importantly, while the $n_0.80$ was also equal until a -10% offset and started to decrease beyond, it stayed equal in the majority of simulations (\> 70%) even for underestimation of -50% (#ref(<fig-estimations>, supplement: [Figure])B). In the remaining simulations (\< 30%), the $n_0.80$ was higher than for the true range (less efficient), except for a few cases where it was lower (more efficient).

#figure([
#box(image("figures/ranges_overlap.png"))
], caption: figure.caption(
position: bottom, 
[
Comparison of efficiencies when over- and underestimating the focal species range for 200 independent simulations. Results are compared to the Balanced Within Range strategy applied on the exact species range, whose $n_0.80$ value is used as reference (specific to every simulation). In panel A, we use the over- and underestimation $n_0.80$ in proportion to the reference $n_0.80$ (y axis) given the range estimation offset (x axis) to highlight the linear trend and association with the offset percentage for overestimation. The dotted line at 1.00 indicates exactly equal $n_0.80$. In panel B, we summarize comparisons across all simulations to display the proportion of each comparison outcome (equal, higher, lower). The solid line represents the actual proportion value, while the shaded bands delimit the 90% confidence intervals for the proportion calculated using the Wilson interval method @Brown2001IntEst[ implemented in HypothesisTests.jl].
]), 
kind: "quarto-float-fig", 
supplement: "Figure", 
)
<fig-estimations>


= Discussion
<discussion>
#emph[What should be realistic expectations for sampling and monitoring of species interactions?]

Our simulations highlight that expectations for monitoring species interactions within spatially-balanced, general-purpose BONs should be much lower than for species richness, especially when considering that interaction realization and detection both depend on species abundance (#ref(<fig-nbons>, supplement: [Figure])). In other words, we can expect the monitoring of species interactions within a BON to require a (much) higher monitoring effort across space than the one required for monitoring species and community composition. Our observations are consistent with previous ones regarding higher sampling effort required to document pollinator networks @Chacoff2012EvaSam, yet here framed in the context of BON design and monitoring across space. Overall, these results reinforce the need for optimizing sampling designs for species interactions beyond and in complement to existing monitoring networks.

We can improve interaction coverage with the right optimization method, but efficiently doing so requires a clear and attainable monitoring objective. Adopting a single-species perspective (e.g.~focusing on interactions for a keystone or high degree species, #citeb(<Pires2017FriPar>)#citeb(<deAguiar2019RevBia>)) can yield relevant results while relying on attainable levels of information (Figures #ref(<fig-samplers>, supplement: []), #ref(<fig-layers>, supplement: []), #ref(<fig-eff-comp>, supplement: [])). Through our representative example in #ref(<fig-samplers>, supplement: [Figure]), we showed how Targeted Sampling and Balanced Within Range outperform spatially-balanced designs to monitor interactions for a focal species, while only relying on an attainable level of information (the species range). Two emerging questions that follow up on this result are: 1) what information is most efficient to target sites in sampling designs; and 2) how precisely do we need to estimate such information to expect efficiency improvements? Our simulation studies offer insights into both, as we detail next before concluding with recommendations for monitoring.

#emph[What strategies and available information are most efficient to optimize monitoring for species interactions?]

Ecologically-relevant metrics are required to evaluate the performance of monitoring designs, beyond spatial balance @Norman2025SitSel. While many sampling algorithms can perform similarly for biodiversity monitoring in certain contexts @Norman2025SitSel, our results highlighted better options when we can define a specific target for monitoring (#ref(<fig-eff-comp>, supplement: [Figure])). Optimizing on a known species range proved an efficient strategy to retrieve its interactions that was better than optimizing based on more holistic, community-level information such as species richness (Figures #ref(<fig-layers>, supplement: []), #ref(<fig-eff-comp>, supplement: [])) . This contrasts with earlier accounts where designs based on maximising species richness also proved efficient to conserve multiple biodiversity facets @Willig2023ProBio. Instead, our results highlight that more information about an entire system does not always lead to more efficient monitoring, and that efforts could instead be put towards identifying relevant targets with available information to guide monitoring design.

Optimizing based on the location of the realized interactions was, as expected, even more efficient than targeting the species range (Figures #ref(<fig-layers>, supplement: []), #ref(<fig-eff-comp>, supplement: [])). Yet, this represents a best case scenario that is likely beyond reach in an applied context: it assumes that there is already pre-existing knowledge on where species interactions can be observed, which is unlikely to exist for most interactions, species and locations across the globe, regardless of their relevance for monitoring. Nonetheless, it highlights that the most important efficiency gains will come from better knowledge of where interactions are likely to take place. On one hand, better incorporating factors influencing interaction realization and detection, such as species abundance in our simulations, will be crucial and potentially more impactful than improving knowledge or reducing uncertainty over species ranges (Figures #ref(<fig-layers>, supplement: []), #ref(<fig-eff-comp>, supplement: [])). Integrating abundances into network evaluations could be based on species regional abundances @RejiChacko2025SpeLos and would echo similar calls for integration of abundances and processes into conservation @FletcherJr.2025SpeRic@Dornelas2023LooBac@Tobias2025BioCon. On the other hand, our result also suggest that monitoring will become more efficient over time as we keep gathering knowledge on interactions, especially if local knowledge of the system and species under focus is incorporated. Such opportunities should emerge in recent BON initiatives integrating Indigenous and local community knowledge for an inclusive view of biodiversity change and recognizing multiple ways of knowing @Gonzalez2025BioObs. Overall, we should not wait for perfect knowledge: establishing operational monitoring frameworks to inform biodiversity conservation and management is possible as we keep gathering new information, and better ensures we translate knowledge into action @Dansereau2025OveDis@Buxton2021KeyInf.

#emph[How precise should estimations be to expect improvements in monitoring efficiency?]

A similarly-efficient alternative to targeted sampling is to follow an approach such as our Balanced Within Range strategy, where we generate a spatially balanced design across the area believed to be more informative. Our results from Simulation Study III are encouraging in this sense, as they show we do not need perfect knowledge when using this strategy (#ref(<fig-estimations>, supplement: [Figure])). The tolerance we observed to 10% over- and underestimation of the focal species range size offers an important margin that changes the information we can use to guide BON design. For instance, our test case of underestimating a species range highlights that we could focus mainly on the most certain parts of a species range prediction (e.g.~using conformal predictions along with species distribution models, #citeb(<Poisot2024ConPre>)) and expect similar monitoring efficiency. On the opposite side, in terms of range size, our overestimation test case is more analogous to a model focusing on the potential distribution rather than the realized distribution.

#emph[Recommendations for monitoring]

Documenting species interactions extensively requires higher sampling efforts than required to document species ranges. While spatially balanced designs are efficient in general purpose biodiversity monitoring, species interactions may be better served by specifically-optimized monitoring designs. To do so, we show the importance of selecting a appropriate target (e.g.~a focal species' interaction) and using attainable information restricting the phenomenon (here the species range) to optimize monitoring designs efficiently. There is a degree of tolerance in the level of exact information needed (similar to range over- and underestimation), therefore available information should be used as soon as possible to guide monitoring.

= Acknowledgements
<acknowledgements>
GD was funded by the NSERC Postgraduate Scholarship -- Doctoral (grant ES D -- 558643) and the FRQNT doctoral scholarship (grant no. 301750). TP was funded through award no. 223764/Z/21/Z from the Wellcome Trust, by the Discovery Grant program of NSERC, through a donation from the Courtois Foundation. MDC is funded by an IVADO Postdoctoral Fellowship. We thank the members of the #emph[Laboratoire d'Écologie Prédictive et Interprétable pour la Crise de la Biodiversité] in Montréal, QC, and of the Predictive Ecology team at the #emph[Pacific Forestry Centre] in Victoria, BC, for their constructive comments during discussions of this manuscript.

#set bibliography(style: "springer-basic-author-date")

#bibliography(("references.bib"))

