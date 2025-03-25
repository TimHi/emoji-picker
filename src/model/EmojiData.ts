export interface EmojiData {
  name: string;
  slug: string;
  group: string;
  emoji_version: string;
  unicode_version: string;
  skin_tone_support: boolean;
}

export interface EmojiDictionary {
  [emoji: string]: EmojiData;
}
export interface SingleEmoji {
  emoji: string;
  data: EmojiData;
}
