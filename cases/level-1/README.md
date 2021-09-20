# EDTF level 1

These cases cover the examples of EDTF level 1 dates, datetimes, and
time intervals given at https://www.loc.gov/standards/datetime/.

Level 1 requires support for [Level 0](../level-0#readme) as well as
the following features:

## Extended year (see [rules](../../rules/level-1/extended-year/rules.n3))

* [letter-prefixed year](extended-year/)
 
## Season (see [rules](../../rules/level-1/season/rules.n3))

* [season](season/)
 
## Qualification of date (see [rules](../../level-1/qualification/rules.n3))

* [qualified calendar date](qualification/day-precision/)
* [qualified reduced precision date (year and month only)](qualification/month-precision/)
* [qualified reduced precision date (year only)](qualification/year-precision/)
 
## Unspecified digit(s) (see [rules](../../level-1/unspecified/rules.n3))

* [calendar date with unspecified digits](unspecified/day-precision)
* [reduced precision date (year and month only) with unspecified digits](unspecified/month-precision/)
* [reduced precision date (year only) with unspecified digits](unspecified/year-precision/)

## Time interval (see [rules](../../level-1/interval/rules.n3))

* [with unknown start](interval/unknown-start/)
* [with unknown end](interval/unknown-end/)
* [with open start](interval/open-start/)
* [with open end](interval/open-end/)
* [mysterious time interval](interval/mysterious/)

The following also use the [qualification rules](../../level-1/qualification/rules.n3):

* [with qualified start](interval/qualified-start/)
* [with qualified end](interval/qualified-end/)
* [with qualified start and end](interval/qualified-both/)
