import os

# Mapping alte Basisnamen -> neue Basisnamen
umbenennungen = [
    ("tts-Video-02_Arbeit-1-0", "tts-Video-02_Arbeit1-1-0"),
    ("tts-Video-02_Arbeit-2-0", "tts-Video-02_Arbeit2-1-0"),
    ("tts-Video-02_Arbeit-3-0", "tts-Video-02_Arbeit3-1-0"),
    ("tts-Video-02_Arbeit-4-0", "tts-Video-02_Arbeit4-1-0"),
    ("tts-Video-02_Arbeit-5-0", "tts-Video-02_Arbeit5-1-0"),
]

ordner=r"/workspace/modul-02-energie-und-leistung/TTS"

# Ordner, in dem die Dateien liegen

for alt, neu in umbenennungen:
    for datei in os.listdir(ordner):
        basis, endung = os.path.splitext(datei)
        if basis == alt:
            alter_pfad = os.path.join(ordner, datei)
            neuer_pfad = os.path.join(ordner, neu + endung)
            print(f"{alter_pfad} -> {neuer_pfad}")
            os.rename(alter_pfad, neuer_pfad)
