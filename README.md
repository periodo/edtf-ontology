# EDTF literals

This repository is for developing a set of test cases for implementing “rich literals” containing [Extended Date/Time Format (EDTF)](https://www.loc.gov/standards/datetime/) values, i.e. literals having one of the [EDTF datatypes](https://id.loc.gov/datatypes/edtf.html).

The term “rich literal” comes from [a comment by David Booth](https://lists.w3.org/Archives/Public/semantic-web/2020Jul/0200.html):

> I could see rich literals being quite helpful in making RDF easier to 
use, provided that the literal<->RDF mapping is available.  This mapping 
requires two functions: one from a given literal to RDF, and the other 
from RDF to literal.

> Ideally, these mapping functions should be defined "in-band" in the RDF 
itself, so that data can always be self-describing, and all standard 
tools would automatically support it, without depending on additional 
software installation for each new rich literal type.
