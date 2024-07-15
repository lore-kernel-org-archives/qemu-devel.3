Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLe-0006rw-9f; Mon, 15 Jul 2024 04:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30eGUZggKCiQSMOSTAFAGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--smostafa.bounces.google.com>)
 id 1sTHLZ-0006UU-H9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:13 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30eGUZggKCiQSMOSTAFAGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--smostafa.bounces.google.com>)
 id 1sTHLX-000497-Ff
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:13 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-42668796626so29158575e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033169; x=1721637969; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kj36bY1MZTmA3fn0hogzzbR0HenoL/hm4YWjDVye+LY=;
 b=BSqpe8CRF8hLiAv923epROlLIkrFhRLtvZW2MJ4n1NH3FOnQjzU1rX4Rb+usujhaPJ
 ED9eBZtpom1fNvXkh+WDCVZxzzBZgaK4Nipc8BfbsyIDLkL9tk2+8V7+6+TscXZPkLOn
 reldwPm3W6Y3jS1nSf9xHSwNJVDgUmT5DJcwCPmSSB+SP3I+p/7BXMJKPHu7XhvzU0Ip
 GJxm6XVe2VFr5AAY9BQOlNHMYzubllxxOoeJMYT+JS3j9LfQ9G3ph7tTgiRtzE+6FkNe
 pIzBuMM6kJTBV6txNS5Mx0eVpHZgJzJOT9rNKZJOcqlyfWDSBePpfde5hKa5XfttZKsS
 ZrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033169; x=1721637969;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kj36bY1MZTmA3fn0hogzzbR0HenoL/hm4YWjDVye+LY=;
 b=S+TM4j7eCBb8xtlZux/YGYH4aZ59cZGab3zp8HKUcA0f0xg/ENEKTAlnQgX2jip8Sm
 nTYHlDSBC+8DrG5NlWSTWkldRzoG0ZLlXFNnkac4EF3rd8BPWy31bOmlZwhu9ZlNVkEC
 6gklWNdLX5+nBcsA5ezIRN6nsBcx5F1zQ4hsbIgm5DvarB9NlHIz1lE9CaAgrYwxOk3C
 vU17EwV4XCL/ytnvb+8Bt/tyycqlA1o9L11o5fmdAAjxw4aYA+IYUv+87eUc2zwh/m4u
 UEZtuGAvSpwMRZVLpH3dCCIlwLP51SzMT9Ac6lJV276sgfEmFodrhsWkkxok51htJ3Cy
 mxDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxlz6AGFjak4JHUGkRkpqHsbiQII38sBi/nL9MfGvklKnTJAKZb6su9oL+gSV8MdDu9VyAza06z0y7NUV6/wQAWg6EhOM=
X-Gm-Message-State: AOJu0YxDuBNxIpvviAcraRIxkP9grALbjnVIuZKuSegdnjize/FW7WSf
 4SMA7uRWpH0s+IjSL0v5sMJf3/D5/VRPz9oMFQfIJhR4Sb/AXxOnn2/DEdZwMUqasqL5oJcUVvJ
 i/ulltd2wjg==
X-Google-Smtp-Source: AGHT+IE3yCMqArE3cgMvUT0H3jfFFd5ZEhuDMLDaM3jAWXcItxSXdUDMCvnTlFvbN/fuc7Qtufq69t4jc+J3hA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:4fd3:b0:426:62a2:e0b with SMTP
 id 5b1f17b1804b1-426705cf7c4mr937075e9.2.1721033169264; Mon, 15 Jul 2024
 01:46:09 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:18 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-19-smostafa@google.com>
Subject: [PATCH v5 18/18] hw/arm/smmu: Refactor SMMU OAS
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=30eGUZggKCiQSMOSTAFAGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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

SMMUv3 OAS is currently hardcoded in the code to 44 bits, for nested
configurations that can be a problem, as stage-2 might be shared with
the CPU which might have different PARANGE, and according to SMMU manual
ARM IHI 0070F.b:
    6.3.6 SMMU_IDR5, OAS must match the system physical address size.

This patch doesn't change the SMMU OAS, but refactors the code to
make it easier to do that:
- Rely everywhere on IDR5 for reading OAS instead of using the
  SMMU_IDR5_OAS macro, so, it is easier just to change IDR5 and
  it propagages correctly.
- Add additional checks when OAS is greater than 48bits.
- Remove unused functions/macros: pa_range/MAX_PA.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c     |  7 ++++---
 hw/arm/smmuv3-internal.h | 13 -------------
 hw/arm/smmuv3.c          | 35 ++++++++++++++++++++++++++++-------
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 67cb134d23..7d8a353956 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -452,7 +452,8 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
     inputsize = 64 - tt->tsz;
     level = 4 - (inputsize - 4) / stride;
     indexmask = VMSA_IDXMSK(inputsize, stride, level);
