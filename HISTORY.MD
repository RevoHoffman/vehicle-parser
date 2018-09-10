## 1.0.0 (4-13-2012)

* First release.

## 1.1.0 (7-19-2012)

* Added phone and price parser

## 1.1.1 (11-17-2012)

* Added year parser

## 1.1.2 (11-17-2012)

* Added mileage parser

## 1.1.3 (11-20-2012)

* Fixed bug in mileage parser when there was no mileage tokens

## 1.1.4 (11-21-2012)

* Fixed bug in year parser and how we right adjust for 0's

## 1.1.5 (11-22-2012)

* Phone parser needed a .to_s and mileage parser is more robust.

## 1.1.6 (11-22-2012)

* Fixed issue where mileage would not be parsed if it was preceded by a newline character.

## 1.1.7 (12-2-2012)

* Changed phone parser

## 1.1.8 (12-5-2012)

* Fixed bug in year parser where telephone numbers would confuse it.

## 1.1.9 (12-8-2012)

* Refactor and simplification of the mileage parser.

## 1.1.10 (12-9-2012)

* PriceParser can now ignore keywords that would normally result in no price being found.

## 1.1.11 (1-3-2013)

* PriceParser can handle parsing out 2 digits of a 4 digit year.

## 1.1.12 (1-8-2013)

* MileageParser handles parsing when mileage is surrounded by parenthesis.

## 1.1.13 (7-14-2013)

* MileageParser removes common adjectives such as "actual miles" or "highway miles"

## 1.1.14 (7-14-2013)

* MileageParser removes tildes (~) from mileage. eg: "vehicle has ~30k miles"

## 1.1.15 (7-17-2013)

* Added the word "original" to adjective list.

## 1.1.16 (8-8-2013)

* Improved mileage parsing. Now parses textual phone numbers like "four-oh-three"

## 1.1.17 (8-19-2013)

* Improved mileage parsing. Return the highest mileage, instead of the lowest.

## 1.1.18 (9-28-2013)

* Improved mileage parsing; remove exclamation marks and periods for better parsing of mileage ending in 'k'

## 1.1.19 (9-29-2013)

* Improved mileage parsing; handle mileage such as 98k+ miles

## 1.1.20 (9-29-2013)

* Improved mileage parsing; handle mileage such as 150k (without mileage label)

## 1.1.21 (9-30-2013)

* Improved mileage parsing; Added several more use cases for the MORONS that inhabit the cesspool that is CL.

## 1.1.22 (9-30-2013)

* Improved mileage parsing; Added several more use cases for the MORONS that inhabit the cesspool that is CL. Again

## 1.1.23 (10-1-2013)

* Improved mileage parsing; Losing faith in humanity's ability to describe a vehicle's mileage.

## 1.1.24 (10-1-2013)

* Improved mileage parsing; No further point in even describing the changes here.

## 1.1.25 (10-4-2013)

* Allows for strict mode to be turned off so we can parse mileage tokens where there is no mileage labels.

## 1.1.26 (10-10-2013)

* Improved body type parsing; we now use the number of doors as a determinant if it isn't clear what the body type is.

## 1.1.27 (10-11-2013)

* Improved body type parsing; body types that include the entire word 'cab' will be decoded as pickup trucks

## 1.1.28 (10-12-2013)

* Improved body type parsing; body types that include the entire word 'sport utility' will be decoded as suv

## 1.1.29 (10-17-2013)

* Mileage parser won't mutate vehicle text

## 1.1.30 (1-25-2014)

* For some reason, Four Wheel Drive wasn't parsing...

## 1.1.30 (3-21-2014)

* Prioritize coupe over hatchback when we see both of them together.

## 1.1.34 (4-3-2014)

* Update fuel type parsers.

## 1.1.35 (4-3-2014)

* Added cab type parsers.

## 1.1.36 (5-5-2014)

* Removed flex fuel as a fuel type, since it's really just a gasoline engine.

## 1.1.37 (9-17-2015)

* Updated year parser

## 1.1.38 (4-20-2016)

* Added support for things like "Unleaded Fuel"

## 1.1.39 (9-10-2018)

* Added support for FourWD drive train parsing"

