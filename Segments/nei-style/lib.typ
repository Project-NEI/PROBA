#import "typslides.typ": (
  typslides,
  front-slide,
  table-of-contents,
  title-slide,
  cols,
  keyvalue,
  slide,
  focus-slide,
  blank-slide,
  bibliography-slide,
  final-slide,
  framed,
  boxed,
  stress
)

#import "lovelace.typ": (
  pseudocode,
  pseudocode-list,
  no-number,
  with-line-label,
  indent,
  line-label,
)

#import "../local.typ": presenter



#let lecture_phase = sys.inputs.at("phase", default: "post")
#let pre_only(body) = if lecture_phase == "pre" { body }
#let post_only(body) = if lecture_phase == "post" { body }
#let phase_only(phase, body) = if lecture_phase == phase { body }