-    baseaddr = extract64(tt->ttb, 0, 48);
+
+    baseaddr = extract64(tt->ttb, 0, cfg->oas);
     baseaddr &= ~indexmask;
 
     while (level < VMSA_LEVELS) {
@@ -576,8 +577,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
      * Get the ttb from concatenated structure.
      * The offset is the idx * size of each ttb(number of ptes * (sizeof(pte))
      */
-    uint64_t baseaddr = extract64(cfg->s2cfg.vttb, 0, 48) + (1 << stride) *
-                                  idx * sizeof(uint64_t);
+    uint64_t baseaddr = extract64(cfg->s2cfg.vttb, 0, cfg->s2cfg.eff_ps) +
+                                  (1 << stride) * idx * sizeof(uint64_t);
     dma_addr_t indexmask = VMSA_IDXMSK(inputsize, stride, level);
 
     baseaddr &= ~indexmask;
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 0f3ecec804..0ebf2eebcf 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -602,19 +602,6 @@ static inline int oas2bits(int oas_field)
     return -1;
 }
 
-static inline int pa_range(STE *ste)
-{
-    int oas_field = MIN(STE_S2PS(ste), SMMU_IDR5_OAS);
-
-    if (!STE_S2AA64(ste)) {
-        return 40;
-    }
-
-    return oas2bits(oas_field);
-}
-
-#define MAX_PA(ste) ((1 << pa_range(ste)) - 1)
-
 /* CD fields */
 
 #define CD_VALID(x)   extract32((x)->word[0], 31, 1)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 32b1f4cb75..d119a8026f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -402,10 +402,10 @@ static bool s2t0sz_valid(SMMUTransCfg *cfg)
     }
 
     if (cfg->s2cfg.granule_sz == 16) {
-        return (cfg->s2cfg.tsz >= 64 - oas2bits(SMMU_IDR5_OAS));
+        return (cfg->s2cfg.tsz >= 64 - cfg->s2cfg.eff_ps);
     }
 
-    return (cfg->s2cfg.tsz >= MAX(64 - oas2bits(SMMU_IDR5_OAS), 16));
+    return (cfg->s2cfg.tsz >= MAX(64 - cfg->s2cfg.eff_ps, 16));
 }
 
 /*
@@ -426,8 +426,11 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
     return nr_concat <= VMSA_MAX_S2_CONCAT;
 }
 
-static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
+static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
+                             STE *ste)
 {
+    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
+
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
                       "SMMUv3 AArch32 tables not supported\n");
@@ -460,7 +463,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
     }
 
     /* For AA64, The effective S2PS size is capped to the OAS. */
-    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), SMMU_IDR5_OAS));
+    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), oas));
+    /*
+     * For SMMUv3.1 and later, when OAS == IAS == 52, the stage 2 input
+     * range is further limited to 48 bits unless STE.S2TG indicates a
+     * 64KB granule.
+     */
+    if (cfg->s2cfg.granule_sz != 16) {
+        cfg->s2cfg.eff_ps = MIN(cfg->s2cfg.eff_ps, 48);
+    }
     /*
      * It is ILLEGAL for the address in S2TTB to be outside the range
      * described by the effective S2PS value.
@@ -536,6 +547,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
+    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
     int ret;
 
     if (!STE_VALID(ste)) {
@@ -579,8 +591,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
          * Stage-1 OAS defaults to OAS even if not enabled as it would be used
          * in input address check for stage-2.
          */
-        cfg->oas = oas2bits(SMMU_IDR5_OAS);
-        ret = decode_ste_s2_cfg(cfg, ste);
+        cfg->oas = oas2bits(oas);
+        ret = decode_ste_s2_cfg(s, cfg, ste);
         if (ret) {
             goto bad_ste;
         }
@@ -706,6 +718,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     int i;
     SMMUTranslationStatus status;
     SMMUTLBEntry *entry;
+    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -724,7 +737,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     cfg->aa64 = true;
 
     cfg->oas = oas2bits(CD_IPS(cd));
-    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    cfg->oas = MIN(oas2bits(oas), cfg->oas);
     cfg->tbi = CD_TBI(cd);
     cfg->asid = CD_ASID(cd);
     cfg->affd = CD_AFFD(cd);
@@ -753,6 +766,14 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
             goto bad_cd;
         }
 
+        /*
+         * An address greater than 48 bits in size can only be output from a
+         * TTD when, in SMMUv3.1 and later, the effective IPS is 52 and a 64KB
+         * granule is in use for that translation table
+         */
+        if (tt->granule_sz != 16) {
+            cfg->oas = MIN(cfg->oas, 48);
+        }
         tt->tsz = tsz;
         tt->ttb = CD_TTB(cd, i);
 
-- 
2.45.2.993.g49e7a77208-goog


