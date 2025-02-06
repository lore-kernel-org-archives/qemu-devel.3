Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D2C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgA6x-0005tc-5n; Thu, 06 Feb 2025 17:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xjOlZwgKCgc31ohv0zonvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6m-0005hE-4j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:29 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xjOlZwgKCgc31ohv0zonvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--wuhaotsh.bounces.google.com>)
 id 1tgA6i-0001SB-Sh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:12:27 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fa1c093f12so1573292a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1738879942; x=1739484742; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kvE7Ht553KRGIAvaHX5qBB87bcC7M5MR+v6uhs8tY1M=;
 b=sEeRo6RmhzJEzX2uz3hHksh8bAHcFVO9wHaLnSQ0TY0Urvmt7ha0Z035czu9LekgjC
 6Adzpoh5jadPgKB+udTje5t/YLLaEZnPg0D4fEjhcaa5JynXWd7cnQ5WdR57KZVAEoR7
 vL1ZV3fkXIl0F48GBmJrHkxVO8mM18VWEC6vrwpv3fW44jBOc1Ot4x6ct5b9LxRNJWSt
 fLUviikahaeVcdAjmJTETc1IpsVhNWtA4l2BOzXVK0X4Ot9WLdqaEd//RmIEzV0SuSRb
 l9euvHI6RBJg/KMbmLzT/pfH77wLF2Qa5B6HG/uhmDT60DOgepv88KDP72wtr8v1DURP
 go8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738879942; x=1739484742;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvE7Ht553KRGIAvaHX5qBB87bcC7M5MR+v6uhs8tY1M=;
 b=lyHSmLFYwhWIeUaglGQ+/izGC/xOPzsclL4T7DIOXyy7+7+taZciBGHzOzhD1k2umC
 eVuUf308OZU4YyXtMaQ7hTMZzH6UcZr9Hc1CGSpuGMl6uiRS6fBDDrtsFRnRp74BbBBt
 5Vz39KfiLvH419H4+D4yCwB8Uxp6iYD6s5aGRgdgWdPj0QQVRXW7TknuMGZGVK18pDgw
 DMJCbyROVWjhCMQAOD4y2qhBA5s+IBHIUIKjSKmT4gdtFZY/CHZ7yt5AZKZQmknggM35
 ITVXhUJ4ENT9TQ2zExcxWNDov1nzpznFI1ySyuqYsgTGPxW/2S4qn5+6TdjwAkizBNw1
 gU/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1MNacWY5j5wV+yi7uWgDFb2uIu/VL8ww/SBjcxbvX2pXrSUH5b2MYBNzDFRhJLMTWDGiLrlPGH5md@nongnu.org
X-Gm-Message-State: AOJu0YxMn8lAgOTQHJjNb3o14lQ2Q1h5KsOFVeK71sS+miHQRHMchr28
 5u/Q3H55mvWQtlwIxsVJ5zZTyu5OJEcEamrRRMAkytF5+NF3Ee52RIRa2WHWYmgcOcs8QIozQtC
 Sik7Y9NZtXw==
X-Google-Smtp-Source: AGHT+IEeWbai9Gn1PgqWB9HJc9cFYlWzRf2m1VUWpz2CsDC9GguKrbXgU6bwuqMxYZPdMSfgZ8/pxgbCqxdn6w==
X-Received: from pjur16.prod.google.com ([2002:a17:90a:d410:b0:2f2:e5c9:de99])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:194f:b0:2ee:59af:a432 with SMTP id
 98e67ed59e1d1-2fa2450985amr1053633a91.31.1738879942207; 
 Thu, 06 Feb 2025 14:12:22 -0800 (PST)
Date: Thu,  6 Feb 2025 14:11:55 -0800
In-Reply-To: <20250206221203.4187217-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206221203.4187217-10-wuhaotsh@google.com>
Subject: [PATCH v4 09/17] hw/misc: Support 8-bytes memop in NPCM GCR module
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3xjOlZwgKCgc31ohv0zonvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
---
 hw/misc/npcm_gcr.c   | 94 +++++++++++++++++++++++++++++++++-----------
 hw/misc/trace-events |  4 +-
 2 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index 7cdea2e392..d644d7ddd5 100644
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
2.48.1.502.g6dc24dfdaf-goog


