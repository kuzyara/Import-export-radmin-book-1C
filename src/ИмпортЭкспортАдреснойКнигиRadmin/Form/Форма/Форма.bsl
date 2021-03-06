﻿
&НаКлиенте
Процедура ПутьКФайлу1НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Режим = РежимДиалогаВыбораФайла.Открытие;
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(Режим);
	ДиалогОткрытияФайла.ПолноеИмяФайла = "";
	Фильтр = "Адресная книга Radmin (*.rpb;*.csv)|*.rpb;*.csv";
	ДиалогОткрытияФайла.Фильтр = Фильтр;
	ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
	ДиалогОткрытияФайла.Заголовок = "Выберите файл";
	Если ДиалогОткрытияФайла.Выбрать() Тогда
	    ЭтаФорма.ПутьКФайлу1 = ДиалогОткрытияФайла.ПолноеИмяФайла;
	КонецЕсли; 

КонецПроцедуры

&НаКлиенте
Процедура ПутьКФайлу2НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Режим = РежимДиалогаВыбораФайла.Открытие;
	ДиалогОткрытияФайла = Новый ДиалогВыбораФайла(Режим);
	ДиалогОткрытияФайла.ПолноеИмяФайла = "";
	Фильтр = "Адресная книга Radmin (*.rpb)|*.rpb|Текст CSV (*.csv)|*.csv";
	ДиалогОткрытияФайла.Фильтр = Фильтр;
	ДиалогОткрытияФайла.МножественныйВыбор = Ложь;
	ДиалогОткрытияФайла.Заголовок = "Выберите файл";
	Если ДиалогОткрытияФайла.Выбрать() Тогда
	    ЭтаФорма.ПутьКФайлу2 = ДиалогОткрытияФайла.ПолноеИмяФайла;
	КонецЕсли; 

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ВывестиТаблицуДанныхНаФорму(ЭтаФорма, "тзАдреснаяКнига");
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьИзФайла(ДвоичныеДанныеФайла)
	
	ФайлДанных = Новый Файл(ЭтаФорма.ПутьКФайлу1);
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	
	Если ФайлДанных.Расширение = ".rpb" Тогда
		ОбработкаОбъект.ЗагрузитьФайлRPB(ДвоичныеДанныеФайла);
	ИначеЕсли ФайлДанных.Расширение = ".csv" Тогда
		ОбработкаОбъект.ЗагрузитьФайлCSV(ДвоичныеДанныеФайла);
	КонецЕсли;
	
	ОбработкаОбъект.ВывестиТаблицуДанныхНаФорму(ЭтаФорма, "тзАдреснаяКнига");
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаПрочитатьЗаписи(Команда)
	
	ДвоичныеДанныеФайла = Новый ДвоичныеДанные(ПутьКФайлу1);
	ЗагрузитьИзФайла(ДвоичныеДанныеФайла);
	
КонецПроцедуры

&НаСервере
Функция ВыгрузитьВФайл()
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	тз = РеквизитФормыВЗначение("тзАдреснаяКнига");
	ОбработкаОбъект.ЗагрузитьТаблицуДанных(тз);
	
	ФайлВыгрузки = Новый Файл(ЭтаФорма.ПутьКФайлу2);
	
	Если ФайлВыгрузки.Расширение = ".rpb" Тогда
		ДвоичныеДанныеФайла = ОбработкаОбъект.СформироватьФайлRPB();
	ИначеЕсли ФайлВыгрузки.Расширение = ".csv" Тогда
		ДвоичныеДанныеФайла = ОбработкаОбъект.СформироватьФайлCSV();
	КонецЕсли;

	Возврат ДвоичныеДанныеФайла;
КонецФункции

&НаКлиенте
Процедура КомандаСохранитьЗаписи(Команда)
	
	ДвоичныеДанныеФайла = ВыгрузитьВФайл();
	ДвоичныеДанныеФайла.Записать(ПутьКФайлу2);
		
КонецПроцедуры


&НаКлиенте
Процедура КомандаИерархическийПросмотр(Команда)
	ИмяФормыИерархическогоПросмотра = Лев(ЭтаФорма.ИмяФормы, Найти(ЭтаФорма.ИмяФормы,".Форма.")+6)+ "ФормаИерархическогоПросмотра";
	ОткрытьФорму(ИмяФормыИерархическогоПросмотра);
КонецПроцедуры

