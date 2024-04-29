Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2957C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hde-0000Xh-6j; Sun, 28 Apr 2024 23:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ERMvZggKCiwaUWabINIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--smostafa.bounces.google.com>)
 id 1s1Hdc-0000X0-Ih
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:08 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ERMvZggKCiwaUWabINIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--smostafa.bounces.google.com>)
 id 1s1Hda-0004Dr-SB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:08 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-615073c8dfbso70887147b3.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361105; x=1714965905; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=H4fA+OHOmnWEwvYlQG+NpudUMjNJ2XOSvr3sfIS6o60=;
 b=w8LwIe0vDK6mW6XcLxCwE3IhqMy7uGJLfTiGKQ0UHdTzYusDW5igjWA8sy2gP12Srq
 6nBmWM1H91j50bfb/RRjxkSWpbnw4/mD/ZaT9syGlm7kVpZpFQE0j80ZhvZ1B35dV/6a
 5pA/NrtjjGP/UWkIv8zrk+oV2gQkLK/jPM0ShKCHqMfgKrg5rawjnq7D7phZEvG1yvqZ
 40aXo2NEejDwSa3pWup9qXjAlDKX8LgV50Q1DqF/1EoZFl+MKKutUJbCU0CjFkIzOBvw
 vuPVpqAQ/ky9lRgg7ZpYDYgh/Tf298z9WE5BJ5xDHAajfMo2HTJoWR4FN7dlVgKNUn0z
 xedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361105; x=1714965905;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4fA+OHOmnWEwvYlQG+NpudUMjNJ2XOSvr3sfIS6o60=;
 b=T7avTKIfU1dE3oigp/llZywJznN47kpZV2hXB/yOlZVThw14mDnQI3NuKnhtx4fmt3
 CpmB/JUFQ7SEVO6dipEU5ssKOtNkWcN6KfisBrtL9id9z1C2Dwp4eEVpkFKxl4rL0JwG
 6SNc0XSH9MJ1ETyl3HQ0Crc4AtiQxnPgPpzFz6s19bOl9eCAIwm/B5icrpzjvDptAF50
 eJMHTpTmjtHGY9xbbIAJR9A65UT25lkpzLeE5kaoKRC/TmWlWZuowtqfqo+gErE97py7
 cu2J10DX27koCRurIV1P9KB7ErfIgfFJa+z5wqDn0wrh6DxZTNtHfoTxcDPUoOeT+7IB
 eLeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULfTYUBcC93ebXtwBhlJUDHG32y4RM0tjaLg/IBBR4zyG3VgfxwHWgOlFQAbqqNJ25u8P6xyvUPnMqRkBxaWFVG0Dk7tw=
X-Gm-Message-State: AOJu0Yy9Qlw76wmD8KmCSWY5CBMU1GYDVlwsoNdOTnTea6cW4+WHlOOc
 E9HNtTsTQgZqd2BUyWjmzUv6xYwhbQas0hTVS/4iK+49tYooNOLo4Q0Wm1rUQb+vr5hiWM4IVxi
 BsV+SGLqtGA==
X-Google-Smtp-Source: AGHT+IHMgQnc8GyjdKLDzwQQxWvYt2h6/8YOpL/WjUuJxPOdpipmwtupZ49sEHJAAoD+kf6Tv0IaV2WKS18zXA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:18ca:b0:dc2:2ace:860 with SMTP
 id ck10-20020a05690218ca00b00dc22ace0860mr1017837ybb.2.1714361105174; Sun, 28
 Apr 2024 20:25:05 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:58 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-15-smostafa@google.com>
Subject: [RFC PATCH v3 14/18] hw/arm/smmuv3: Support and advertise nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3ERMvZggKCiwaUWabINIOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

Everything is in place, add the last missing bits:
- Handle fault checking according to the actual PTW event and not the
  the translation stage.
- Consolidate parsing of STE cfg and setting translation stage.

Advertise nesting if stage requested is "nested".

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 96d07234fe..88f6473d33 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -34,9 +34,10 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
-#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
-                                 (cfg)->record_faults : \
-                                 (cfg)->s2cfg.record_faults)
+#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
+                                        (cfg)->record_faults) || \
+                                        ((ptw_info).stage == SMMU_STAGE_2 && \
+                                        (cfg)->s2cfg.record_faults))
 
 /**
  * smmuv3_trigger_irq - pulse @irq if enabled and update
@@ -260,6 +261,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
     /* Based on sys property, the stages supported in smmu will be advertised.*/
     if (s->stage && !strcmp("2", s->stage)) {
         s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
+    } else if (s->stage && !strcmp("nested", s->stage)) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
     } else {
         s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
     }
@@ -422,8 +426,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 
 static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
 {
-    cfg->stage = SMMU_STAGE_2;
-
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
                       "SMMUv3 AArch32 tables not supported\n");
@@ -506,6 +508,27 @@ bad_ste:
     return -EINVAL;
 }
 
+static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
+{
+
+    if (STE_CFG_ABORT(config)) {
+        cfg->aborted = true;
+        return;
+    }
+    if (STE_CFG_BYPASS(config)) {
+        cfg->bypassed = true;
+        return;
+    }
+
+    if (STE_CFG_S1_ENABLED(config)) {
+        cfg->stage = SMMU_STAGE_1;
+    }
+
+    if (STE_CFG_S2_ENABLED(config)) {
+        cfg->stage |= SMMU_STAGE_2;
+    }
+}
+
 /* Returns < 0 in case of invalid STE, 0 otherwise */
 static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
@@ -522,13 +545,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
 
     config = STE_CONFIG(ste);
 
-    if (STE_CFG_ABORT(config)) {
-        cfg->aborted = true;
-        return 0;
-    }
+    decode_ste_config(cfg, config);
 
-    if (STE_CFG_BYPASS(config)) {
-        cfg->bypassed = true;
+    if (cfg->aborted || cfg->bypassed) {
         return 0;
     }
 
@@ -701,7 +720,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
 
     /* we support only those at the moment */
     cfg->aa64 = true;
-    cfg->stage = SMMU_STAGE_1;
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
@@ -901,7 +919,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr = addr;
                 event->u.f_translation.addr2 = ptw_info.addr;
@@ -910,7 +928,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
@@ -919,7 +937,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr = addr;
                 event->u.f_access.addr2 = ptw_info.addr;
@@ -928,7 +946,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr = addr;
                 event->u.f_permission.addr2 = ptw_info.addr;
-- 
2.44.0.769.g3c40516874-goog


