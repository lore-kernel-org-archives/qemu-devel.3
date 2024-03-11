Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC45DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl6d-0004f1-DH; Mon, 11 Mar 2024 15:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl53-0003PG-1d
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4w-0000Nj-Bg
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4132cbe26a9so6186415e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184371; x=1710789171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sD6QWErgcpioeXWdrsT2adMymrvCNHI9GMAxmhteL7o=;
 b=y79PSPf6d6Ez0nbCDXw6So2eXrzGAZmyCc3NodLZ9Xwg9lS/Px/vvqqwdweWoOmKnh
 lXdCqtDRzNMWd9rscFmH2zO/bNU5qqaF2PObA7n9v8IUd6RypqHj9rJRaLfIbJbjY5h8
 E7kDb2sfDic2m373CqxLd0836IJgp/r/L/cMo6SFaCRMIzR6nEFpUZVNJp7eSA7nnVNl
 fEdAJ8Gdcwn9MQ9T6PVyHDZwK90B97WmKpVd9HV7WfxTPgMipwWq1ynDr4CuxXUW1Owo
 KpdSlQRF2vxYc1ucFsE6vYbOBya9SdcfLBLdyrxIPmjMb546yJJ1SL+aU4x/VPnBHsY+
 14iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184371; x=1710789171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sD6QWErgcpioeXWdrsT2adMymrvCNHI9GMAxmhteL7o=;
 b=KXgDvH11N31sSniYlR6fMGXDBgKFvhyYcDJwyQxBGVNL3KJF7P73zBuqyDgWdR5NP/
 1lMJ3kAPmzQdiCUz5O+dUtyY41ciZWBtxvDiwN8Ph+PmDLWwd/cOrkd0VE/qmCD7Mb5w
 JIZT/YbCtQcvkf1QIZwXAKbjXyDOm6tu9NT3GAhDLK3BY1JrBk2gEuS3iGjA4+Gnc4y7
 RS8ie778sYuQAU5TOArQfCn55ouk/3Wu+cUE6hgtu6V3+WCjTCkbVR+qyX5p01yC6OZ0
 POKOBID6mwUQc7PeUGU58lIl19nGvXYbPXYYAM9O/6KLgtwhhNQvgnuZK/8DYTAGN06S
 de+w==
X-Gm-Message-State: AOJu0YzvQeleEle1osYDI6lioc4WbPlzZeuFCWD2oNk7N/VETHLdUddE
 PqotU4YU7ArBN3gKQKRG5m9qULwNk/mMfbiAABs/OvdXuxhqg9lMOWbtJieZd6IV4222dF8vdv0
 D
X-Google-Smtp-Source: AGHT+IHdfrOsmDDP5mb1eGF62DCy38bW3TXaKO5KsYJEs3IFuL6WKN1CpkyGY1kKTKYuC2h1Y4AViw==
X-Received: by 2002:a05:600c:3492:b0:413:2bcf:df81 with SMTP id
 a18-20020a05600c349200b004132bcfdf81mr2008103wmq.1.1710184371097; 
 Mon, 11 Mar 2024 12:12:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] contrib/elf2dmp: Clamp QEMU note to file size
Date: Mon, 11 Mar 2024 19:12:39 +0000
Message-Id: <20240311191241.4177990-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This fixes crashes with truncated dumps.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-18-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 87 ++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 7d896cac5b1..8d750adf904 100644
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
 
-            if (state->size < sizeof(*state)) {
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
+
+            if (state_size < sizeof(*state)) {
                 eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
-                        states->len, state->size);
+                        states->len, state_size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.
-- 
2.34.1


