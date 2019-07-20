///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2017-2018, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by-sa/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает массив квалифицированных имен метаданных
// 
// Параметры:
// Возвращаемое значение:
// 	Массив - массив квалифицированных имен
Функция КвалифицированныеИменаМетаданных() Экспорт
	
	Имена = Новый Массив;
	Имена.Добавить("AccountingRegisters");
	Имена.Добавить("AccumulationRegisters");
	Имена.Добавить("BusinessProcesses");
	Имена.Добавить("CalculationRegisters");
	Имена.Добавить("Catalogs");
	Имена.Добавить("ChartsOfAccounts");
	Имена.Добавить("ChartsOfCalculationTypes");
	Имена.Добавить("ChartsOfCharacteristicTypes");
	Имена.Добавить("CommandGroups");
	Имена.Добавить("CommonAttributes");
	Имена.Добавить("CommonCommands");
	Имена.Добавить("CommonForms");
	Имена.Добавить("CommonModules");
	Имена.Добавить("CommonPictures");
	Имена.Добавить("CommonTemplates");
	Имена.Добавить("Constants");
	Имена.Добавить("DataProcessors");
	Имена.Добавить("DefinedTypes");
	Имена.Добавить("DocumentJournals");
	Имена.Добавить("DocumentNumerators");
	Имена.Добавить("Documents");
	Имена.Добавить("Enums");
	Имена.Добавить("EventSubscriptions");
	Имена.Добавить("ExchangePlans");
	Имена.Добавить("ExternalDataSources");
	Имена.Добавить("FilterCriteria");
	Имена.Добавить("FunctionalOptions");
	Имена.Добавить("FunctionalOptionsParameters");
	Имена.Добавить("HTTPServices");
	Имена.Добавить("InformationRegisters");
	Имена.Добавить("Languages");
	Имена.Добавить("Reports");
	Имена.Добавить("Roles");
	Имена.Добавить("ScheduledJobs");
	Имена.Добавить("Sequences");
	Имена.Добавить("SessionParameters");
	Имена.Добавить("SettingsStorages");
	Имена.Добавить("StyleItems");
	Имена.Добавить("Subsystems");
	Имена.Добавить("Tasks");
	Имена.Добавить("WebServices");
	Имена.Добавить("XDTOPackages");
	
	Имена.Добавить("Commands");
	Имена.Добавить("Forms");
	Имена.Добавить("Templates");
	
	Имена.Добавить("Ext");
	Имена.Добавить("Template.xml");
	Имена.Добавить("Form.xml");
	Имена.Добавить("Form");
	Имена.Добавить("Module.bsl");
	Имена.Добавить("ManagerModule.bsl");
	Имена.Добавить("RecordSetModule.bsl");
	Имена.Добавить("ObjectModule.bsl");
	
	Имена.Добавить("Help");
	Имена.Добавить("Help.xml");
	Имена.Добавить("ru.html");
	
	Имена.Добавить("CommandModule.bsl");
	Имена.Добавить("Flowchart.xml");
	Имена.Добавить("Template.bin");
	Имена.Добавить("Picture.xml");
	Имена.Добавить("Picture");
	Имена.Добавить("Picture.png");
	Имена.Добавить("Picture.gif");
	Имена.Добавить("Picture.bmp");
	Имена.Добавить("Picture.jpg");
	Имена.Добавить("Picture.ico");
	Имена.Добавить("ValuesPicture.png");
	Имена.Добавить("ValuesPicture.bmp");
	Имена.Добавить("ValueManagerModule.bsl");
	Имена.Добавить("Template.xml");
	Имена.Добавить("Template.txt");
	
	Имена.Добавить("Package.bin");
	
	// Configuration.xml
	Имена.Добавить("Splash.xml");
	Имена.Добавить("Splash");
	Имена.Добавить("MainSectionPicture.xml");
	Имена.Добавить("MainSectionPicture");
	Имена.Добавить("Logo.xml");
	Имена.Добавить("Logo");
	Имена.Добавить("ParentConfigurations");
	Имена.Добавить("ParentConfigurations.bin");
	Имена.Добавить("ExternalConnectionModule.bsl");
	Имена.Добавить("ManagedApplicationModule.bsl");
	Имена.Добавить("OrdinaryApplicationModule.bsl");
	Имена.Добавить("SessionModule.bsl");
	Имена.Добавить("ClientApplicationInterface.xml");
	Имена.Добавить("CommandInterface.xml");
	Имена.Добавить("MainSectionCommandInterface.xml");
	Имена.Добавить("StartPageWorkingArea.xml");
	
	Имена.Добавить("Items");
	
	Возврат Имена;
	
КонецФункции

// Проверяет что наименование метаданного квалифицированное
// 
// Параметры:
// 	Наименование - Строка - Наименование метаданного
// Возвращаемое значение:
// 	Булево
Функция ЭтоКвалифицированноеИмяМетаданных(Наименование) Экспорт

	КвалифицированныеИмена = ОбщегоНазначенияПовтИсп.КвалифицированныеИменаМетаданных();
	
	Возврат КвалифицированныеИмена.Найти(Наименование) <> Неопределено;

