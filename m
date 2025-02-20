Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ECFC021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JW-0007dJ-TH; Thu, 20 Feb 2025 11:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JS-0007Gb-Gr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JP-0008Gk-VD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:10 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so7312205e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068526; x=1740673326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wp5Qs2TjtzN+wRGb5VWWL9lxD3Vw4BtjioUP8AQ6IrI=;
 b=B3aKAAojRI3MtUuLX3VUldixXiVqweBbtRwQing8EGrlvgy+PhEQ75XL7vFy92vvjd
 Y6PzG2Kq0SQmLu4MAUvSskdR4ZYCfZrbUTQu5ui+CbBaLQbCE+I3c5NirXoWnyE4Peim
 VmYbr7o6dMs4DiQeTOr/KlryE/Qhx2YyGOhN1T+zG3TlH0QSAfulgIKMNNlhcta6kCuy
 jM2rpDTtnI4GHtzZcgCgfqq9/bgrJHw47F84CAvu3lPJRRE+nI+o/KURPpjE8MI4Ujv0
 gB9KZ7G9SkrJKYv5bJRQEJz8WjB9u6a6yDsYZ6wHIkCbZti888Ycrli9xVAKo7RCtWQK
 Rzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068526; x=1740673326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wp5Qs2TjtzN+wRGb5VWWL9lxD3Vw4BtjioUP8AQ6IrI=;
 b=pr+b8EmKvrVCNuDPtmnRd6NK5lxdLShjLN0txF6A00+HSuZF5xIbxx8Ssu0W7SKjnE
 W79sDNPRylz2gmrtFxxK9qiWubD3gZ6Bry4hrQ2YcyVZOzrkEN/QNiIVoAXW65YWApah
 gcHVDPVnNUunc32NDvVHs2HKDQls9BlQ6+kVL1tgzI1XGGAh9jUSrveyxNec584hgaO9
 u1PPtBspAXrfLKiiKqwjPPDvjaefsG/ga2J2OSjOx33H60+Vu9SeFb3hUJMv8w1pPxEg
 W6GLQtRPny4HmYHJfmpvpABa0puWQ1EUSMKut2ln+kIKwq5UWYJO2pmqJvGvbi3QHrCf
 3aDA==
X-Gm-Message-State: AOJu0YwArufx0FtyWDcBEWS1QoJkZSekRiRfBXnIA1SV8mV5Fbvv6B9C
 OPxNTr10uVBtojUkIT6/oEq5z7ChwC0q7Tr9rrx4v969ha4bWrwumcFLOTlGpCdgoI7ItVHzwuO
 z
X-Gm-Gg: ASbGncuAYEBu282CGBz7h2+h/5dQM82luvhF/6FleSnywlkqg3fJ/TRmslX9vhlyVMo
 DFXeWLZBggxzf9YsMgJtHgGSXhNapEh49yobOrA3fWRi+tjG1gDuQnGqfJnHmpLE8jvMtEuf2iT
 KdC/1E8dL69HRRvO8IfhXfCQb+nkKItk17tWKitjNcecLrc9JJUgthgju5lXE4FvfKBMl/WL0d9
 50v6mVSP1DOfIlpjXywPhzHSnF1WzVLnWOeIcrf9b/kXH4z+kk/U9BV4NxjmAkfDg5qhqjzoPxH
 Cahkmmz7lRrYp53fN+rWbw==
X-Google-Smtp-Source: AGHT+IEg1sz8Ixwh8bRN7JmYu7V+BXk+0APU4rplUlBNmt8cwbeSZGZX+iYwcSZKf0s4cZrajWXoTQ==
X-Received: by 2002:a05:600c:3b8e:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-439a30d389fmr30916565e9.12.1740068526514; 
 Thu, 20 Feb 2025 08:22:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] hw/misc: Support 8-bytes memop in NPCM GCR module
Date: Thu, 20 Feb 2025 16:21:14 +0000
Message-ID: <20250220162123.626941-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hao Wu <wuhaotsh@google.com>

