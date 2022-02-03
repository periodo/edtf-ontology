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

* [calendar date with unspecified digits](unspecified/day-precision)
* [reduced precision date (year and month only) with unspecified digits](unspecified/month-precision/)
* [reduced precision date (year only) with unspecified digits](unspecified/year-precision/)

## Range of possible dates (see [rules](../../level-2/range/rules.n3))

* [on or before date](range/on-or-before/)
* [on or after date](range/on-or-after/)
* [no earlier than date A and no later than date B](range/from-to/)

## Time interval (see [rules](../../level-2/interval/rules.n3))

The following intervals also use the [unspecified digit rules](../../level-1/unspecified/rules.n3):

* [with unspecified digits in start](interval/unspecified-start/)
* [with unspecified digits in end](interval/unspecified-end/)
* [with unspecified digits in start and end](interval/unspecified-both/)

The following intervals also use the [qualification rules](../../level-2/qualification/rules.n3):

* [with qualified start](interval/qualified-start/)
* [with qualified end](interval/qualified-end/)
* [with qualified start and end](interval/qualified-both/)

*Under construction:*

* with start on or before date
* with end on or after date

## Set of dates (see [rules](../../level-2/set/rules.n3))

*Under construction*
