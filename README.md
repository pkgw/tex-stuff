yahapj.bst -- yet another (h)ApJ bibtex style file
===============================================

This Git repository contains `yahapj.bst`, a BibTeX style file for
creating bibliographies in the format used by the Astrophysical
Journal.

Several such style files already exist, but they have various
shortcomings. It is also unclear which versions of which files are
derived from each other. It is hoped that by importing a version of
this file into Git, improvements can be shared more easily (see
below).

Features
--------

The style file is based off of the venerable `apj.bst` with several
changes:

+ ArXiV identifiers and links are included for those entries
  that don't contain any more formal reference information.
+ DOI links are embedded if available.
+ Trailing plus signs in page numbers are removed.

Because links are embedded, your LaTeX file must use the hyperref
package. To get links that aren't butt-ugly, we suggest:

```
\usepackage[colorlinks,urlcolor=blue,citecolor=blue,linkcolor=blue]{hyperref}
```

Making & Sharing Improvements
-----------------------------

If you'd like to make changes to the style file, you may run into the
minor problem that BibTeX style files are implemented in a bizarre
nonce language. The best reference I've been able to find is "Tame the
BeaST," by Nicolas Markey (markey@lsv.ens-cachan.fr), currently
available at:

http://www.lsv.ens-cachan.fr/~markey/BibTeX/doc/ttb_en.pdf

If you make changes to this file that you'd like to share, just clone
the Git repository and commit away! At least one incarnation of the
Git repository is accessible on GitHub, with all of the social coding
features that that entails, at https://github.com/pkgw/yahapj/.

Provenance
----------

The history of recent changes to the style file should be discovered
by consulting the Git history.

The seed file for the Git repository is based upon revision 1.7 of
`apj.bst` from the `astronat` package provided by the NASA
Astrophysics Data System:

http://ads.harvard.edu/pubs/bibtex/astronat/

That file was originally generated from `merlin.mbs`, which was
written by Patrick W. Daly. Subsequent changes were contributed by
Jonathan E. Baker, Tim Robishaw, Craig Wiegert, Andrew R. Marble, Stephan
Fegan, and Alberto Accomazzi.

The seed file adds in the changes in `hapj.bst` provided by arxiv.org:

http://arxiv.org/hypertex/bibstyles/

which were added by Varendra (Alvin) Das.

It also incorporates new-style arxiv identifiers from Jacques
Distler's utphys.bst.

These changes were collected and some further cleanups were 
made by Peter K. G. Williams.

Copyright Status
----------------

The original `merlin.mbs` claimed copyright from 1994-1998 for
Patrick W. Daly. Subsequent files have been copied and modified
by numerous parties all over the Internet. In assembling this
repository, I have deemed it fair to dedicate the style file
to the public domain.

Note that the original file did come with the following notice:

  This file may be used for non-profit purposes. It may not be
  distributed in exchange for money, other than distribution costs.
  The author provides it "as is" and does not guarantee it in any way.

Contributors
------------

+ Jonathan E. Baker (jbaker@astro.berkeley.edu)
+ Patrick W. Daly (daly@linmpi.mpg.de)
+ Varendra (Alvin) Das (alvin@iiap.res.in)
+ Jacques Distler (distler@golem.ph.utexas.edu)
+ Stephen Fegan (sfegan@llr.in2p3.fr)
+ Andrew R. Marble (amarble@as.arizona.edu)
+ Tim Robishaw (robishaw@astro.berkeley.edu)
+ Craig Wiegert (cwiegert@alumni.uchicago.edu)
+ Peter K. G. Williams (peter@newton.cx)
