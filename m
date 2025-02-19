Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EFDC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 18:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkp6S-0003QO-7z; Wed, 19 Feb 2025 13:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Die2ZwgKCnktreXlqpedlldib.Zljnbjr-absbiklkdkr.lod@flex--wuhaotsh.bounces.google.com>)
 id 1tkp60-00036i-Ja
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:58 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Die2ZwgKCnktreXlqpedlldib.Zljnbjr-absbiklkdkr.lod@flex--wuhaotsh.bounces.google.com>)
 id 1tkp5v-0004lL-5E
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 13:46:53 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc1eadf5a8so209835a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739990799; x=1740595599; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GqpC+ChE3b3k6NV87QipBm1Iuw1OmkAIH0r3j7SWBcI=;
 b=TAVjRMTImqNv+wpt2lezr3YwaI+bQQdHQQiiQXdRIMaZy3xarqyd7d7lPvpfCKP8cY
 y3lO40eTfsrFluuPndZvToDdKXvtjlswwjBv0IIpztPrpTG0qQC3LVa8o5/Nxj+oiiNV
 mSkRAlSCBA12HxJ3bfLaIUQ+nQD3b4UTecCBLBZa4EPsdtwFgyvPefq5uJ0Hh/39qvJ7
 fhsROXA/c3voA8qbePAwgKX9XsVR4bq+KukCKU66VyUSvsb8J/Al4Ygc9Olt+V8eihHk
 5oXVqWfan2nuzQbdr5ka26yext6ce+JR1CbY+i7gp2yA9l7sC0VpoD505B6tYRQjNbeS
 APIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990799; x=1740595599;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GqpC+ChE3b3k6NV87QipBm1Iuw1OmkAIH0r3j7SWBcI=;
 b=DWczzY/xSOCvoyb6kbQrb5ukv2LpXgbYnny15c0ND/FUoJg+JuUJJvCkw+p87VpCTl
 b/sARToESNDbsKy5BRCMVGlR0kXu9elqPcNix7Nb5+kqT4UAtFrG5Xj+s9M09q/YmaZm
 YgtiK9v58R2YaAk159raz5GH6nSYLTE0mArf9zy4vXJqgeT/XAaonA5BinHkTNiP269L
 EFo6SpsYGjKRhKFl3lVHSf3pmTLB+i9IXAUHS8QMQ2KRsBJf/uSEBZ6guk1xbgB7nxWZ
 ewk8HBRTeNqddQkhE9te/MgAMScvNvyRVS9WrFMcQbbVR929ThymAbFCssvkrsSwnEcf
 tJAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+iErRVhrURJTeU8O99yBUxiosYW3RqaxaHuWUJbu/mbhyjzsv4eSbw6c3Lr2utVvz3fUwg6rzSsrY@nongnu.org
X-Gm-Message-State: AOJu0YylA4cGZRX0AgOua63IfbFAhJ3JDUDy8F0fcMznGVP9CGRSdLlq
 Vpp3twb/nDS0nC1AZBgFU0q6AjU+4qRZRVY5mseQtAcfqjOYrGUt2EfwtwlVYu4CI0Ws3p3FkeM
 4SSoeHAtc4g==
X-Google-Smtp-Source: AGHT+IEpyF3PTi+wj9PwUI884qwRjfUrHZBuFGOdtQP8Cf3nopH6VunU4nHG0U0mseXknP7CtWRQJ5jFKXxtNw==
X-Received: from pjbsw6.prod.google.com ([2002:a17:90b:2c86:b0:2fa:24c5:36e])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2252:b0:2fa:20f4:d27c with SMTP id
 98e67ed59e1d1-2fcb5aba774mr6195508a91.34.1739990798909; 
 Wed, 19 Feb 2025 10:46:38 -0800 (PST)
Date: Wed, 19 Feb 2025 10:46:00 -0800
In-Reply-To: <20250219184609.1839281-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219184609.1839281-10-wuhaotsh@google.com>
Subject: [PATCH v5 09/17] hw/misc: Support 8-bytes memop in NPCM GCR module
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3Die2ZwgKCnktreXlqpedlldib.Zljnbjr-absbiklkdkr.lod@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

The NPCM8xx GCR device can be accessed with 64-bit memory operations.
This patch supports that.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
---
 hw/misc/npcm_gcr.c   | 94 +++++++++++++++++++++++++++++++++-----------
 hw/misc/trace-events |  4 +-
 2 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 9e4a6aee61..ec16ea620e 100644
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
+
+    case 8:
+        value = deposit64(s->regs[reg], 32, 32, s->regs[reg + 1]);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
 
-    return s->regs[reg];
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
-
-    case NPCM7XX_GCR_RESSR:
-    case NPCM7XX_GCR_CP2BST:
-        /* Write 1 to clear */
-        value = s->regs[reg] & ~value;
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
+
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
index 0f7204a237..f25dbd6030 100644
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
2.48.1.601.g30ceb7b040-goog


