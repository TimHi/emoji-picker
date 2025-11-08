<script setup lang="ts">
import data from "unicode-emoji-json";
import type {
  EmojiDictionary,
  SingleEmoji,
} from "./model/EmojiData.ts";
import useClipboard from "vue-clipboard3";
import { useToast } from "primevue";

import Emoji from "./components/Emoji.vue";
import { ref } from "vue";

const { toClipboard } = useClipboard();
const toast = useToast();

const emojiData: EmojiDictionary = data;
const fullData: SingleEmoji[] = Object.entries(emojiData).map(
  ([emoji, data]) => ({
    emoji,
    data,
  }),
);
const displayedData = ref(fullData);

function filterValue(filterInput: string | undefined) {
  if (!filterInput) {
    displayedData.value = fullData; // Return empty array if no input
    return;
  }
  displayedData.value = Object.entries(emojiData)
    .filter(([_, data]) =>
      data.name.toLowerCase().includes(filterInput.toLowerCase()),
    )
    .map(([emoji, data]) => ({ emoji, data }));
}
</script>

<template>
  <Toast />
  <div class="flex flex-col items-center justify-center p-6">
    <div class="flex flex-row gap-4">
      <p class="text-4xl">🚀</p>
      <p class="text-4xl">Choose from {{ displayedData.length }} Emoji's</p>
      <p class="text-4xl">🍺</p>
    </div>
    <p class="text-xl font-thin">Click Emoji to Copy</p>
    <p class="text-xs font-thin">
      Powered by
      <a
        class="text-purple-500"
        href="https://github.com/muan/unicode-emoji-json"
        >unicode-emoji-json</a
      >
    </p>
    <InputText
      :pt="{
        root: 'm-4',
      }"
      @update:modelValue="filterValue"
      placeholder="Search Emoji"
    />
  </div>
  <div class="flex flex-row flex-wrap gap-8">
    <div v-for="emoji in displayedData" :key="emoji.data.name" class="flex">
      <Emoji
        :emojiImage="emoji.emoji"
        :emoji="emoji.data"
        @click="
          () => {
            toClipboard(emoji.emoji);
            toast.add({
              severity: 'success',
              summary: `${emoji.emoji} Copied!`,
              detail: 'Go Nuts!',
              life: 1500,
            });
          }
        "
      />
    </div>
  </div>
</template>

<style scoped></style>
