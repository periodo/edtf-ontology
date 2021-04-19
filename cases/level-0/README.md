# EDTF level 0

These cases cover the examples of EDTF level 0 dates, datetimes, and
time intervals given at https://www.loc.gov/standards/datetime/.

Level 0 requires support for the following features.

## Date

* [complete representation](date-day-precision.ttl)
* [reduced precision for year and month](date-month-precision.ttl)
* [reduced precision for year](date-year-precision.ttl)

## Date and time

* [complete representations for calendar date and (local) time of day](datetime-local.ttl)
* [complete representations for calendar date and UTC time of day](datetime-utc.ttl)
* [date and time with timeshift in hours (only)](datetime-shifthour.ttl)
* [date and time with timeshift in hours and minutes](datetime-shifthourminute.ttl)

## Time interval

* [time interval with calendar year precision](interval-year-precision.ttl)
* [time interval with calendar month precision](interval-month-precision.ttl)
* [time interval with calendar day precision](interval-day-precision.ttl)
* [time interval starting with day precision and ending with month precision](interval-day-month-precision.ttl)
* [time interval starting with day precision and ending with year precision](interval-day-year-precision.ttl)
* [time interval starting with year precision and ending with month precision](interval-year-month-precision.ttl)
