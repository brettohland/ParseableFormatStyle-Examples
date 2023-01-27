import UIKit

// MARK: - Parsing Numbers

// MARK: Parsing Integers
try? Int("120", format: .number) // 120
try? Int("0.25", format: .number) // 0
try? Int("1E5", format: .number.notation(.scientific)) // 100000

// MARK: Parsing Floating Point Numbers
try? Double("0.0025", format: .number) // 0.0025
try? Double("95%", format: .number) // 95
try? Double("95%", format: .percent) // 95
try? Double("1E5", format: .number.notation(.scientific)) // 100000

try? Float("0.0025", format: .number) // 0.0025
try? Float("95%", format: .number) // 95
try? Float("1E5", format: .number.notation(.scientific)) // 100000

// MARK: Parsing Decimals
try? Decimal("0.0025", format: .number) // 0.0025
try? Decimal("95%", format: .number) // 95
try? Decimal("1E5", format: .number.notation(.scientific)) // 100000

// MARK: Parsing Percentages
try? Int("98%", format: .percent) // 98
try? Float("95%", format: .percent) // 0.95
try? Decimal("95%", format: .percent) // 0.95

// MARK: Parsing Currencies
try? Decimal("$100.25", format: .currency(code: "USD")) // 100.25
try? Decimal("100.25 British Points", format: .currency(code: "GBP")) // 100.25

// MARK: - Parsing Dates

try? Date.FormatStyle()
    .day()
    .month()
    .year()
    .hour()
    .minute()
    .second()
    .parse("Feb 22, 2022, 2:22:22 AM") // Feb 22, 2022, 2:22:22 AM

try? Date.FormatStyle()
    .day()
    .month()
    .year()
    .hour()
    .minute()
    .second()
    .parseStrategy.parse("Feb 22, 2022, 2:22:22 AM") // Feb 22, 2022, 2:22:22 AM

try? Date.ISO8601FormatStyle(timeZone: TimeZone(secondsFromGMT: 0)!)
    .year()
    .day()
    .month()
    .dateSeparator(.dash)
    .dateTimeSeparator(.standard)
    .timeSeparator(.colon)
    .timeZoneSeparator(.colon)
    .time(includingFractionalSeconds: true)
    .parse("2022-02-22T09:22:22.000") // Feb 22, 2022, 2:22:22 AM

try? Date.ISO8601FormatStyle(timeZone: TimeZone(secondsFromGMT: 0)!)
    .year()
    .day()
    .month()
    .dateSeparator(.dash)
    .dateTimeSeparator(.standard)
    .timeSeparator(.colon)
    .timeZoneSeparator(.colon)
    .time(includingFractionalSeconds: true)
    .parseStrategy.parse("2022-02-22T09:22:22.000") // Feb 22, 2022, 2:22:22 AM

try? Date(
    "Feb 22, 2022, 2:22:22 AM",
    strategy: Date.FormatStyle().day().month().year().hour().minute().second().parseStrategy
) // Feb 22, 2022 at 2:22 AM

try? Date(
    "2022-02-22T09:22:22.000",
    strategy: Date.ISO8601FormatStyle(timeZone: TimeZone(secondsFromGMT: 0)!)
        .year()
        .day()
        .month()
        .dateSeparator(.dash)
        .dateTimeSeparator(.standard)
        .timeSeparator(.colon)
        .timeZoneSeparator(.colon)
        .time(includingFractionalSeconds: true)
        .parseStrategy
) // Feb 22, 2022 at 2:22 AM

// MARK: - Parsing Person Names

// namePrefix: Dr givenName: Elizabeth middleName: Jillian familyName: Smith nameSuffix: Esq.
try? PersonNameComponents.FormatStyle()
    .parseStrategy.parse("Dr Elizabeth Jillian Smith Esq.")

// namePrefix: Dr givenName: Elizabeth middleName: Jillian familyName: Smith nameSuffix: Esq.
try? PersonNameComponents.FormatStyle(style: .long)
    .parseStrategy.parse("Dr Elizabeth Jillian Smith Esq.")

// namePrefix: Dr givenName: Elizabeth middleName: Jillian familyName: Smith nameSuffix: Esq.
try? PersonNameComponents.FormatStyle(style: .long, locale: Locale(identifier: "zh_CN"))
    .parseStrategy.parse("Dr Smith Elizabeth Jillian Esq.")

// namePrefix: Dr givenName: Elizabeth middleName: Jillian familyName: Smith nameSuffix: Esq.
try? PersonNameComponents.FormatStyle(style: .long)
    .locale(Locale(identifier: "zh_CN"))
    .parseStrategy.parse("Dr Smith Elizabeth Jillian Esq.")

// namePrefix: Dr givenName: Elizabeth middleName: Jillian familyName: Smith nameSuffix: Esq.
try? PersonNameComponents(
    "Dr Elizabeth Jillian Smith Esq.",
    strategy: PersonNameComponents.FormatStyle(style: .long).parseStrategy
)
