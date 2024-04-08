Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D77CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtphW-00086t-MG; Mon, 08 Apr 2024 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3kfoTZggKCg460267otou22uzs.q204s08-rs9sz121u18.25u@flex--smostafa.bounces.google.com>)
 id 1rtpgp-00079l-9v
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:44 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3kfoTZggKCg460267otou22uzs.q204s08-rs9sz121u18.25u@flex--smostafa.bounces.google.com>)
 id 1rtpgc-0001OA-J7
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:39 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc693399655so7946152276.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585361; x=1713190161; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xWJgvkXsRDlv4QySfPpJRYbrk5xBNLshUoOdVCtmsHg=;
 b=VpeCTdPg6r7dy338iWNqg71qNKMC/OrQWATf6b0CGONAfoMFm3aoUp03KEb2S19Rr/
 bCnvdLJA7e/WSnqzsapFzBoTxGaxDOs3lqzo4uuYoCYghUTir1D3QnDUayp8frWoMGZe
 T/cj7rgqxbVYs7ktSTK5xMIrrhiGldO++7yk5Knmj1tMBkRHPC+as9wRT3GIBLfHm5Ki
 iTAtxZA6NeKmyw1yWou/OY7wxjH1qQdMMElG1iAfqa0dCn3hYiPpk+qyv6AzvnQH9w8l
 nWcGxD1izi4iDmYsYuuhhGtW8bg57mCsNQIP392v/Hm+niUJkynJqkC4nMJ2eF6YFI/F
 ytOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585361; x=1713190161;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xWJgvkXsRDlv4QySfPpJRYbrk5xBNLshUoOdVCtmsHg=;
 b=L7DEkUc9KNshU+HA7WitrONHZOz1N1UBbOwwNVgG94MnjOux/FWGnwZulPWPfgpDyv
 2zjm4osp7Lkifrk6rh4jxMCxKD1Y1mU3YxnzYdcUPvjaDxHLFSIQn9xNxtqWJrNjANwe
 ayX/gR0WRa1o/ezsOwlpcXZlou52CBpRl5i7IAQod8gmEkuJ76EwC2Tp3gTaDQ/YDXYs
 BRIIgnUefqyvh1WW63VwB75fSLsh8n1U2Grr4U2fINx4GJAkZFneeyiSAuohQ5LPXxGQ
 9jyySAat+MfLgYoz4/EF0qs+oqMdZz8oSgHYbRL5VmioHiDw7l8XXoS72nBiKHBySggC
 u9KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHVUi8+S56SNrQqbe2A/KzxnOp4SMrw3d3AaA8GiDMudZ5aP3l2epcBpxPm1pI1C3aGymGaKX16pz5OWqVE2JJ9Cx6AxI=
X-Gm-Message-State: AOJu0YzKr34IxoEn4O/tdtto0wG6qO73yYCfmiibnX2AGJIsPT5pKd15
 kcl+EZj8/g6fcqLTGi1xB4d1iuna7zvlRc/xt0AC3DeSjhhKhs3wLAWPGqxgCG1TFB3IXY8klEs
 qO2UjnJtlqQ==
X-Google-Smtp-Source: AGHT+IHQMA3cRcyxEy3dt9h6LYbjHh++lB0rxNHdAwlgj4xEmjt5EGwd6WJA1nFNuPifBMWod0kAcIu9MKBiHA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:726:b0:dcd:3172:7265 with SMTP
 id l6-20020a056902072600b00dcd31727265mr2744024ybt.8.1712585361014; Mon, 08
 Apr 2024 07:09:21 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:14 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-10-smostafa@google.com>
Subject: [RFC PATCH v2 09/13] hw/arm/smmuv3: Support and advertise nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3kfoTZggKCg460267otou22uzs.q204s08-rs9sz121u18.25u@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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
index 85b3ac6a9c..da47411410 100644
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
@@ -525,13 +548,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
 
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
 
@@ -704,7 +723,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
 
     /* we support only those at the moment */
     cfg->aa64 = true;
-    cfg->stage = SMMU_STAGE_1;
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
@@ -887,28 +905,28 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
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
2.44.0.478.gd926399ef9-goog


