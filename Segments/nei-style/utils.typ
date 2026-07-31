

//#show raw: set text(font:"Inconsolata", size:24pt, weight:900)

#set text(lang: "en")

//************************************************************************\\

#let _resize-text(body) = layout(size => {
  let font-size = text.size
  let (height,) = measure(
    block(width: size.width, text(size: font-size)[#body]),
  )

  let max_height = size.height

  while height > max_height {
    font-size -= 0.2pt
    height = measure(
      block(width: size.width, text(size: font-size)[#body]),
    ).height
  }

  block(
    height: height,
    width: 100%,
    text(size: font-size)[#body],
  )
})

//************************************************************************\\

#let _divider(color: none) = {
  line(
    length: 100%,
    stroke: 2.5pt + color,
  )
}

//************************************************************************\\

#let _slide-header(title, color) = {
  rect(
    fill: color,
    width: 100%,
    height: if title != none {
      2.0cm
    } else {
      .95cm
    },
    inset: 0.4cm,
    text(white, weight: "semibold", size: 36pt)[#h(.1cm) #title],
  )
}

//************************************************************************\\

#let _make-frontpage(
  course,
  title,
  subtitle,
  authors,
  reading,
  affiliation,
  theme-color,
  special_text,
) = {

  set align(left + horizon)
  set page(footer: none)

  if course != none {
    text(40pt, weight: "extrabold")[#course:]
  }
  linebreak()
  text(40pt, weight: "bold", fill: special_text)[#title]

  if subtitle != none {
    set text(24pt)
    subtitle
  }

  _divider(color: theme-color)

  if authors != none {
    text(22pt, weight: "regular")[#authors]
  }
  linebreak()

  if reading != none {
    text(22pt, weight: "regular")[#reading]
  }
  linebreak()

  if affiliation != none {
   text(22pt, weight: "regular")[#affiliation]
  }


}
