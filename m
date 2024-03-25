Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF28C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMa-0004WC-2t; Mon, 25 Mar 2024 06:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uk4BZggKCpMF9BFGx2x3BB381.zB9D19H-01I18ABA3AH.BE3@flex--smostafa.bounces.google.com>)
 id 1rohMX-0004Rz-JN
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:29 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uk4BZggKCpMF9BFGx2x3BB381.zB9D19H-01I18ABA3AH.BE3@flex--smostafa.bounces.google.com>)
 id 1rohMU-0004cj-RK
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:29 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-60cc8d4e1a4so76990587b3.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361722; x=1711966522; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wHU+2Us+dIMmbE9OBQ2CgF2/1KqvZBlHyTvsxveVE+s=;
 b=QKITSYSXwSggxzZdppe6iPP8kbm2jGLw1/Msq+b6/hNXcA+I69JwAj1OzYgcxTshZ0
 Msp/NBdFXGtdE3C9MOzUP+CuEFQvsBsZOwI2Dg5NoW7c76XhTM7F2CLxRyvMPadYGbTg
 eL0dLFmVUw68HfMunaBT0nMpEdwa+ZnFUVmy6UKLAQiCiOS3LJFIk5O+sKfX+G3E/J0Y
 KWU8dOXONKE+CZmK4qDPjkrdDCXIwXyxveLlJuCpfeUnUxE44PRRnrGQjX2sU/HJfB1T
 jFJh1QtV3hViLGOJvhmd5BL+/eUPxBUzwO/8/kRBmU/h+q6bVPOoRK4igYo2N3WuJWG0
 jhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361722; x=1711966522;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wHU+2Us+dIMmbE9OBQ2CgF2/1KqvZBlHyTvsxveVE+s=;
 b=FidPMgsrDU7Mos+ocZiitulGZmqk/8Lhbbg9+Gg91QB9vmFVnrpnYPAmknOgKkVFku
 dyPOJVRjaKdW1kT/PrYBpRAd8q/fjfROjn2p+Y1koeWYHRPlJm0c8nmbMqshsAZ0pXLy
 t9pBrAMMB/40hNnACzX/6tNHoZk8zznV7Fc0LOiKzPOHnJQN2p7SBtSoHLJ84Szq1ZFp
 PDNoLlNMQ+LC/nQ2iSLr5dbLYqJhYCMhBRs3jMxgkiBq2Y8nFXKskMzGbLHqIrbrDjRQ
 fqzaktB0pZT/6snlZ4TDfGhsWa9ShvEABvrsPSvfgGo+SSvdvZu5NaOCIXe1Z/uGIqad
 sX4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBl7rDwsR70otvIAZacX1rVia2J4GXGUyMNyZ5/1FdE89o488Fxnp2vjyEm94vzyt41898L98/dS1TrXvW95taB6KI564=
X-Gm-Message-State: AOJu0YyOtpt44kUth+lz4krGU/Wuy4eBnEXU1jbXFtJqBWvgLfC4woY3
 5EvH+EKCUKLiCPVTOWXF4HyuYCxYcfHbyzqt3l9KHc3nR6LyrRVvFS/lWoL6OU2o/953IgopTqE
 8yBnNOCKD4w==
X-Google-Smtp-Source: AGHT+IGKw7bQ4UOBMzrfuoG6w6xqXQt+M58+XMrrM0hdUU5wZVJhFCCmQCQXHCig6rD5ZfN8BmLqUtKSXBO29A==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:100a:b0:dc7:48ce:d17f with SMTP
 id w10-20020a056902100a00b00dc748ced17fmr2145161ybt.10.1711361722213; Mon, 25
 Mar 2024 03:15:22 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:04 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-9-smostafa@google.com>
Subject: [RFC PATCH 08/12] hw/arm/smmuv3: Support and advertise nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3uk4BZggKCpMF9BFGx2x3BB381.zB9D19H-01I18ABA3AH.BE3@flex--smostafa.bounces.google.com;
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
 hw/arm/smmuv3.c | 51 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 32a1838576..e5373f4cfe 100644
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
@@ -425,8 +429,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 
 static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
 {
-    cfg->stage = SMMU_STAGE_2;
-
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
                       "SMMUv3 AArch32 tables not supported\n");
@@ -509,6 +511,27 @@ bad_ste:
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
+        cfg->stage |= SMMU_STAGE_1;
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
@@ -525,16 +548,15 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
 
     config = STE_CONFIG(ste);
 
-    if (STE_CFG_ABORT(config)) {
-        cfg->aborted = true;
+    decode_ste_config(cfg, config);
+
+    if (cfg->aborted) {
         return 0;
     }
 
-    if (STE_CFG_BYPASS(config)) {
-        cfg->bypassed = true;
+    if (cfg->bypassed) {
         return 0;
     }
-
     /*
      * If a stage is enabled in SW while not advertised, throw bad ste
      * according to user manual(IHI0070E) "5.2 Stream Table Entry".
@@ -704,7 +726,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
 
     /* we support only those at the moment */
     cfg->aa64 = true;
-    cfg->stage = SMMU_STAGE_1;
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
@@ -887,28 +908,28 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr = addr;
                 event->u.f_translation.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr = addr;
                 event->u.f_access.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr = addr;
                 event->u.f_permission.rnw = flag & 0x1;
-- 
2.44.0.396.g6e790dbe36-goog


