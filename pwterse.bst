% Terse bibliography for proposals. Based on bibtex 'abbrv'.

ENTRY {
    address
    archive
    archivePrefix
    author
    booktitle
    chapter
    doi
    edition
    editor
    eprint
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    primaryClass
    publisher
    school
    series
    title
    type
    url
    volume
    year
} {} {
    label
}


% Basic boolean helpers.

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}


% Sentence-building infrastructure.

INTEGERS { output.state before.all mid.sentence after.sentence }

STRINGS { s t }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
}

FUNCTION {output.nonnull.comma}
% input: stack -1: string (assumed nonempty)
% input: stack -2: string
% output: stack -1: same as on input
% write -2, possibly following it with "," or ".".
% state is mid.sentence when done.
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.sentence =
        { add.period$ write$
          newline$
        }
        'write$ % <- before.all case
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.nonnull.nocomma}
% as above, except no comma if mid.sentence.
{ 's :=
  output.state mid.sentence =
    { " " * write$ }
    { output.state after.sentence =
        { add.period$ write$
          newline$
        }
        'write$ % <- before.all case
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.skipempty.comma}
% input: stack -1: string
% input: stack -2: string
% output: stack -1: same as on input
% Do nothing if -1 is empty. Otherwise, write -2, possibly following it with "," or ".".
% If -1 is not empty, state is mid.sentence when done.
{ duplicate$ empty$
    'pop$
    'output.nonnull.comma
  if$
}

FUNCTION {output.skipempty.nocomma}
% as above, except no comma if mid.sentence
{ duplicate$ empty$
    'pop$
    'output.nonnull.nocomma
  if$
}

FUNCTION {output.check.comma}
% input: stack -1: description of item
% input: stack -2: string (shouldn't be empty; warns if yes)
% input: stack -3: string
% output: stack -1: = input -3
% like output, but warns if empty.
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull.comma
  if$
}

FUNCTION {output.check.nocomma}
% as above, except no comma if mid.sentence
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull.nocomma
  if$
}

