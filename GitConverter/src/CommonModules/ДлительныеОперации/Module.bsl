////////////////////////////////////////////////////////////////////////////////
// Подсистема "Базовая функциональность".
// Поддержка работы длительных серверных операций в веб-клиенте.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Отменяет выполнение фонового задания по переданному идентификатору.
// 
// Параметры:
//  ИдентификаторЗадания - УникальныйИдентификатор - идентификатор фонового задания. 
// 
Процедура ОтменитьВыполнениеЗадания(Знач ИдентификаторЗадания) Экспорт 
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		Возврат;
	КонецЕсли;
	
	Задание = НайтиЗаданиеПоИдентификатору(ИдентификаторЗадания);
	Если Задание = Неопределено
		ИЛИ Задание.Состояние <> СостояниеФоновогоЗадания.Активно Тогда
		
		Возврат;
	КонецЕсли;
	
	Попытка
		Задание.Отменить();
	Исключение
		// Возможно задание как раз в этот момент закончилось и ошибки нет.
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Длительные операции.Отмена выполнения фонового задания'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
КонецПроцедуры

// Проверяет состояние фонового задания по переданному идентификатору.
// При аварийном завершении задания вызывает исключение.
//
// Параметры:
//  ИдентификаторЗадания - УникальныйИдентификатор - идентификатор фонового задания. 
//
// Возвращаемое значение:
//  Булево - состояние выполнения задания.
// 
Функция ЗаданиеВыполнено(Знач ИдентификаторЗадания) Экспорт
	
	Задание = НайтиЗаданиеПоИдентификатору(ИдентификаторЗадания);
	
	Если Задание <> Неопределено
		И Задание.Состояние = СостояниеФоновогоЗадания.Активно Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ОперацияНеВыполнена = Истина;
	ПоказатьПолныйТекстОшибки = Ложь;
	Если Задание = Неопределено Тогда
		ЗаписьЖурналаРегистрации(НСтр("ru = 'Длительные операции.Фоновое задание не найдено'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка, , , Строка(ИдентификаторЗадания));
	Иначе
		Если Задание.Состояние = СостояниеФоновогоЗадания.ЗавершеноАварийно Тогда
			ОшибкаЗадания = Задание.ИнформацияОбОшибке;
			Если ОшибкаЗадания <> Неопределено Тогда
				ПоказатьПолныйТекстОшибки = Истина;
			КонецЕсли;
		ИначеЕсли Задание.Состояние = СостояниеФоновогоЗадания.Отменено Тогда
			ЗаписьЖурналаРегистрации(
				НСтр("ru = 'Длительные операции.Фоновое задание отменено администратором'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка,
				,
				,
				НСтр("ru = 'Задание завершилось с неизвестной ошибкой.'"));
		Иначе
			Возврат Истина;
		КонецЕсли;
	КонецЕсли;
	
	Если ПоказатьПолныйТекстОшибки Тогда
		ТекстОшибки = КраткоеПредставлениеОшибки(ПолучитьИнформациюОбОшибке(Задание.ИнформацияОбОшибке));
		ВызватьИсключение(ТекстОшибки);
	ИначеЕсли ОперацияНеВыполнена Тогда
		ВызватьИсключение(НСтр("ru = 'Не удалось выполнить данную операцию. 
		                             |Подробности см. в Журнале регистрации.'"));
	КонецЕсли;
	
КонецФункции

// Регистрирует в сообщениях информацию о ходе выполнения фонового задания.
//   В дальнейшем эту информацию можно считать с клиента при помощи функции ПрочитатьПрогресс.
//
// Параметры:
//  Процент - Число  - Необязательный. Процент выполнения.
//  Текст   - Строка - Необязательный. Информация о текущей операции.
//  ДополнительныеПараметры - Произвольный - Необязательный. Любая дополнительная информация,
//      которую необходимо передать на клиент. Значение должно быть простым (сериализуемым в XML строку).
//
Процедура СообщитьПрогресс(Знач Процент = Неопределено, Знач Текст = Неопределено, Знач ДополнительныеПараметры = Неопределено) Экспорт
	
	ПередаваемоеЗначение = Новый Структура;
	Если Процент <> Неопределено Тогда
		ПередаваемоеЗначение.Вставить("Процент", Процент);
	КонецЕсли;
	Если Текст <> Неопределено Тогда
		ПередаваемоеЗначение.Вставить("Текст", Текст);
	КонецЕсли;
	Если ДополнительныеПараметры <> Неопределено Тогда
		ПередаваемоеЗначение.Вставить("ДополнительныеПараметры", ДополнительныеПараметры);
	КонецЕсли;
	
	ПередаваемыйТекст = ОбщегоНазначения.ЗначениеВСтрокуXML(ПередаваемоеЗначение);
	
	Текст = "{" + ИмяПодсистемы() + "}" + ПередаваемыйТекст;
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
	
	ПолучитьСообщенияПользователю(Истина); // Удаление предыдущих сообщений.
	
КонецПроцедуры

// Находит фоновое задание и считывает из его сообщений информацию о ходе выполнения.
//
// Возвращаемое значение:
//   Структура - Информация о ходе выполнения фонового задания.
//       Ключи и значения структуры соответствуют именам и значениям параметров процедуры СообщитьПрогресс().
//
Функция ПрочитатьПрогресс(Знач ИдентификаторЗадания) Экспорт
	Перем Результат;
	
	Задание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторЗадания);
	Если Задание = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	
	МассивСообщений = Задание.ПолучитьСообщенияПользователю(Истина);
	Если МассивСообщений = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	
	Количество = МассивСообщений.Количество();
	
	Для Номер = 1 По Количество Цикл
		ОбратныйИндекс = Количество - Номер;
		Сообщение = МассивСообщений[ОбратныйИндекс];
		
		Если СтрНачинаетсяС(Сообщение.Текст, "{") Тогда
			Позиция = СтрНайти(Сообщение.Текст, "}");
			Если Позиция > 2 Тогда
				ИдентификаторМеханизма = Сред(Сообщение.Текст, 2, Позиция - 2);
				Если ИдентификаторМеханизма = ИмяПодсистемы() Тогда
					ПолученныйТекст = Сред(Сообщение.Текст, Позиция + 1);
					Результат = ОбщегоНазначения.ЗначениеИзСтрокиXML(ПолученныйТекст);
					Прервать;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Запускает выполнение процедуры в фоновом задании.
Функция ЗапуститьВыполнениеВФонеСлужебный(Знач ИдентификаторФормы, Знач ИмяЭкспортнойПроцедуры, Знач Параметры,
	Знач НаименованиеЗадания = "", ИспользоватьДополнительноеВременноеХранилище = Ложь, ОжидатьЗавершение = Истина) Экспорт
	
	АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено, ИдентификаторФормы);
	
	Результат = Новый Структура;
	Результат.Вставить("АдресХранилища",       АдресХранилища);
	Результат.Вставить("ЗаданиеВыполнено",     Ложь);
	Результат.Вставить("ИдентификаторЗадания", Неопределено);
	
	Если Не ЗначениеЗаполнено(НаименованиеЗадания) Тогда
		НаименованиеЗадания = ИмяЭкспортнойПроцедуры;
	КонецЕсли;
	
	ПараметрыЭкспортнойПроцедуры = Новый Массив;
	ПараметрыЭкспортнойПроцедуры.Добавить(Параметры);
	ПараметрыЭкспортнойПроцедуры.Добавить(АдресХранилища);
	
	Если ИспользоватьДополнительноеВременноеХранилище Тогда
		АдресХранилищаДополнительный = ПоместитьВоВременноеХранилище(Неопределено, ИдентификаторФормы);
		ПараметрыЭкспортнойПроцедуры.Добавить(АдресХранилищаДополнительный);
	КонецЕсли;
	
	ЗапущеноЗаданий = 0;
	Если ОбщегоНазначения.ИнформационнаяБазаФайловая() Тогда
		Отбор = Новый Структура;
		Отбор.Вставить("Состояние", СостояниеФоновогоЗадания.Активно);
		ЗапущеноЗаданий = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор).Количество();
	КонецЕсли;
	
	Если ЗапущеноЗаданий > 0 Тогда
		СтандартныеПодсистемыСервер.ВыполнитьМетодКонфигурации(ИмяЭкспортнойПроцедуры, ПараметрыЭкспортнойПроцедуры);
		Результат.ЗаданиеВыполнено = Истина;
	Иначе
		ПараметрыЗадания = Новый Массив;
		ПараметрыЗадания.Добавить(ИмяЭкспортнойПроцедуры);
		ПараметрыЗадания.Добавить(ПараметрыЭкспортнойПроцедуры);
		ВремяОжидания = ?(ПолучитьСкоростьКлиентскогоСоединения() = СкоростьКлиентскогоСоединения.Низкая, 4, 2);
		
		Задание = СтандартныеПодсистемыСервер.ЗапуститьФоновоеЗаданиеСКонтекстомКлиента(ИмяЭкспортнойПроцедуры,
			ПараметрыЭкспортнойПроцедуры,, НаименованиеЗадания);
			
		Если ОжидатьЗавершение Тогда
			Попытка
				Задание.ОжидатьЗавершения(ВремяОжидания);
			Исключение
				// Специальная обработка не требуется, возможно исключение вызвано истечением времени ожидания.
			КонецПопытки;
		КонецЕсли;
		
		Результат.ЗаданиеВыполнено = ЗаданиеВыполнено(Задание.УникальныйИдентификатор);
		Результат.ИдентификаторЗадания = Задание.УникальныйИдентификатор;
	КонецЕсли;
	
	Если ИспользоватьДополнительноеВременноеХранилище Тогда
		Результат.Вставить("АдресХранилищаДополнительный", АдресХранилищаДополнительный);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НайтиЗаданиеПоИдентификатору(Знач ИдентификаторЗадания)
	
	Если ТипЗнч(ИдентификаторЗадания) = Тип("Строка") Тогда
		ИдентификаторЗадания = Новый УникальныйИдентификатор(ИдентификаторЗадания);
	КонецЕсли;
	
	Задание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторЗадания);
	
	Возврат Задание;
	
КонецФункции

Функция ПолучитьИнформациюОбОшибке(ИнформацияОбОшибке)
	
	Результат = ИнформацияОбОшибке;
	Если ИнформацияОбОшибке <> Неопределено Тогда
		Если ИнформацияОбОшибке.Причина <> Неопределено Тогда
			Результат = ПолучитьИнформациюОбОшибке(ИнформацияОбОшибке.Причина);
		КонецЕсли;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ИмяПодсистемы()
	Возврат "СтандартныеПодсистемы.ДлительныеОперации";
КонецФункции

#КонецОбласти