КонецФункции 
 
// Возвращает список квалифицированных имен дочерних объектов
// 
// Возвращаемое значение:
// 	Соответствие - Соответствие имен каталогов и имен дочерних объектов в xml-файле
Функция КвалифицированныеИменаДочернихОбъектов() Экспорт
	
	Имена = Новый Соответствие;
	Имена.Вставить("Commands", "commands");
	Имена.Вставить("Forms", "forms");
	Имена.Вставить("Templates", "templates");

	Возврат Имена;
	
КонецФункции


// Возвращает соответствие русских имен каталогам выгрузки
// 
// Параметры:
// Возвращаемое значение:
// 	Структура
Функция СоответствиеРускихИменКаталогам() Экспорт
	
	Соответствие = Новый Соответствие();
	
	Соответствие.Вставить("РегистрБухгалтерии", "AccountingRegisters");
	Соответствие.Вставить("РегистрНакопления", "AccumulationRegisters");
	Соответствие.Вставить("БизнесПроцесс", "BusinessProcesses");
	Соответствие.Вставить("РегистрРасчета", "CalculationRegisters");
	Соответствие.Вставить("Справочник", "Catalogs");
	Соответствие.Вставить("ПланСчетов", "ChartsOfAccounts");
	Соответствие.Вставить("ПланВидовРасчета", "ChartsOfCalculationTypes");
	Соответствие.Вставить("ПланВидовХарактеристик", "ChartsOfCharacteristicTypes");
	Соответствие.Вставить("ОбщаяГруппа", "CommandGroups");
	Соответствие.Вставить("ОбщийРеквизит", "CommonAttributes");
	Соответствие.Вставить("ОбщаяКоманда", "CommonCommands");
	Соответствие.Вставить("ОбщаяФорма", "CommonForms");
	Соответствие.Вставить("ОбщийМодуль", "CommonModules");
	Соответствие.Вставить("ОбщаяКартинка", "CommonPictures");
	Соответствие.Вставить("ОбщийМакет", "CommonTemplates");
	Соответствие.Вставить("Константа", "Constants");
	Соответствие.Вставить("Обработка", "DataProcessors");
	Соответствие.Вставить("ОпределяемыйТип", "DefinedTypes");
	Соответствие.Вставить("ЖурналДокументов", "DocumentJournals");
	Соответствие.Вставить("Нумератор", "DocumentNumerators");
	Соответствие.Вставить("Документ", "Documents");
	Соответствие.Вставить("Перечисление", "Enums");
	Соответствие.Вставить("ПодпискаНаСобытие", "EventSubscriptions");
	Соответствие.Вставить("ПланОбмена", "ExchangePlans");
	Соответствие.Вставить("ВнешнийИсточник", "ExternalDataSources");
	Соответствие.Вставить("КритерийОтбора", "FilterCriteria");
	Соответствие.Вставить("ФункциональнаяОпция", "FunctionalOptions");
	Соответствие.Вставить("ПарамертФункциональыхОпций", "FunctionalOptionsParameters");
	Соответствие.Вставить("HTTPСервис", "HTTPServices");
	Соответствие.Вставить("РегистрСведений", "InformationRegisters");
	Соответствие.Вставить("Язык", "Languages");
	Соответствие.Вставить("Отчет", "Reports");
	Соответствие.Вставить("Роль", "Roles");
	Соответствие.Вставить("РегламентноеЗадание", "ScheduledJobs");
	Соответствие.Вставить("Последовательность", "Sequences");
	Соответствие.Вставить("ПарамертСеанса", "SessionParameters");
	Соответствие.Вставить("ХранилищеНастроек", "SettingsStorages");
	Соответствие.Вставить("ЭлементСтиля", "StyleItems");
	Соответствие.Вставить("Подсистема", "Subsystems");
	Соответствие.Вставить("Задача", "Tasks");
	Соответствие.Вставить("WebСервис", "WebServices");
	Соответствие.Вставить("XDTOПакет", "XDTOPackages");
	
	Возврат Соответствие
	
КонецФункции

// Возвращает имя каталога выгрузки
// 
// Параметры:
// 	РусскийТипМетаданных - Строка - Русский тип метаданных в единственном числе
// Возвращаемое значение:
// 	Строка
Функция ИмяКаталогаТипаМетаданных(РусскийТипМетаданных) Экспорт
	
	Соответствие = ОбщегоНазначенияПовтИсп.СоответствиеРускихИменКаталогам();
	
	Возврат Соответствие.Получить(РусскийТипМетаданных);
	
КонецФункции


// Определяет, является ли сервер на ОС Windows или другие (macOS, Linux).
// 
// Возвращаемое значение:
// 	Булево - Описание
Функция ЭтоWindowsСервер() Экспорт
	СистемнаяИнформация = Новый СистемнаяИнформация;
	Возврат (СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86
		Или СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86_64);
КонецФункции

#КонецОбласти