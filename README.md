yahapj.bst — yet another hacked ApJ bibtex style file
=====================================================

This Git repository contains `yahapj.bst`, a BibTeX style file for creating
bibliographies in the format used by the Astrophysical Journal. It largely
operates like `apj.bst`, in that your bibliography will closely resemble what
is required for articles in the Astrophysical Journal. However it has a few
nice new features:

+ ArXiV identifiers and links are included for those entries
  that don't contain any more formal reference information.
+ DOI links are embedded if available.
+ Trailing plus signs in page numbers are removed.
+ Automatic compatibility with the [jabbrv] journal name abbreviation package.
+ Maintenance in Git makes it easy to stay updated.

[jabbrv]: http://www.compholio.com/latex/jabbrv/

To use `yahapj.bst`:

1. Use BibTeX for your bibliography. Help with this is beyond the scope of
   this file.
2. Copy the file `yahapj.bst` to the directory containing your LaTeX file, or
   import this Git repository as a submodule in your paper's Git repository.
3. Make sure your LaTeX file uses the `hyperref` package. For attractive
   links, we suggest:
   ```
   \usepackage[breaklinks,colorlinks,urlcolor=blue,citecolor=blue,linkcolor=blue]{hyperref}
   ```
4. Before your `\bibliography{}` command, put:
   ```
   \bibliographystyle{yahapj}
   ```
5. That’s all there is to it!


Making & Sharing Improvements
-----------------------------

The style file is derived from the venerable `apj.bst` and adds some features
which are mostly cribbed from other hacked versions of this file, especially
the `hapj.bst` provided by ArXiv. We hope that by importing a version of this
file into Git, improvements can be shared more easily.

If you make changes to this file that you'd like to share, just clone the Git
repository and commit away! At least one incarnation of the Git repository is
accessible on GitHub, with all of the social coding features that that
entails, at https://github.com/pkgw/yahapj/.

If you'd like to make changes to the style file, you may run into the minor
problem that BibTeX style files are implemented in a bizarre nonce language.
The best reference I've been able to find is “[Tame the BeaST][tame],” by
[Nicolas Markey][markey].

[tame]: http://www.lsv.ens-cachan.fr/~markey/BibTeX/doc/ttb_en.pdf
[markey]: http://www.lsv.ens-cachan.fr/~markey/


Provenance
----------

The history of recent changes to the style file should be discovered by
consulting the Git history.

The seed file for the Git repository is based upon revision 1.7 of `apj.bst`
from the [astronat] package provided by the NASA [Astrophysics Data
System][ads]. That file was originally generated from `merlin.mbs`, which was
written by Patrick W. Daly. Subsequent changes were contributed by Jonathan E.
Baker, Tim Robishaw, Craig Wiegert, Andrew R. Marble, Stephan Fegan, and
Alberto Accomazzi.

The seed file adds in the changes in [hapj.bst] provided by
[arxiv.org][arxiv], which were added by Varendra (Alvin) Das. The version of
the file provided by arxiv.org is based on what is effectively revision 1.5 of
the ADS `apj.bst`.

It also incorporates new-style arxiv identifiers from Jacques Distler's
[utphys.bst].

These changes were collected and some further cleanups were made by Peter K.
G. Williams.

[ads]: http://adsabs.harvard.edu/
[arxiv]: http://arxiv.org/
[astronat]: http://ads.harvard.edu/pubs/bibtex/astronat/
[hapj.bst]: http://arxiv.org/hypertex/bibstyles/
[utphys.bst]: http://golem.ph.utexas.edu/~distler/TeXstuff/utphys.bst


Copyright Status of `yahapj.bst`
--------------------------------

The original `merlin.mbs` claimed copyright from 1994-1998 for Patrick W.
Daly. Subsequent files have been copied and modified by numerous parties all
over the Internet. In assembling this repository, I have deemed it fair to
dedicate the style file to the public domain.

Note that the original file did come with the following notice from within
`merlin.mbs`:

> This file may be used for non-profit purposes. It may not be distributed in
> exchange for money, other than distribution costs. The author provides it
> “as is” and does not guarantee it in any way.

It is not clear to me (Peter Williams) if this clause applies to the generated
BibTeX style file, or only the source `merlin.mbs` file. If the notice does
not apply to `yahapj.bst`, or `yahapj.bst` is treated as being in the public
domain, the “non-profit” clause is inoperative, and you may attempt to
distribute it in exchange for money. Have fun with that.


Copyright Status of This File
-----------------------------

This README file is also dedicated to the public domain. You have unlimited
permission to copy, distribute, and modify it.


Contributors
------------

+ Alberto Accomazzi (aaccomazzi@cfa.harvard.edu)
+ Jonathan E. Baker (jbaker@astro.berkeley.edu)
+ Patrick W. Daly (daly@linmpi.mpg.de)
+ Varendra (Alvin) Das (alvin@iiap.res.in)
+ Jacques Distler (distler@golem.ph.utexas.edu)
+ Stephen Fegan (sfegan@llr.in2p3.fr)
+ Andrew R. Marble (amarble@as.arizona.edu)
+ Tim Robishaw (robishaw@astro.berkeley.edu)
+ Tim van Werkhoven (werkhoven@strw.leidenuniv.nl)
+ Craig Wiegert (cwiegert@alumni.uchicago.edu)
+ Peter K. G. Williams (peter@newton.cx)
