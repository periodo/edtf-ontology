# EDTF level 0

These cases cover the examples of EDTF level 0 dates, datetimes, and
time intervals given at https://www.loc.gov/standards/datetime/.

Level 0 requires support for the following features.

## Date and time (see [rules](../../rules/common.n3))

* [calendar date and (local) time of day](datetime/second-precision-local/)
* [calendar date and UTC time of day](datetime/second-precision-utc/)
* [calendar date](datetime/day-precision/)
* [reduced precision date (year and month only)](datetime/month-precision/)
* [reduced precision date (year only)](datetime/year-precision/)

## Date and time relative to (shifted from) UTC (see [rules](../../rules/level-0/shift/rules.n3))

* [date and time with time shift (hours only)](shift/hours/)
* [date and time with time shift (hours and minutes)](shift/hours-minutes/)

## Time interval (see [rules](../../rules/level-0/interval/rules.n3))

* [time interval with year precision](interval/year-precision/)
* [time interval with month precision](interval/month-precision/)
* [time interval with day precision](interval/day-precision/)
* [time interval starting with day precision and ending with month precision](interval/day-month-precision/)
* [time interval starting with day precision and ending with year precision](interval/day-year-precision/)
* [time interval starting with year precision and ending with month precision](interval/year-month-precision/)
