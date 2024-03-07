Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F8BC54E55
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAt5-0005yt-OV; Thu, 07 Mar 2024 05:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAst-0005af-2M
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:55 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsr-0007FU-9i
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:54 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c1ea425a0fso269108b6e.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806912; x=1710411712;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CotLFv3JVXm6i3Wu/BAcc+rvRVqdPlzG06TuPB40/EU=;
 b=dcXDxpwZ8sdP9roQ6GExJHSgODK2bFHSmN9sm6P2DvnaLIKTn72yBeTai02WXivKoH
 iw6oF8Oftf9BAi6QvU7QX9k6IuuvGpNwD5VkQO8WZ2VkMjSUBbiSDyR8/GoDseTuMdfh
 6rM19mgjknvH487tRSPQNpFeHpq3a4mKA1l4sfNvwWhFdFjmAaW2X/9QgIGQibszUi4y
 I92M/28CI5qAJUmf3bgugMlsNOytlgQM9tJwX26lzBFzWVapuY2yZZEfrZ3Jk3RRiJgN
 Dng06oTE4Yv/Ejoxyp6mvdTzU7nhlgIaG5ioWdxjkAARClu4MSfx1I97xL5sFtvyERMV
 lEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806912; x=1710411712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CotLFv3JVXm6i3Wu/BAcc+rvRVqdPlzG06TuPB40/EU=;
 b=F4Qxt9hLH4qIa1iH++uN/E6SW/jqNCc7DDaJSre1lSNiqd+cUj/ud7+e1gJRHwAGXh
 4s/zDjlal7avD/1vbZMsjt6Ak1388NqOg5uJe6au3+Rju7ILfHpRyf1U+kL48JkZ7G0q
 eWu4ORQRjd8J8du2Mt8kfSyccG40RhhXr03VwFb6VuDwzIe/SA3Or4z+UFtkm+afBnMr
 hSMNlhEZYb6vPpmg4ZqJxr/JSjnwZYMdGXGzzK8UoIlpXJQVX2l9MKZN7KTxkV4F5GGd
 gDFA3OoBbkMbeHOwzV6AXJ7/RTCyrWhVGfBdqWd7WvZpuQuyLLa4MjaWER9i669vhYpB
 VWzw==
X-Gm-Message-State: AOJu0YzVra74DaU062e0bgqjV/y1aDnlmiXSeKN87bLlKRlVAdUdq/RY
 Cff8WZLA1blVOzU2yJsWor+bGKfkONbRjC20F0lP7r/zA5L57cThp7BJewQQxAY=
X-Google-Smtp-Source: AGHT+IGtJKL80c09SGBnAxxBqv+OCOF4NcVIHEXz2vfqvUZJBiWWkOvD4GEcxOZD0oYjjjrLVel26g==
X-Received: by 2002:a05:6808:6297:b0:3c2:154f:7716 with SMTP id
 du23-20020a056808629700b003c2154f7716mr5593304oib.43.1709806911935; 
 Thu, 07 Mar 2024 02:21:51 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 z4-20020a626504000000b006e621fd613fsm7032514pfb.80.2024.03.07.02.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:51 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:21:01 +0900
Subject: [PATCH v4 18/19] contrib/elf2dmp: Clamp QEMU note to file size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-18-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This fixes crashes with truncated dumps.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 87 +++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 7d896cac5b15..8d750adf904a 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 #include "err.h"
 #include "qemu_elf.h"
 
@@ -15,36 +16,11 @@
 #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
 #endif
 
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#endif
-
-#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
-    ((DIV_ROUND_UP((hdr_size), 4) +                     \
-      DIV_ROUND_UP((name_size), 4) +                    \
-      DIV_ROUND_UP((desc_size), 4)) * 4)
-
 int is_system(QEMUCPUState *s)
 {
     return s->gs.base >> 63;
 }
 
-static char *nhdr_get_name(Elf64_Nhdr *nhdr)
-{
-    return (char *)nhdr + ROUND_UP(sizeof(*nhdr), 4);
-}
-
-static void *nhdr_get_desc(Elf64_Nhdr *nhdr)
-{
-    return nhdr_get_name(nhdr) + ROUND_UP(nhdr->n_namesz, 4);
-}
-
-static Elf64_Nhdr *nhdr_get_next(Elf64_Nhdr *nhdr)
-{
-    return (void *)((uint8_t *)nhdr + ELF_NOTE_SIZE(sizeof(*nhdr),
-                nhdr->n_namesz, nhdr->n_descsz));
-}
-
 Elf64_Phdr *elf64_getphdr(void *map)
 {
     Elf64_Ehdr *ehdr = map;
@@ -60,13 +36,35 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
+static bool advance_note_offset(uint64_t *offsetp, uint64_t size, uint64_t end)
+{
+    uint64_t offset = *offsetp;
+
+    if (uadd64_overflow(offset, size, &offset) || offset > UINT64_MAX - 3) {
+        return false;
+    }
+
+    offset = ROUND_UP(offset, 4);
+
+    if (offset > end) {
+        return false;
+    }
+
+    *offsetp = offset;
+
+    return true;
+}
+
 static bool init_states(QEMU_Elf *qe)
 {
     Elf64_Phdr *phdr = elf64_getphdr(qe->map);
-    Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
-    Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
     GPtrArray *states;
+    QEMUCPUState *state;
+    uint32_t state_size;
+    uint64_t offset;
+    uint64_t end_offset;
+    char *name;
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
@@ -74,15 +72,40 @@ static bool init_states(QEMU_Elf *qe)
     }
 
     qe->has_kernel_gs_base = 1;
+    offset = phdr[0].p_offset;
     states = g_ptr_array_new();
 
-    for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
-        if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
-            QEMUCPUState *state = nhdr_get_desc(nhdr);
+    if (uadd64_overflow(offset, phdr[0].p_memsz, &end_offset) ||
+        end_offset > qe->size) {
+        end_offset = qe->size;
+    }
+
+    while (offset < end_offset) {
+        nhdr = (void *)((uint8_t *)qe->map + offset);
+
+        if (!advance_note_offset(&offset, sizeof(*nhdr), end_offset)) {
+            break;
+        }
+
+        name = (char *)qe->map + offset;
+
+        if (!advance_note_offset(&offset, nhdr->n_namesz, end_offset)) {
+            break;
+        }
+
+        state = (void *)((uint8_t *)qe->map + offset);
+
+        if (!advance_note_offset(&offset, nhdr->n_descsz, end_offset)) {
+            break;
+        }
+
+        if (!strcmp(name, QEMU_NOTE_NAME) &&
+            nhdr->n_descsz >= offsetof(QEMUCPUState, kernel_gs_base)) {
+            state_size = MIN(state->size, nhdr->n_descsz);
 
-            if (state->size < sizeof(*state)) {
+            if (state_size < sizeof(*state)) {
                 eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
-                        states->len, state->size);
+                        states->len, state_size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.

-- 
2.44.0