FUNCTION {new.sentence}
% stack-agnostic
% set output state to after.sentence, unless it is before.all
{ output.state before.all =
    'skip$
    { after.sentence 'output.state := }
  if$
}

FUNCTION {begin.entry}
% input: nothing on stack
% output: stack -1: ""
% sets output state to before.all.
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {finish.entry}
% input: stack -1: string
% output: empty stack
{ add.period$
  write$
  newline$
}


% Text manipulation utilities

FUNCTION {emphasize}
% input: stack -1: string, empty ok
% output: stack -1: input -1 wrapped in \emph{}, or "".
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {tie.or.space.connect}
% input: stack -1: string
% input: stack -2: string
% output: stack -1: (-2) + X + (-1), where X is "~" or " "
%   depending on if (-1) is less than 3 characters long.
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

INTEGERS { work.strlen }

FUNCTION {string.length}
% input: stack -1: string
% output: stack -1: the length of input -1
{ % Copied from "Taming the BeaST", by Nicolas Markey, Fig 4
  #1 'work.strlen :=
  { duplicate$ duplicate$ #1 work.strlen substring$ = not }
    { work.strlen #1 + 'work.strlen := }
  while$
  pop$ work.strlen
}


% Name formatting

INTEGERS { nameptr namesleft numnames numtrunc }

FUNCTION {format.names}
{ 's :=
  #0 'numtrunc :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
  numnames #2 >
    { #1 'numtrunc := }
    {}
  if$
  { namesleft #0 > }
  { s nameptr
    "{vv~}{ll}{~jj}{~f{}}" format.name$
    't :=
    nameptr #1 >
      {
        nameptr #1 - numtrunc =
          {
            #1 'namesleft :=
            "others" 't :=
          }
          {}
        if$

        namesleft #1 >
          { ", " * t * }
          { s nameptr "{ll}" format.name$ duplicate$ "others" =
              { 't := }
              { pop$ }
            if$
            t "others" =
              {
                " \textit{et~al.}" *
              }
              { " \& " * t * }
            if$
          }
        if$
      }
      't
    if$
    nameptr #1 + 'nameptr :=
    namesleft #1 - 'namesleft :=
  }
  while$
}

FUNCTION {format.authors}
% input: agnostic
% output: stack -1: formatted author names (or "")
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
% input: agnostic
% output: stack -1: formatted editor names (or "")
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", eds." * }
        { ", ed." * }
      if$
    }
  if$
}


% Other bibliography info formatting

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {format.volume.wordy}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " edition" * }
        { edition "t" change.case$ " edition" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {first.page}
{ 't :=
  ""
    {  t empty$ not t #1 #1 substring$ "-" = not and }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
  while$
  % remove possible trailing plus sign
  duplicate$ duplicate$ string.length #1 substring$ "+" =
    { duplicate$ string.length #1 - #1 swap$ substring$ }
    { }
  if$
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages first.page }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "in " booktitle emphasize * }
        { "in " format.editors * ", " * booktitle emphasize * }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.archive}
{ archivePrefix empty$
    { "" }
    { archivePrefix ":" *}
  if$
}

FUNCTION {format.primaryClass}
{ primaryClass empty$
    { "" }
    { " [" primaryClass * "]" *}
  if$
}

FUNCTION {format.eprint}
% Only print eprint info if no page info and no booktitle info --
% what we're really going for is print the eprint info only if there's
% no "official" reference info to work with.
{ eprint empty$
  pages empty$ not
  booktitle empty$ not or or
  { "" }
  { archive empty$
    { "\href{http://arxiv.org/abs/" eprint * "}" *
      "{\textsf{" * format.archive * eprint *
      format.primaryClass * "}}" * }
    { "\href{" archive *  "/" * eprint * "}" *
      "{\textsf{" * format.archive * eprint *
      format.primaryClass * "}}" *
    }
    if$
  }
  if$
}

FUNCTION {maybe.doi.link.prepend}
{ % Expects some citation text to be on the stack
 doi empty$
  { url empty$
     { }
     { "\href{" url * "}{" * swap$ * }
    if$
  }
  { "\href{http://dx.doi.org/" doi * "}{" * swap$ * }
 if$
}

FUNCTION {maybe.doi.link.end}
{ % Expects some citation text to be on the stack
 doi empty$ url empty$ and
  { }
  { "}" * }
 if$
}


% Support for the actual items we're going to output.

FUNCTION {article}
{ begin.entry
  format.authors "author" output.check.comma

  new.sentence
  year
  maybe.doi.link.prepend "year" output.check.nocomma
  journal "journal" output.check.nocomma
  volume missing$ % if no volume, assume it's a preprint without full pub info yet.
    { format.eprint output.skipempty.comma }
    { volume output.skipempty.nocomma
      pages first.page "page" output.check.nocomma }
  if$
  maybe.doi.link.end

  new.sentence
  note output.skipempty.comma
  finish.entry
}

FUNCTION {book}
{ begin.entry
  author empty$
    { format.editors "author and editor" output.check.comma }
    { format.authors output.nonnull.comma
      "author and editor" editor either.or.check
    }
  if$

  new.sentence
  year maybe.doi.link.prepend "year" output.check.comma
  title emphasize "title" output.check.comma
  format.volume.wordy output.skipempty.comma
  format.edition output.skipempty.comma
  "(" publisher * ")" * "publisher" output.check.nocomma
  maybe.doi.link.end

  new.sentence
  note output.skipempty.comma
  finish.entry
}

FUNCTION {incollection}
{ begin.entry
  format.authors "author" output.check.comma

  new.sentence
  year maybe.doi.link.prepend "year" output.check.comma
  format.in.ed.booktitle "booktitle" output.check.comma
  format.volume.wordy output.skipempty.comma
  format.edition output.skipempty.comma
  "(" publisher * ")" * "publisher" output.check.nocomma
  format.pages output.skipempty.comma
  maybe.doi.link.end

  new.sentence
  note output.skipempty.comma
  finish.entry
}

FUNCTION {inproceedings}
{ begin.entry
  format.authors "author" output.check.comma

  new.sentence
  year maybe.doi.link.prepend "year" output.check.comma
  format.in.ed.booktitle "booktitle" output.check.comma
  format.volume.wordy output.skipempty.comma
  format.edition output.skipempty.comma
  "(" publisher * ")" * "publisher" output.check.nocomma
  format.pages output.skipempty.comma
  maybe.doi.link.end

  new.sentence
  note output.skipempty.comma
  finish.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {misc}
{ begin.entry
  format.authors "author" output.check.comma

  new.sentence
  year maybe.doi.link.prepend output.skipempty.comma
  format.title output.skipempty.comma
  maybe.doi.link.end

  new.sentence
  note output.skipempty.comma
  finish.entry

  empty.misc.check
}

FUNCTION {phdthesis}
{ begin.entry
  format.authors "author" output.check.comma

  new.sentence
  year "year" output.check.comma
  title emphasize "title" output.check.comma
  "PhD thesis" output.nonnull.comma
  school "school" output.check.comma

  new.sentence
  note output.skipempty.comma
  finish.entry
}

FUNCTION {default.type} { misc }


% The "longest label" pass. Not sure if this is relevant at all
% in numbers mode.

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {init.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}


% Go, go, go!

READ

EXECUTE {init.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
