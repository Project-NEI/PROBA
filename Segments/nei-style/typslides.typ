#import "utils.typ": *
#import "../local.typ": *

#let accent_color = rgb("000000")
#let background_color = rgb("393939")
#let normal_text = rgb("FFFFFF")
#let special_text = rgb("FFDD55")
#let sections = state("sections", ())

#let typslides(
  ratio: "16-9",
  body,
) = {
  set text(font: "Open Sans", hyphenate: false, fill: normal_text, weight:500)
  set par(justify: false)
  set page(paper: "presentation-" + ratio, fill: background_color)
  set table(stroke:1.5pt + special_text)
  show raw: set text(font:"Inconsolata", size:24pt, weight:"medium")
  set raw(theme:"../nei-style/nei.tmTheme")
  show math.equation: set text(font: "STIX Two Math", size:24pt)

  show emph: it => (
    context {
      set text(fill: special_text)
      [#it]
    }
  )

  show ref: it => (
    context {
      text(fill: normal_text)[#it]
    }
  )

  show link: it => (
    context {
      text(fill: rgb("#22F0BB"))[#it]
    }
  )

  show footnote: it => (
    context {
      text(fill: normal_text)[#it]
    }
  )

  set enum(numbering: (it => context text(fill: black)[*#it.*]))

  body
}

//*************************************** Aux functions ***************************************\\



//***************************************************\\

#let stress(body) = (
  context {
    set text(fill: special_text)
    [#body]
  }
)

//***************************************************\\

#let framed(
  title: none,
  back-color: none,
  content,
) = (
  context {
    let w = auto

    set block(
      inset: (x: .6cm, y: .6cm),
      breakable: false,
      above: .1cm,
      below: .1cm,
    )

    if title != none {
      set block(width: 100%, fill: background_color)
      stack(
        block(
          fill: background_color,
          inset: (x: .6cm, y: .55cm),
          radius: (top: .2cm, bottom: 0cm),
          stroke: 2pt,
        )[
          #text(weight: "semibold", fill: white)[#title]
        ],
        block(
          fill: background_color,
          radius: (top: 0cm, bottom: .2cm),
          stroke: 2pt,
          content,
        ),
      )
    } else {
      stack(
        block(
          width: auto,
          fill: background_color,
          radius: (top: .2cm, bottom: .2cm),
          stroke: 2pt,
          content,
        ),
      )
    }
  }
)

//***************************************************\\

// Source: https://github.com/polylux-typ/polylux/blob/main/src/toolbox/toolbox-impl.typ

#let cols(columns: none, gutter: 1em, ..bodies) = {
  let bodies = bodies.pos()

  let columns = if columns == none {
    (1fr,) * bodies.len()
  } else {
    columns
  }

  if columns.len() != bodies.len() {
    panic("Number of columns must match number of content arguments")
  }

  grid(columns: columns, gutter: gutter, ..bodies)
}

//***************************************************\\

#let boxed(
  text-size: 32pt,
  content,
) = {
  set align(center + horizon)
  set text(size: text-size)
  show math.equation: set text(font: "STIX Two Math", size:text-size)
  block(
    fill: accent_color,
    inset: (x: .8cm, y: .8cm),
    breakable: false,
    above: .9cm,
    below: .9cm,
    radius: (top: .2cm, bottom: .2cm),
  )[#content]
}

//***************************************************\\

#let register-section(
  name,
) = (
  context {
    let sect-page = here().position()
    sections.update(sections => {
      sections.push((body: name, loc: sect-page))
      sections
    })
  }
)

//**************************************** Front Slide ****************************************\\

#let front-slide(
  title: none,
  subtitle: none,
  reading: none,
) = (
  context {
    _make-frontpage(
      course,
      title,
      subtitle,
      presenter,
      org,
      reading,
      accent_color,
      special_text,
    )
  }
)

//*************************************** Content Slide ***************************************\\



#let table-of-contents(
  title: "Contents",
  text-size: 23pt,
) = (
  context {
    text(size: 42pt, weight: "bold")[
      #smallcaps(title)
      #v(-.9cm)
      #_divider(color: special_text)
    ]

    set text(size: text-size)

    show linebreak: none

    let sections = sections.final()
    pad(enum(..sections.map(section => link(section.loc, section.body))))

    pagebreak()
  }
)

//**************************************** Title Slide ****************************************\\

#let title-slide(
  body,
  text-size: 42pt,
) = (
  context {
    register-section(body)

    show heading: text.with(size: text-size, weight: "semibold")

    set align(left + horizon)

    [= #smallcaps(body)]

    _divider(color: special_text)

    pagebreak()
  }
)

//**************************************** Focus Slide ****************************************\\

#let focus-slide(
  text-color: white,
  text-size: 38pt,
  body,
) = (
  context {
    set page(fill: accent_color)

    set text(
      size: text-size,
      fill: text-color,
    )

    set align(center + horizon)

    _resize-text(body)
  }
)

//****************************************** Slide ********************************************\\

#let slide(
  title: none,
  body,
) = (
  context {
    let page-num = context counter(page).display(
      "1/1",
      both: true,
    )

    set page(
      fill: background_color,
      header-ascent: if title != none {
        70%
      } else {
        50%
      },
      margin: if title != none {
        (x: 0.4cm, top: 2.25cm, bottom: 0.6cm)
      } else {
        (x: 0.4cm, top: 1.25cm, bottom: 0.6cm)
      },
      background: place(_slide-header(title, accent_color)),
    )

    set list(marker: text(special_text, [•]))

    set enum(numbering: (it => context text(fill: special_text)[*#it.*]))

    set text(size: 24pt)
    set align(horizon)

    v(0cm) // avoids header breaking if body is empty
    body
  }
)

//**************************************** Blank slide ****************************************\\

#let blank-slide(body) = (
  context {
    let page-num = context counter(page).display(
      "1/1",
      both: true,
    )

    set page(
      header: [
        #align(right)[
          #text(
            fill: normal_text,
            weight: "semibold",
            size: 12pt,
          )[#page-num]
        ]
      ],
    )

    set list(marker: text(special_text, [•]))

    set enum(numbering: (it => context text(fill: special_text)[*#it.*]))

    set text(size: 20pt)
    set par(justify: true)
    set align(horizon)
    body
  }
)

//**************************************** Bibliography ***************************************\\

#let bibliography-slide(
  bib-call,
  title: "References",
) = (
  context {
    set text(size: 19pt)
    set par(justify: true)

    set bibliography(title: text(size: 30pt)[#smallcaps(title) #v(-.85cm) #_divider(color: special_text) #v(.5cm)])

    bib-call
  }
)

#let keyvalue(what, who) = (
  context {
    text(yellow)[#what ]
    text(white)[#who]
  }
)

#let final-slide(
  text-color: white,
  text-size: 38pt,
  body,
) = (
  context {
    set page(fill: background_color)

    set text(
      weight: "bold",
      size: 38pt,
      font: "Open Sans",
      fill: white,
    )

    set align(center + horizon)
    [Questions?

    ]

    _divider(color:accent_color)

    set text(
      weight: "semibold",
      size: 24pt,
      fill: yellow,
      font: "Open Sans",
    )
    _resize-text(body)
  }
)
