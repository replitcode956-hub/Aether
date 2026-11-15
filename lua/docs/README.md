# Aether Lua API 1.0

Lua API позволяет локальным скриптам читать уже опубликованное состояние Aether,
добавлять настройки и overlay-графику, менять конфигурацию и использовать внешний
input gateway. Скрипты не получают адреса CS2 и не создают дополнительные циклы
чтения памяти.

## Установка

При первом запуске создаётся `%TEMP%\aether\lua`:

```text
lua/
  scripts/     -- одиночные .lua или пакеты
  modules/     -- общие Lua-модули, только исходники .lua
  data/        -- private JSON storage скриптов
  logs/
```

Скрипты управляются в `Misc -> Lua API`: список с включением, настройками,
перезагрузкой и удалением (в корзину), кнопки импорта `.lua` и открытия папки
`scripts`. Импорт атомарно копирует файл и сразу обновляет runtime.

## Песочница

Каждый скрипт работает в песочнице и видит только API Aether и безопасную часть
стандартной библиотеки:

- `base` без `dofile` и `loadfile`; `load` принимает только текст (байткод отклоняется);
- `string` без `dump`, `table`, `math`, `utf8`, `coroutine`;
- `os` только с `clock`, `time`, `date`, `difftime`;
- `require` загружает `.lua` только из папки самого скрипта и из общей `lua/modules`;
- `setmetatable` не принимает финализаторы (`__gc`);
- нет `io`, `package`, `debug` и `aether.helpers`.

Данные скрипт хранит через `aether.storage`. Единственное исключение —
встроенный веб-радар (`lua/scripts/Aether Web Radar.lua` из репозитория): Aether
узнаёт его по SHA-256 текста (CRLF приводится к LF), вшитому в сборку, и только
ему даёт полный доступ (`io`, `os`, запуск своего PowerShell-помощника). Любое
изменение файла радара требует новой сборки Aether, иначе он работает в песочнице.

## Минимальный пример

```lua
aether.ui.toggle("enabled", "Player counter", true)

aether.events.on("frame", function(frame)
    if not aether.ui.get("enabled") then return end
    aether.draw.text(30, 90, "Players: " .. #frame.players, 255, 255, 255, 255)
end)
```

См. [lifecycle](runtime-and-lifecycle.md), [game snapshot](game-snapshot.md),
[events](events.md), [config](config.md), [UI/draw](ui-and-drawing.md),
[input](input.md), [storage/modules](storage-and-helpers.md),
[проверка runtime](testing.md), [пример Web Radar](examples/web-radar.md) и
[полный reference](api-reference.md).
