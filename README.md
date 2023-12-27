# utils_plugin

## ابزارهای مربوط به کد ملی، پستی و اعداد فارسی

#### تبدیل عدد به حروف فارسی

```dart
Text("100092".toWord()),//صد هزار و نود و دو
```

#### تبدیل عدد به حروف انگلیسی

```dart
Text("100092".toWord(lang: NumStrLanguage.English)),//one hundred thousand ninety two
```


#### تبدیل حروف به عدد

```dart
Text('صد و یک هزار و سیصد و نود و دو'.toNumber().toString()), // 101392
```

#### جدا سازی سه رقمی ارقام

```dart
Text("100092".seRagham()),//100,092
Text("100092".seRagham(separator: "-")),//100-092
```
#### جدا سازی چهار رقمی ارقام

```dart
Text("6037991123456789".charRagham()), //6037-9911-2345-6789
Text("6037-9911-2345-6789".charRagham(separator: " ")), //6037 9911 2345 6789
```

#### جدا سازی اعداد از رشته

```dart
Text("123456+.abc".extractNumber()),//۱۲۳۴۵۶
Text("number123456اب ج -".extractNumber(toDigit: NumStrLanguage.English)),//123456
```

#### تبدیل اعداد از انگلیسی به فارسی و بالعکس

```dart
Text("123456789".toPersianDigit()),//۱۲۳۴۵۶۷۸۹
Text("۱۲۳۴۵۶۷۸۹".toEnglishDigit()),//123456789
```

#### تشخیص عددی بودن متن

```dart
Text("100092".isNumeric().toString()),//true
Text("100092aaa".isNumeric().toString()),//false
```

#### تبدیل تاریخ میلادی به شمسی

```dart
Text(DateTime.now().toPersianDate()),//۱۳۹۹/۰۷/۰۶
Text(DateTime.now().toPersianDate(twoDigits: false)),//۱۳۹۹/۷/۶
Text(DateTime.now().toPersianDate(twoDigits: true,showTime: true,timeSeprator: ' - ')),//۱۳۹۹/۰۷/۰۶ - ۰۷:۳۹

//اگه نیاز بود که زمان در سمت راست یا چپ متن قرار بگیرد
Text(DateTime.now().toPersianDate(twoDigits: true,showTime: true,changeDirectionShowTimw: false)),//۰۷:۳۹ ۱۳۹۹/۰۷/۰۶ 
```

#### تبدیل تاریخ میلادی به تاریخ شمسی از متن

```dart
Text("2020-10-07T07:47:03.233Z".toPersinaDate()),//۱۳۹۹/۷/۶
```

#### تبدیل تاریخ میلادی به تاریخ متنی شمسی

```dart
Text(DateTime.now().toPersianDateStr(strDay: true,strMonth: true)),// شانزده مهر  ۱۳۹۹
Text(DateTime.now().toPersianDateStr(showDayStr: true)),//چهارشنبه ۱۶ مهر  ۱۳۹۹
Text(DateTime.now().toPersianDateStr(strDay: true, strMonth: true, useAfghaniMonthName: true,)),//شانزده حوت ۱۳۹۹
```


#### اعتبارسنجی کد ملی ایرانیان

```dart
Text('1234567890'.isValidIranianNationalCode().toString()), // false
Text('2220042944'.isValidIranianNationalCode().toString()), // true
```

#### اعتبار سنجی شماره موبایل ایرانیان

```dart
Text('01112223344'.isValidIranianMobileNumber().toString()), // false
Text('09353391994'.isValidIranianMobileNumber().toString()), // true
Text('+989353391994'.isValidIranianMobileNumber().toString()), // true
Text('00989353391994'.isValidIranianMobileNumber().toString()), // true
```

#### نمایش خلاصه وار تاریخ نسبت به تاریخ فعلی

```dart
//Text(تاریخ و زمان مورد نظر شما .getDifferenceDateString().getDifferenceDateString())
Text(DateTime.now().add(Duration(seconds: -1)).getDifferenceDateString()),//لحظاتی پیش
Text(DateTime.now().add(Duration(seconds: -40)).getDifferenceDateString(aFewSecondsAgoText: "همین الان")),//همین الان
Text(DateTime.now().add(Duration(days: -6)).getDifferenceDateString()),//چند روز پیش
Text(DateTime.now().add(Duration(days: -1)).getDifferenceDateString()),//دیروز
Text(DateTime.now().add(Duration(days: -365)).getDifferenceDateString()),//سال پیش
Text(DateTime.now().add(Duration(days: -365)).getDifferenceDateString(lastYearText: "پارسال")),//پارسال
Text(DateTime.now().add(Duration(days: -78)).getDifferenceDateString())//چند ماه پیش
```

