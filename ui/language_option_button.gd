class_name LanguageOptionButton extends OptionButton

const LANGUAGES: Array = [
    ["en", "English"],
    ["es", "Español"],
]

func _ready():
    for i in LANGUAGES.size():
        var language_display_name: String = LANGUAGES[i][1]
        add_item(language_display_name, i)

func _on_item_selected(index: int):
    var language_code = LANGUAGES[index][0]
    print(language_code)
    TranslationServer.set_locale(language_code)
