Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D49CD11DB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMc-0004Yp-30; Mon, 25 Mar 2024 06:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vk4BZggKCpcJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com>)
 id 1rohMa-0004Wn-De
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:32 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vk4BZggKCpcJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com>)
 id 1rohMX-0004hY-2n
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:32 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-41413823c1bso24481495e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361726; x=1711966526; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UqHTaZygPYcO5rxnIuRiQBfEhEaYRf9U7Q9zvZX8j20=;
 b=Aez9hd9mgIyPkakr+KKcqdEJIMmRJy9TjTxjAjZeSc3YQljxNGERODpHw2vT0/tLM0
 lruuHcV7C2rxj6u15H+nxuaiRaQEaHp70Ec3Z69eO2r0w5S2+OMsw22RLXXoxapXc+4R
 FMi4YgvJ8F+mRqZXn3fHl5H+5gtL6SYRtARuqdvGf9oWipbU8I8RsUQsQU0D0aIdrru4
 8f/beAGzr0dRdFcBin1FOdMCPAulcag0PSEIcy1GmMxcTI02XqoSxPpflRZzhWceNMH9
 uzbVsmWZMgbdECI8Cs1Rtbn2sqlpZ32LSFoYgIdR2RGszYg0gUZTHaw/urzsy2p9s3+s
 3+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361726; x=1711966526;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UqHTaZygPYcO5rxnIuRiQBfEhEaYRf9U7Q9zvZX8j20=;
 b=TEuQg+VH6tIpdKhb+d3B0VYJ+B3YZJe86Exng3rW43Ab9t4RgcUugpoqwEVljVlvaG
 hiDCTWavJynZ/HJNeW6Yb12Vqx8kHoCc96pPKHHVMVXAywlMrgxWTOyYY1cPKhm3YGQd
 udl+Lg8xG9EKrOHQ2R2iw6h7V2b5JQ1haGyCTWe9+SxnBUJk4oKvFrg7akbOkgIGA1te
 b+nXMw0wndUn7Tb5ybOG8C/FYQNbbvFyyitq1QqTENzHZxYwRKNRM78WfKcCiHdet+Is
 qxES8Tq6jeHyu+i9RByTL7IysGLe3WGTfCF+pXIwv8FEJNy/yjrO3kJljgvGKcXpatsd
 YY9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW27MIwauWvDzjllb4SaVlxNTNLnF/20bHx0nKygdK9+D4wMVBVu0QoiHc6gA2NwFmPSCTe7b9GD6Gov4+t37VrW5qqLUY=
X-Gm-Message-State: AOJu0Yym/xXcOWZOtrjXAuK8tS2eYJypedstXWBGN/yasHYwKzZaA7eE
 DLavJnLrSue9+Nx+LRcbV1dNo9ERi6nW2+dFxxxbATCtxnCFqyEDQIGHRTOmoH5nNz0IawYueL5
 Zg4tIe/JdAA==
X-Google-Smtp-Source: AGHT+IE1t+lKZzlbnFZB5V+GeOeAMERzDwRCPrC4b+TazQQ3uYAzYTnWh7CI6q8SW9xI20Bk7kR7DFVqtfDLhQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:1396:b0:414:64b3:5036 with SMTP
 id u22-20020a05600c139600b0041464b35036mr144885wmf.3.1711361726440; Mon, 25
 Mar 2024 03:15:26 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:06 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-11-smostafa@google.com>
Subject: [RFC PATCH 10/12] hw/arm/smmu: Refactor SMMU OAS
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3vk4BZggKCpcJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x349.google.com
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

SMMUv3 OAS is hardcoded to 44 bits, for nested configurations that
can be a problem as stage-2 might be shared with the CPU which might
have different PARANGE, and according to SMMU manual ARM IHI 0070F.b:
    6.3.6 SMMU_IDR5, OAS must match the system physical address size.

This patch doesn't change the SMMU OAS, but refactors the code to
make it easier to do that:
- Rely everywhere on IDR5 for reading OAS instead of using the macro so
  it is easier just change IDR5 and it propagages correctly.
- Make the code work if OAS is 52 bits.
- Remove unused functions/macros: pa_range/MAX_PA

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c     |  7 ++++---
 hw/arm/smmuv3-internal.h | 15 ++-------------
 hw/arm/smmuv3.c          | 35 ++++++++++++++++++++++++++++-------
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index da8776ecec..a4196ddd22 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -359,7 +359,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
     inputsize = 64 - tt->tsz;
     level = 4 - (inputsize - 4) / stride;
     indexmask = VMSA_IDXMSK(inputsize, stride, level);
-    baseaddr = extract64(tt->ttb, 0, 48);
+
+    baseaddr = extract64(tt->ttb, 0, cfg->oas);
     baseaddr &= ~indexmask;
 
     while (level < VMSA_LEVELS) {
@@ -472,8 +473,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
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
index e4dd11e1e6..a7d53b3854 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -592,23 +592,12 @@ static inline int oas2bits(int oas_field)
         return 44;
     case 5:
         return 48;
+    case 6:
+        return 52;
     }
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
index 288e7cf1ae..2a29e3bccb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -411,10 +411,10 @@ static bool s2t0sz_valid(SMMUTransCfg *cfg)
     }
 
     if (cfg->s2cfg.granule_sz == 16) {
-        return (cfg->s2cfg.tsz >= 64 - oas2bits(SMMU_IDR5_OAS));
+        return (cfg->s2cfg.tsz >= 64 - cfg->s2cfg.eff_ps);
     }
 
-    return (cfg->s2cfg.tsz >= MAX(64 - oas2bits(SMMU_IDR5_OAS), 16));
+    return (cfg->s2cfg.tsz >= MAX(64 - cfg->s2cfg.eff_ps, 16));
 }
 
 /*
@@ -435,8 +435,11 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
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
@@ -469,7 +472,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
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
@@ -545,6 +556,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
+    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
     int ret;
 
     if (!STE_VALID(ste)) {
@@ -591,8 +603,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
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
@@ -718,6 +730,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     int i;
     SMMUTranslationStatus status;
     SMMUTLBEntry *entry;
+    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -736,7 +749,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
     cfg->aa64 = true;
 
     cfg->oas = oas2bits(CD_IPS(cd));
-    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
+    cfg->oas = MIN(oas2bits(oas), cfg->oas);
     cfg->tbi = CD_TBI(cd);
     cfg->asid = CD_ASID(cd);
     cfg->affd = CD_AFFD(cd);
@@ -765,6 +778,14 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
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
2.44.0.396.g6e790dbe36-goog