#### تبدیل به تومان و ریال

```dart
Text('1200'.beToman()), // 12000
Text('1200'.beRial()), // 120
```

#### اعتبار سنجی کارت بانکی

```dart
Text('1232234543212345'.isValidBankCardNumber().toString()), // false
```

#### تشخیص نام بانک از شماره کارت بانکی

```dart
Text('60376976...'.getBankNameFromCardNumber()), // بانک صادرات ایران
Text('60379911...'.getBankNameFromCardNumber()), // بانک ملی
Text('00000000...'.getBankNameFromCardNumber()), // -
```

#### تبدیل حروف غیر استاندارد به حروف استاندارد الفبای فارسی

```dart
Text('ئ ي ك ﮑ ﮐ ﮏ'.fixPersianChars()), //ی ی ک ک ک ک

```


#### اعتبارسنجی کد پستی ایرانیان

```dart
Text('5955846418'.isValidIranianPostalCode().toString()), // true
```

## Extensions- افزونه ها

## String Extension

### capitalize
اولین کاراکتر رشته را به "حروف بزرگ" و بقیه را به "حروف کوچک" تبدیل می کند.
```dart
'justkawal'.capitalize; // Justkawal
'JUSTKAWAL'.capitalize; // Justkawal
```

### lowerFirst
اولین کاراکتر رشته را به حروف کوچک تبدیل می کند.
```dart
'Justkawal'.lowerFirst; // justkawal
'JUSTKAWAL'.lowerFirst; // jUSTKAWAL
```

### upperFirst
اولین کاراکتر رشته را به حروف بزرگ تبدیل می کند.
```dart
'justkawal'.upperFirst; // Justkawal
'jUSTKAWAL'.upperFirst; // JUSTKAWAL
```

### words
"فهرست کلمات" را برمی گرداند.
```dart
'kàwàl vu'.words; // ['kàwàl', 'vu']
```

### camelCase
رشته را به 'camelCase' تبدیل می کند و آن را برمی گرداند.
```dart
'___just__kawal__'.camelCase; // justKawal
'  just  Kawal  '.camelCase; // justKawal
'-----just--Kawal--'.camelCase; // justKawal
```

### kebabCase
رشته را به 'kebabCase' تبدیل می کند.
```dart
'___hello__world__'.kebabCase(); // hello-world
'  hello  World  '.kebabCase(); // hello-world
'-----hello--world--'.kebabCase(); // hello-world
```

### lowerCase
///رشته را به حروف کوچک تبدیل می کند.
```dart
'___hello__world__'.lowerCase(); // hello world
'  hello  World  '.lowerCase(); // hello world
'-----hello--world--'.lowerCase(); // hello world
```

### snakeCase
رشته را به 'snakeCase' تبدیل می کند و آن را برمی گرداند.
```dart
'___hello__world__'.snakeCase(); // hello_world
'  helloWorld  '.snakeCase(); // hello_world
'-----hello--world--'.snakeCase(); // hello_world
```

### nameCase
رشته را به 'nameCase' تبدیل می کند و آن را برمی گرداند.
```dart
'___kaWaljeet__sInGH__'.nameCase(); // Kawaljeet Singh
'  justKawal  '.nameCase(); // Just Kawal
'-----kawaljeet--singh--'.nameCase(); // Kawaljeet Singh
```


## TimerUtil
```
setInterval: فاصله تایمر را تنظیم کنید.
setTotalTime: کل زمان شمارش معکوس را تنظیم کنید.
startTimer(): تایمر را شروع کنید.
startCountDown: شروع شمارش معکوس تایمر.
updateTotalTime: کل زمان شمارش معکوس را بازنشانی کنید.
cancel: تایمر را لغو کنید.
setOnTimerTickCallback: پاسخ به کال بک تایمر.
isActive: آیا تایمر شروع شده است یا خیر.
