<script setup lang="ts">
import type { EmojiData } from "../model/EmojiData.ts";
defineProps<{
  emojiImage: string;
  emoji: EmojiData;
}>();
</script>

<template>
  <Card
    :pt="{
      root: 'min-w-32 max-w-32 flex items-center flex-nowrap cursor-pointer',
    }"
  >
    <template #header>
      <p
        v-tooltip.bottom="emoji.name"
        class="text-sm font-thin w-28 overflow-hidden text-ellipsis whitespace-nowrap items-center"
      >
        {{ emoji.name }}
      </p>
    </template>
    <template #content>
      <p class="text-4xl items-center">
        {{ emojiImage }}
      </p>
    </template>
  </Card>
</template>

<style scoped></style>
