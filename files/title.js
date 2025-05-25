const text_element = document.querySelector('.type');
const phrases = [
  "What are you waiting for? Join today.",
  "Take the winning edge in every HVH.",
  "Cleanest visuals?",
  "Dominate with the best cheat on the market."
];

const typing_speed = 100;
const deleting_speed = 50;
const pause_after_typing = 3000;

let phrase_index = 0;
let char_index = 0;
let is_deleting = false;

function type_phrases() {
  const current_phrase = phrases[phrase_index];

  if (!is_deleting) {
    text_element.textContent = current_phrase.substring(0, char_index + 1) || ".";
    char_index++;
    if (char_index === current_phrase.length) {
      setTimeout(() => {
        is_deleting = true;
        type_phrases();
      }, pause_after_typing);
      return;
    }
  } else {
    text_element.textContent = current_phrase.substring(0, char_index) || ".";
    char_index--;
    if (char_index < 0) {
      is_deleting = false;
      phrase_index = (phrase_index + 1) % phrases.length;
    }
  }

  setTimeout(type_phrases, is_deleting ? deleting_speed : typing_speed);
}

type_phrases();
