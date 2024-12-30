const fs = require('fs');
const { Readable } = require('stream');

// Daftar kata yang akan digunakan
const kataKata = [
  'kucing',
  'anjing',
  'burung',
  'panda',
  'penguin',
  'flamingo',
  'bunglon',
  'gajah',
  'harimau',
  'jerapah',
  'kangguru',
  'koala',
  'komodo',
  'lumba-lumba',
  'orang Utan',
  'paus',
  'rusa',
  'ular',
  'zebra',
];

// URL dasar Google Translate TTS
const url = 'https://translate.google.com/translate_tts?tl=id&q={}&client=tw-ob';

// Looping daftar kata dan mengakses Google Translate TTS
kataKata.forEach((kata) => {
  const fullUrl = url.replace('{}', kata);
  fetch(fullUrl)
    .then((response) => {
      if (response.ok) {
        console.log(`Berhasil mengakses ${kata}`);

        // Simpan hasil ke file MP3
        const filename = `${kata}.mp3`;
        const fileStream = fs.createWriteStream(filename);
        const readableStream = new Readable({
          read() {
            response.arrayBuffer().then((arrayBuffer) => {
              this.push(Buffer.from(arrayBuffer));
              this.push(null);
            });
          },
        });
        readableStream.pipe(fileStream);
        fileStream.on('finish', () => {
          console.log(`Berhasil menyimpan ${kata} ke file ${filename}`);
        });
      } else {
        console.log(`Gagal mengakses ${kata}`);
      }
    })
    .catch((error) => {
      console.error(error);
    });
});