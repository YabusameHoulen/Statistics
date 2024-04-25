#let pset(class: "默认类",
  title: "魔改PSET",
  student: "Xiao Junyu",
  date: datetime.today(),
  subproblems: "1.1.1.i",
  collaborators: (),
  doc
) = {[
/* Convert collaborators to a string if necessary */
#let collaborators=if type(collaborators) == array {collaborators.join(", ")} else {collaborators}

/* Problem + subproblem headings */
#set heading(numbering: (..nums) => {
    nums = nums.pos()
    if nums.len() == 1 {
      [#nums.at(0)]
    } else {
      numbering(subproblems, ..nums)
    }
})

/* Set metadata */
#set document(
  title: [#class - #title],
  author: student,
  date: date,
)

/* Set up page numbering and continued page headers */
#set page(
  numbering: "1",
  header: context {
  if counter(page).get().first() > 1 [
    #set text(style: "italic")
    #class -- #title
    #h(1fr)
    #student
    #if collaborators != none {[w/ #collaborators]}
    #block(line(length: 100%, stroke: 0.5pt), above: 0.6em)
  ]
})

/* Add numbering and some color to code blocks */
#show raw.where(block: true): it => {
  block[
    #h(1fr)
    #align(center,
      box(
        width: 75%,
        radius: 0.5em,
        stroke: luma(50%),
        inset: 0.5em,
        fill: luma(95%)
      )[
        #show raw.line: l => {
          box(width:measure([#it.lines.last().count]).width, align(left, text(fill: luma(30%))[#l.number]))
          h(1em)
          l.body
          h(60%)
        }
        #it
      ]
    )
  ]
}

/* Make the title */
#align(center, {
  text(size: 1.6em, weight: "semibold")[#class -- #title \ ]
  text(size: 1.2em)[#student \ ]
  [#date.display("[year]-[month]-[day]") ]
  // emph[
  //   #date.display("[year]-[month]-[day]") 
  //   #if collaborators != none {[
  //     \ Collaborators: #collaborators
  //   ]}
  // ]
  // box(line(length: 100%, stroke: 1pt))
})

#show heading: it => {
  it
  text()[#v(1em, weak: true)]
  text()[#h(1.5em)]
} // 两端对齐,段前缩进2字符

#doc
]}