The NPCM8xx GCR device can be accessed with 64-bit memory operations.
This patch supports that.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Message-id: 20250219184609.1839281-10-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/npcm_gcr.c   | 92 ++++++++++++++++++++++++++++++++++----------
 hw/misc/trace-events |  4 +-
 2 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 9e4a6aee611..ec16ea620eb 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -200,6 +200,7 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
     NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
+    uint64_t value;
 
     if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -208,9 +209,21 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
     }
 
-    trace_npcm_gcr_read(offset, s->regs[reg]);
+    switch (size) {
+    case 4:
+        value = s->regs[reg];
+        break;
 
-    return s->regs[reg];
+    case 8:
+        value = deposit64(s->regs[reg], 32, 32, s->regs[reg + 1]);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    trace_npcm_gcr_read(offset, value);
+    return value;
 }
 
 static void npcm_gcr_write(void *opaque, hwaddr offset,
@@ -230,29 +243,65 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
         return;
     }
 
-    switch (reg) {
-    case NPCM7XX_GCR_PDID:
-    case NPCM7XX_GCR_PWRON:
-    case NPCM7XX_GCR_INTSR:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
-                      __func__, offset);
-        return;
+    switch (size) {
+    case 4:
+        switch (reg) {
+        case NPCM7XX_GCR_PDID:
+        case NPCM7XX_GCR_PWRON:
+        case NPCM7XX_GCR_INTSR:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: register @ 0x%04" HWADDR_PRIx " is read-only\n",
+                          __func__, offset);
+            return;
 
-    case NPCM7XX_GCR_RESSR:
-    case NPCM7XX_GCR_CP2BST:
-        /* Write 1 to clear */
-        value = s->regs[reg] & ~value;
+        case NPCM7XX_GCR_RESSR:
+        case NPCM7XX_GCR_CP2BST:
+            /* Write 1 to clear */
+            value = s->regs[reg] & ~value;
+            break;
+
+        case NPCM7XX_GCR_RLOCKR1:
+        case NPCM7XX_GCR_MDLR:
+            /* Write 1 to set */
+            value |= s->regs[reg];
+            break;
+        };
+        s->regs[reg] = value;
         break;
 
-    case NPCM7XX_GCR_RLOCKR1:
-    case NPCM7XX_GCR_MDLR:
-        /* Write 1 to set */
-        value |= s->regs[reg];
+    case 8:
+        s->regs[reg] = value;
+        s->regs[reg + 1] = extract64(v, 32, 32);
         break;
-    };
 
-    s->regs[reg] = value;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool npcm_gcr_check_mem_op(void *opaque, hwaddr offset,
+                                  unsigned size, bool is_write,
+                                  MemTxAttrs attrs)
+{
+    NPCMGCRClass *c = NPCM_GCR_GET_CLASS(opaque);
+
+    if (offset >= c->nr_regs * sizeof(uint32_t)) {
+        return false;
+    }
+
+    switch (size) {
+    case 4:
+        return true;
+    case 8:
+        if (offset >= NPCM8XX_GCR_SCRPAD_00 * sizeof(uint32_t) &&
+            offset < (NPCM8XX_GCR_NR_REGS - 1) * sizeof(uint32_t)) {
+            return true;
+        } else {
+            return false;
+        }
+    default:
+        return false;
+    }
 }
 
 static const struct MemoryRegionOps npcm_gcr_ops = {
@@ -261,7 +310,8 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid      = {
         .min_access_size        = 4,
-        .max_access_size        = 4,
+        .max_access_size        = 8,
+        .accepts                = npcm_gcr_check_mem_op,
         .unaligned              = false,
     },
 };
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0f7204a237e..f25dbd6030c 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -135,8 +135,8 @@ npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " valu
 npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
 # npcm_gcr.c
-npcm_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
-npcm_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm_gcr_read(uint64_t offset, uint64_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx64
+npcm_gcr_write(uint64_t offset, uint64_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx64
 
 # npcm7xx_mft.c
 npcm7xx_mft_read(const char *name, uint64_t offset, uint16_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.43.0


