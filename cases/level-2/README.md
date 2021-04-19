# EDTF level 2

These cases cover the examples of EDTF level 2 dates, datetimes, and
time intervals given at https://www.loc.gov/standards/datetime/.

Level 2 requires support for [Level 1](../level-1#readme) as well as
the following features:

## [Exponential year](exponential-year)

## Significant digits

* [four-digit year with significant digits](year-significant-digits.ttl)
* [letter-prefixed year with significant digits](letter-prefixed-year-significant-digits.ttl)
* [exponential year with significant digits](exponential-year-significant-digits.ttl)

## [Sub-year groupings](quarter.ttl)
 
## Set representation

* [one of a partially enumerated range of years](one-of-set-1.ttl)
* [one of an open range of dates](one-of-set-2.ttl)
* [one of an open range of months](one-of-set-3.ttl)
* [one of a partially enumerated and open range of months](one-of-set-4.ttl)
* [one of a fully enumerated set of times](one-of-set-5.ttl)
* [one of an open range of years](one-of-set-6.ttl)
* [all of a partially enumerated range of years](all-of-set-1.ttl)
* [all of a fully enumerated set of times](all-of-set-2.ttl)
* [all of an open range of years](all-of-set-3.ttl)
 
## Qualification

* [year, month, and day uncertain and approximate](group-qualification-1.ttl)
* [year and month approximate](group-qualification-2.ttl)
* [year uncertain](group-qualification-3.ttl)
* [year uncertain; month known; day approximate](individual-qualification-1.ttl)
* [month uncertain and approximate; year and day known](individual-qualification-2.ttl)
 
## Unspecified Digit

* [one rightmost unspecified year digit, month specified, day specified](unspecified-digit-1.ttl)
* [two rightmost unspecified year digits, month specified, day specified](unspecified-digit-2.ttl)
* [year unspecified, month specified, day unspecified](unspecified-digit-3.ttl)
* [three rightmost unspecified year digits, month unspecified](unspecified-digit-4.ttl)
* [three rightmost unspecified year digits, month specified](unspecified-digit-5.ttl)
* [year specified, one rightmost unspecified month digit](unspecified-digit-6.ttl)

## Interval

* [approximate start and end days interval](qualified-interval-1.ttl)
* [unspecified start day interval](qualified-interval-2.ttl)
