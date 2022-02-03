# EDTF level 2

These cases cover the examples of EDTF level 2 dates, datetimes, and
time intervals given at https://www.loc.gov/standards/datetime/.

Level 2 requires support for [Level 1](../level-1#readme) as well as
the following features:

## Extended year (see [rules](../../rules/level-2/extended-year/rules.n3))

* [exponential year](extended-year/exponential/)
* [year with significant digits](extended-year/significant-digits/)

## Year subdivision (see [rules](../../rules/level-2/year-subdivision/rules.n3))

* [season](year-subdivision/season/)
* [quarter](year-subdivision/quarter/)
* [quadrimester](year-subdivision/quadrimester/)
* [semestral](year-subdivision/semestral/)
 
## Qualification of date (see [rules](../../level-2/qualification/rules.n3))

* [qualified date component(s)](qualification/individual/)
* [qualified date component group(s)](qualification/group/)
 
## Unspecified digit(s) (see [rules](../../level-2/unspecified/rules.n3))

* [date with unspecified digits](unspecified/)

## Time interval (see [rules](../../level-2/interval/rules.n3))

* [with unspecified digits in start](interval/unspecified-start/)
* [with unspecified digits in end](interval/unspecified-end/)
* [with unspecified digits in start and end](interval/unspecified-both/)
* [with qualified start](interval/qualified-start/)
* [with qualified end](interval/qualified-end/)
* [with qualified start and end](interval/qualified-both/)
* [with start on or before date](interval/on-or-before/)
* [with end on or after date](interval/on-or-after/)

## Set of dates (see [rules](../../level-2/set/rules.n3))
 
* [one of fully enumerated set](set/one-of-full/)
* [one of partially enumerated set](set/one-of-partial/)
* [one of open set](set/one-of-open/)
* [one of partially enumerated and open set](set/one-of-partial-and-open/)
* [all of fully enumerated set](set/all-of-full/)
* [all of partially enumerated set](set/all-of-partial/)
* [all of open set](set/all-of-open/)
* [all of partially enumerated and open set](set/all-of-partial-and-open/)

