#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
		
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Наименование = Адрес;
	
	// Создание регламентного задания (получение уникального идентификатора)
	УстановитьПривилегированныйРежим(Истина);
	
	Задание = РегламентныеЗаданияСервер.Задание(РегламентноеЗадание);
	Если Задание = Неопределено
		И ДополнительныеСвойства.Свойство("Использование")
		И ДополнительныеСвойства.Использование Тогда
		
		ПараметрыЗадания = Новый Структура;
		ПараметрыЗадания.Вставить("Метаданные", Метаданные.РегламентныеЗадания.КонвертацияХранилища);
		ПараметрыЗадания.Вставить("Использование", Ложь);
		ПараметрыЗадания.Вставить("Расписание", Новый РасписаниеРегламентногоЗадания);
		ПараметрыЗадания.Вставить("Наименование", НСтр("ru = 'Конвертация хранилища'") + ": " + СокрЛП(Адрес));
		Задание = РегламентныеЗаданияСервер.ДобавитьЗадание(ПараметрыЗадания);
		
		РегламентноеЗадание = РегламентныеЗаданияСервер.УникальныйИдентификатор(Задание);
		
	КонецЕсли;
	
	КаталогВыгрузкиВРепозитории = СокрЛП(КаталогВыгрузкиВРепозитории);
	
	Если НЕ ПустаяСтрока(КаталогВыгрузкиВРепозитории) Тогда
		ПервыйСимвол = Лев(КаталогВыгрузкиВРепозитории, 1);
		Если ПервыйСимвол = "\" ИЛИ ПервыйСимвол = "/" Тогда
			КаталогВыгрузкиВРепозитории = Сред(КаталогВыгрузкиВРепозитории, 2);
		КонецЕсли;
	КонецЕсли;
	
	ДополнительныеСвойства.Вставить("Задание",Задание);
	УстановитьПривилегированныйРежим(Ложь);
	
	
	Если ВыгружатьИзменения И ОбщегоНазначенияКлиентСервер.СравнитьВерсии(ВерсияПлатформы, "8.3.10.0") < 1 Тогда
		ВыгружатьИзменения = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если Отказ ИЛИ ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("Задание") Тогда
		Задание = ДополнительныеСвойства.Задание;
		Если Задание = Неопределено Тогда
			Возврат;
		КонецЕсли;
	Иначе
		Возврат;
	КонецЕсли;
	
	ПараметрыЗадания = Новый Структура;
	
	// Расписание устанавливается в форме элемента
	Если ДополнительныеСвойства.Свойство("Расписание") 
			И ТипЗнч(ДополнительныеСвойства.Расписание) = Тип("РасписаниеРегламентногоЗадания")
			И Строка(ДополнительныеСвойства.Расписание) <> Строка(Задание.Расписание) Тогда
		ПараметрыЗадания.Вставить("Расписание", ДополнительныеСвойства.Расписание);
	КонецЕсли;
	
	// Использование устанавливается в форме элемента
	Если ПометкаУдаления И Задание.Использование Тогда
		
		ПараметрыЗадания.Вставить("Использование", Ложь);
		
	ИначеЕсли ДополнительныеСвойства.Свойство("Использование") 
			И ДополнительныеСвойства.Использование <> Задание.Использование Тогда
		
		ПараметрыЗадания.Вставить("Использование", ДополнительныеСвойства.Использование);
		
	КонецЕсли;
	НаименованиеЗадания = НСтр("ru = 'Конвертация хранилища'") + ": ";
	
	НаименованиеЗадания = НаименованиеЗадания + СокрЛП(Адрес);
	ПараметрыЗадания.Вставить("Наименование", НаименованиеЗадания);
	ПараметрыЗадания.Вставить("Ключ", Строка(Ссылка.УникальныйИдентификатор()));
	
	Если Задание.Параметры.Количество() <> 1 ИЛИ Задание.Параметры[0] <> Ссылка Тогда
		МассивПараметров = Новый Массив;
		МассивПараметров.Добавить(Ссылка);
		ПараметрыЗадания.Вставить("Параметры", МассивПараметров);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	РегламентныеЗаданияСервер.ИзменитьЗадание(РегламентноеЗадание, ПараметрыЗадания);
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	РегламентноеЗадание = Неопределено;
	ВерсияВGit = Неопределено;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	РегламентныеЗаданияСервер.УдалитьЗадание(РегламентноеЗадание);
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНеПроверяемыхРеквизитов = Новый Массив;
	
	Если НЕ ЗначениеЗаполнено(АдресРепозиторияGit) Тогда
	
		МассивНеПроверяемыхРеквизитов.Добавить("ПользовательСервераGit");
		МассивНеПроверяемыхРеквизитов.Добавить("ПарольСервераGit");
	
	КонецЕсли; 
 
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНеПроверяемыхРеквизитов);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли