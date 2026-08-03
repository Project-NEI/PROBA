#let divider() = [
  #v(1pt)
  #line(start: (5%,0%), end: (95%,0%), stroke: 1pt + rgb("DA8B33"))
  #v(1pt)
]

#let conf(

// SET BASIC TEMPLATE DEFAULTS:
  title: none,
  subtitle: none,
  authors: ( (name: [Neil Brown]) ), // IF NOT IN METADATA
//  email: "email@example.com", //IF NOT IN METADATA
  venue: none,
  abstract: none,
  lang: "en",
  region: "US",
  font: "Open Sans", // sets the "font" variable
  fontsize: 12pt, // likewise
  fontweight: "medium",
  sectionnumbering: none,
  doc,
) = {
  set page("us-letter", margin: (left: 2cm, top: 1.5cm, right: 2cm, bottom: 1.5cm),
    header:  // A running head: document title
      context {
        if counter(page).at(here()).first() > 1 [    // after page 1
           #set text(size: 10pt, style: "italic")
           #align(right)[#title]
        ]
    },
    footer-descent: 30%, //30 is default
    footer:  // A running footer: page numbers
      context {
        if counter(page).at(here()).first() > 0 [     // all pages
          #set text(size: 10pt)
            #align(right)[#counter(page).display("1")]
          ]
     },
)


// BASIC BODY PARAGRAPH FORMATTING
//
  set par(
    first-line-indent: 0em,
    leading: 1.0em,
    justify: false,
    spacing: 2em,
  )
// ALT PARAGRAPH STYLE, COMMENT PREV 6 LINES, and UNCOMMENT THESE:
// show par: set block(spacing: 18pt) // blank line between paragraphs
//  set par(
//    first-line-indent: 0em,
//    leading: 8pt,
//    justify: true,
//  )
  set text(lang: lang,
         font: font, // set on line 40 above
         size: fontsize,
         alternates: false,
)


// Block quotations
//
  set quote(block: true)
  show quote: set block(spacing: 2em)
  show quote: set pad(x: 2em)   // L&R margins
  show quote: set par(leading: 1.3em)
  show quote: set text(style: "italic")


// Images and figures:
//
  set image(width: 5.25in, fit: "contain")
  show image: it => {
    align(center, it)
  }
  set figure(gap: 0.5em, supplement: none)
  show figure.caption: set text(size: 9pt)

// Code snippets:
//
  show raw: set block(width: 100%,inset: (left: 0.5em, top: 0.5em, right: 0.5em, bottom: 0.5em ), fill:rgb("E0E0E0"), radius:0.3cm, breakable:false)
  show raw: set text(font: "Inconsolata",size:12pt)


// Footnote formatting
//
  set footnote.entry(indent: 0.5em)
  show footnote.entry: set par(hanging-indent: 1em)
  show footnote.entry: set text(size: 10pt)



// HEADINGS
//
  show heading: set text(hyphenate: false)

  show heading.where(level: 1
    ):  it => align(left, block(above: 1.5em, below: 1.0em, width: 80% )[
        #set par(leading: 5em)
        #set text(font: font, weight: "semibold", size: 14pt)
        #block(it.body)
      ])

  show heading.where(level: 2
    ): it => align(left, block(above: 1.3em, below: 1.0em, width: 80%)[
        #set text(font: font, weight: "semibold", size: 12pt)
        #block(it.body)
      ])

  show heading.where(level: 3
    ): it => align(left, block(above: 1.2em, below: 0.9em)[
        #set text(font: font, weight: "regular", style: "italic", size: 11pt)
        #block(it.body)
      ])

// URLs
//

  show link: underline
  show link: set text(fill: blue)

// ============================================

// HERE'S THE DOCUMENT LAYOUT


// THIS IS THE TITLE/METADATA BLOCK
// v is for vertical spacing
//

v(10pt)
  align(left, text(size: 20pt)[
    #set par(justify: false)
    #title])
  v(2pt)
//  align(left, text(size: 16pt, style: "italic")[
//     #set par(first-line-indent: 0em, justify: false)
//     #subtitle])
//  v(3pt)
//  align(right, text(size: 11pt)[#authors.first().name (#email)])
//  v(3pt)


// THIS IS THE ACTUAL BODY:

  counter(page).update(1) // start page numbering
  doc  // this is where the content goes

// COLOPHON at bottom of last page
//
//v(1fr)
//line(start: (30%,0%), end: (70%,0%), stroke: 0.5pt + gray)
//align(center, text(size: 8pt, style: "italic")[For any questions relating to this, please email #email.])


}  // end of #let conf block



// BOILERPLATE PANDOC TEMPLATE:

#show: doc => conf(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(author)$
  authors: (
$for(author)$
$if(author.name)$
    ( name: [$author.name$],
      affiliation: [$author.affil$],
      email: [$author.email$] ),
$else$
    ( name: [$author$],
      affiliation: [],
      email: [] ),
$endif$
$endfor$
    ),
$endif$
$if(venue)$
  venue: [$venue$],
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
  doc,
)

$if(toc)$
#outline(
  title: auto,
  depth: none
);
$endif$

$body$

$if(citations)$
$if(bibliographystyle)$

#set bibliography(style: "$bibliographystyle$")
$endif$
$if(bibliography)$

#bibliography($for(bibliography)$"$bibliography$"$sep$,$endfor$)
$endif$
$endif$
$for(include-after)$

$include-after$
$endfor$
