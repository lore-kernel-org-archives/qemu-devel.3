Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CD1E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQj9z-0007vf-69; Thu, 26 Dec 2024 03:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fBJtZwgKCpcNL81FKJ87FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9U-0007Ty-Nc
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:28 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fBJtZwgKCpcNL81FKJ87FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--wuhaotsh.bounces.google.com>)
 id 1tQj9T-0000Z5-3m
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:23:28 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2166855029eso75277155ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201404; x=1735806204; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dSh3O5WaaKwNo1iaUvTSpo+z9u0dQr4Ul55JCilzC1E=;
 b=FnfaS/otLWEUaiYy/GfK1rmakoZbYTY3gA887J5Rfpt0wMYFIjlSVpgHQmyYlyCmV2
 klNzJtlEmhe/ixDnWAm7emJmVlrWymq6tpptqWArYHYs0XnAKlKjpkTgSUHXxW9kR5M7
 WNvaPvpeqSvl6GNRtUWQckMHFNHoEqSDAz+vS6FpTsX6XI3+j6PNZmUDH75m0Q7AQ31N
 mZi/x7ILpClEiSOQ6LeyLA4877Kz9vwV2ExZCglMJyiqWXgFtG5geZjxQr72r14NNKYh
 YsdOBdsuPyuQqP9CrBZCicTwOIAltPiozZKnImOMezHWUJko/akTMObFpC/b1kJpzyg5
 iwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201404; x=1735806204;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dSh3O5WaaKwNo1iaUvTSpo+z9u0dQr4Ul55JCilzC1E=;
 b=Iw68GBni/TsPlAJRebVFpe9GZw+ERoK/5Nn5FpgeihxXuO2yW2xbUVMDuBarZqN1A7
 w7wQTzt6qdk3Z9C3nk08RBfELitdc0VGEnm10Rn/v/twdRbSrEB4fK5qPmpm2dOqsE2T
 sAUJqvE6d9phUqycDhNnXC+6aw9c6qYioK8wKDFBwARCNYkAvAa3Pl8E8rRv/OUmrEmA
 mCFqu7WhMvX6PA5ToS25LvBl/FlRQ0Mu/m3o+YTqvkTuytkrOL2XlBI4zbSwSesxy+Ea
 +jEKwH69lPQn477Etb12xYafw7CUWH4zegFpMrM5lH41lP+dKQBH5Y8QKtH3szYOSXtd
 cWGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPOOyx0kcrCsPue+1p/4hzT93krOo4SoZBhnTjyLLGt4nqTXUVfstVFWEIAH76rEkiGFYQCQykOZ2r@nongnu.org
X-Gm-Message-State: AOJu0YyXwnrK+wEsKFm1qpo1Ils1ifLi0evQGE/mhJTjNf6tPoJBBjBm
 fDnnvH9D1/zHUBUXGctt9x0cfV31SwR1th/KoE0Lt+tX9czBRi/L2v05jbfEsb74ZD+THS/8idu
 PzrTA9spwWA==
X-Google-Smtp-Source: AGHT+IGhciBY7JOvcaiZKqfDokTB0tyIMo1xsX5q7CQAPjwUCNvh1WVN/30eY6s0kuG17j8avqZf+u4X2x0imA==
X-Received: from pgbbi9.prod.google.com ([2002:a05:6a02:249:b0:7fd:1eba:c2dd])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:394b:b0:1e1:e2d8:fd3a with SMTP id
 adf61e73a8af0-1e5e07ffb23mr43631935637.35.1735201404280; 
 Thu, 26 Dec 2024 00:23:24 -0800 (PST)
Date: Thu, 26 Dec 2024 08:22:29 +0000
In-Reply-To: <20241226082236.2884287-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082236.2884287-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082236.2884287-11-wuhaotsh@google.com>
Subject: [PATCH 10/17] hw/misc: Support 8-bytes memop in NPCM GCR module
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3fBJtZwgKCpcNL81FKJ87FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--wuhaotsh.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/misc/npcm_gcr.c   | 94 +++++++++++++++++++++++++++++++++-----------
 hw/misc/trace-events |  4 +-
 2 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
index a4c9643119..7dfdd3d74b 100644
--- a/hw/misc/npcm_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -201,6 +201,7 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
     uint32_t reg = offset / sizeof(uint32_t);
     NPCMGCRState *s = opaque;
     NPCMGCRClass *c = NPCM_GCR_GET_CLASS(s);
+    uint64_t value;
 
     if (reg >= c->nr_regs) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -209,9 +210,21 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
         return 0;
     }
 
-    trace_npcm_gcr_read(offset, s->regs[reg]);
+    switch (size) {
+    case 4:
+        value = s->regs[reg];
+        break;
+
+    case 8:
+        value = s->regs[reg] + (((uint64_t)s->regs[reg + 1]) << 32);
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
@@ -231,29 +244,65 @@ static void npcm_gcr_write(void *opaque, hwaddr offset,
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
+        s->regs[reg + 1] = v >> 32;
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
@@ -262,7 +311,8 @@ static const struct MemoryRegionOps npcm_gcr_ops = {
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
index f2d498e862..59c2d4ecc0 100644
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
2.47.1.613.gc27f4b7a9f-goog


