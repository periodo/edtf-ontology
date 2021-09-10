# EDTF level 0

These cases cover the examples of EDTF level 0 dates, datetimes, and
time intervals given at https://www.loc.gov/standards/datetime/.

Level 0 requires support for the following features.

## Date and time

* [complete representation of calendar date](datetime/day-precision/)
* [complete representation of calendar date and (local) time of day](datetime/second-precision-local/)
* [complete representation of calendar date and UTC time of day](datetime/second-precision-utc/)
* [reduced precision representation of year and month](datetime/month-precision/)
* [reduced precision representatiom of year](datetime/year-precision/)

## Date and time relative to (shifted from) UTC

* [date and time with time shift in hours (only)](shift/hours/)
* [date and time with time shift in hours and minutes](shift/hours-minutes/)

## Time interval

* [time interval with year precision](interval/year-precision/)
* [time interval with month precision](interval/month-precision/)
* [time interval with day precision](interval/day-precision/)
* [time interval starting with day precision and ending with month precision](interval/day-month-precision/)
* [time interval starting with day precision and ending with year precision](interval/day-year-precision/)
* [time interval starting with year precision and ending with month precision](interval/year-month-precision/)
