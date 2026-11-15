# Storage и modules

```lua
local count = aether.storage.get("count") or 0
aether.storage.set("count", count + 1)
aether.storage.remove("count")
```

Данные атомарно сохраняются в `%TEMP%\aether\lua\data\<script-id>\store.json`:
до 1024 ключей и 1 MiB всего; `set` возвращает `false`, если значение не помещается.

`require` ищет `.lua`-модули сначала в директории активного пакета, затем в общей
`lua/modules`. Это позволяет нескольким скриптам использовать общие модули без
копирования исходников.
