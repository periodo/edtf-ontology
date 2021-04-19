# EDTF in RDF/OWL

This repository is for discussion and development of standards, best
practices, and tools for using [Extended Date/Time Format
(EDTF)](https://www.loc.gov/standards/datetime/) in RDF and OWL.

Currently it contains:

* A [draft ontology](https://periodo.github.io/edtf-ontology/)
  extending the [Time Ontology](https://www.w3.org/TR/owl-time/) to
  model EDTF concepts

* A set of Turtle files using this ontology to model the different
  examples from the EDTF specification for EDTF [level
  0](cases/level-0#readme), [level 1](cases/level-1#readme), and
  [level 2](cases/level-2#readme).

Initially we just hope to reach consensus on how EDTF maps onto the
Time Ontology.

Future work may include:

* Rules for automatically inferring Time Ontology constructs from EDTF
  strings

* Standards for linking datatypes to such rules so that non-EDTF aware
  tools can process EDTF (see [David Booth's speculation about “rich
  literals”](https://lists.w3.org/Archives/Public/semantic-web/2020Jul/0200.html))

* Mapping to other temporal ontologies such as
  [CIDOC-CRM](http://www.cidoc-crm.org/)

See the [discussions](discussions) for more.
