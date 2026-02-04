import sys
import os
import shutil
import random

from gradio_client import Client, handle_file

# client = Client("http://172.16.111.10:7860")
client = Client("http://10.15.10.1:7860")

def main():
    if len(sys.argv) != 3:
        print("Fehler: Zwei Argumente 'Dateiname' und 'Text' benötigt.")
        sys.exit(1)

    file_name = sys.argv[1]
    text = sys.argv[2]

    # Zielordner
    target_folder = '../TTS'
    file_name = os.path.splitext(file_name)[0]

    #test ob bereits eine id existiert
    if os.path.exists(os.path.join(target_folder, f"{file_name}.seed")):
        with open(os.path.join(target_folder, f"{file_name}.seed"), 'r') as seed_file:
            # ID aus der Datei lesen
            seed = int(seed_file.read().strip())
        print("Seed-Datei existiert bereits: ", seed)

    else:
        # ID erzeugen
        seed = random.randint(1, 999999)
        # ID-Datei erstellen
        with open(os.path.join(target_folder, f"{file_name}.seed"), 'w') as seed_file:
            seed_file.write(str(seed))
        print("Benutze neuen Seed: ", seed)

    # TTS-Anfrage an den Server senden
    result = client.predict(
      text=f"{text}",
      reference_id="",
      # reference_audio=None,
      reference_audio=handle_file('../../Video/Sprachsample.wav'),
      reference_text="Hier ist ein gesprochener Text zum Testen. Zwei Komma Fünf Vier Sechs Kilovoltampere mal E hoch J Einhundertneunundachzig Komma Neun Acht Neun Grad.",
      max_new_tokens=0,
      chunk_length=400,
      top_p=0.8,
      repetition_penalty=1.18,
      temperature=0.92,
      seed=f"{seed}",
      use_memory_cache="on",
      api_name="/partial"
    )
    print(result)

    # result als String umwandeln und den Pfad extrahieren
    actual_path = eval(str(result))[0]

    # Zielpfad erstellen
    target_path = os.path.join(target_folder, f"{file_name}.wav")

    # Datei verschieben und umbenennen
    shutil.move(actual_path, target_path)

    print("TTS-Audio erstellt:", target_path)

if __name__ == "__main__":
    main()