-- mod-temucraft-camping: player-facing texts. Translations go in module_string_locale (same module and id, plus the locale).
DELETE FROM `module_string` WHERE `module` = 'mod-temucraft-camping';
INSERT INTO `module_string` (`module`, `id`, `string`) VALUES
('mod-temucraft-camping', 1, '|cffffcc00{}|r');
