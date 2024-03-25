Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2C0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMZ-0004Ts-9f; Mon, 25 Mar 2024 06:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3t04BZggKCpAC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1rohMV-0004PL-31
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:27 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3t04BZggKCpAC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1rohMP-0004bH-8t
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:23 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dbf216080f5so7033898276.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361720; x=1711966520; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fSN09FPbbiwAOPaRrzotNJWTUCQMS1xWJ+mdnnfOvl0=;
 b=xwFwlQbNMhJsLGy5FeknJlPCHKaj4x3FfKt90JO9gbwLn9KO3Wjcm7r1tfkgkXn+rj
 QohTh+qVZbz9z/lp7YfMpfp8SEE7y1Yf8EbTCP7h/7FZA7WbxWE753wSHaRbd8FRAwRc
 W85yY3CEH5Y4YZaxoAes+ZJHGCCe8b0ykWkjuEOZa/ZSCK1qd0rUJAkoVeAvnTBuKtyE
 Fcvax3q1i5OgsPO/VGcTuPepuFZN7vAkPkXmUlILmvTWYbUsNAiNQCD5I3haJGSiy3A0
 SGdh4oPOVqY3Dooy8l5Z4eFySCwmfQzc39WyPT+PskpZiwUB5KPb/Q5GTMdcE1kSVI1j
 9WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361720; x=1711966520;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fSN09FPbbiwAOPaRrzotNJWTUCQMS1xWJ+mdnnfOvl0=;
 b=myYxA4/f/1l4qWl5Lf2VmTlreQdajQxtwKSNq+XBlx7qBsXFUgiLzfVmINBRSt7/JH
 fuL2k5LiXdNycP41iir8tToIkVblNWmbQ+J8m/KJ9Q5G8ZZHzuCzB+hgjSatWBAD+Plm
 UOH+DpWeGx9PXpfzzgyYBEJjSRwI5kvJ0qAXllnyf+HptgDsfxQcI7WqwvQBaT/oVQZR
 tdE+5k5OlE4bRO8ynATYAw5VdLNrKgrhH0OhaIC3sim8n+hSBfpCVemiOADiDDEA5JN6
 rTWPu6bTWOUjEqMLs8GF8e8cMXiNj64o+XjC3jUe3msr2L0DMUniZovY9NaQm79i3oR5
 XFhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbX9CdZsrSDSTCSH+72yNFRXCXz10vu4DwG4CihF9pRuLa3D/Bo1nIFzVSBHCnEzFDvHW14zDdLaddGME5jEPYMV6uETo=
X-Gm-Message-State: AOJu0YzAm4LcxO142lB6oVqDhaA2LB1R20c89fHZ6nr3/kRjbrPMptay
 7+pUQUfczSdr4fh17ajslq6dtGDSTGkWuaZU2n7wDnEuUPvuZfaPC98DcLAEDDFYqJirD8sCmMS
 oyTxPgsrQ5g==
X-Google-Smtp-Source: AGHT+IEj8GCo+IbiANve4/bCNmi371BRoA/fg9TKCeM4M5PMW6xDcZ0z3SvSF5drxusLGLqWu1vRWpm0Sx4zgg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:2508:b0:dc6:c2e4:5126 with SMTP
 id dt8-20020a056902250800b00dc6c2e45126mr2169190ybb.12.1711361719941; Mon, 25
 Mar 2024 03:15:19 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:03 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-8-smostafa@google.com>
Subject: [RFC PATCH 07/12] hw/arm/smmu-common: Support nested translation
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3t04BZggKCpAC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com;
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

When nested translation is requested, we need  to do:

- Translate stage-1 IPA using stage-2 to a physical address.
- Translate stage-1 PTW walks using stage-2.
- Combine both to create a single TLB entry

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 135 ++++++++++++++++++++++++++++-------
 hw/arm/trace-events          |   2 +-
 include/hw/arm/smmu-common.h |   3 +-
 3 files changed, 113 insertions(+), 27 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index f0905c28cf..da8776ecec 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -119,7 +119,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
                               tg, new->level, stage_tag);
     trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                            tg, new->level, stage_tag);
+                            tg, new->level, new->entry.addr_mask, stage_tag);
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
@@ -305,6 +305,27 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
     return NULL;
 }
 
+/* Return the correct table address based on configuration. */
+static inline int translate_table_s1(dma_addr_t *table_addr, SMMUTransCfg *cfg,
+                                     SMMUPTWEventInfo *info, SMMUState *bs)
+{
+    dma_addr_t addr = *table_addr;
+    SMMUTLBEntry *cached_entry;
+
+    if (cfg->stage != SMMU_NESTED) {
+        return 0;
+    }
+
+    CALL_FUNC_CFG_S2(cfg, cached_entry, smmu_translate,
+                     bs, cfg, addr, IOMMU_RO, info);
+
+    if (cached_entry) {
+        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
+        return 0;
+    }
+    return -EINVAL;
+}
+
 /**
  * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
  * @cfg: translation config
@@ -320,7 +341,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  */
 static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                           dma_addr_t iova, IOMMUAccessFlags perm,
-                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
+                          SMMUState *bs)
 {
     dma_addr_t baseaddr, indexmask;
     SMMUStage stage = cfg->stage;
@@ -368,6 +390,10 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                 goto error;
             }
             baseaddr = get_table_pte_address(pte, granule_sz);
+            /* In case of failure, retain stage-2 fault. */
+            if (translate_table_s1(&baseaddr, cfg, info, bs)) {
+                goto error_no_stage;
+            }
             level++;
             continue;
         } else if (is_page_pte(pte, level)) {
@@ -403,7 +429,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = iova & ~mask;
         tlbe->entry.addr_mask = mask;
-        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
+        tlbe->parent_perm = tlbe->entry.perm = PTE_AP_TO_PERM(ap);
         tlbe->level = level;
         tlbe->granule = granule_sz;
         return 0;
@@ -412,6 +438,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
 
 error:
     info->stage = SMMU_STAGE_1;
+error_no_stage:
     tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
@@ -524,7 +551,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = ipa & ~mask;
         tlbe->entry.addr_mask = mask;
-        tlbe->entry.perm = s2ap;
+        tlbe->parent_perm = tlbe->entry.perm = s2ap;
         tlbe->level = level;
         tlbe->granule = granule_sz;
         return 0;
@@ -537,6 +564,35 @@ error:
     return -EINVAL;
 }
 
+/* Combine 2 TLB enteries and return in tlbe. */
+static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
+                        dma_addr_t iova, SMMUTransCfg *cfg)
+{
+        if (cfg->stage == SMMU_NESTED) {
+
+            /*
+             * tg and level are used from stage-1, while the addr mask can be
+             * smaller in case stage-2 size(based on granule and level) was
+             * smaller than stage-1.
+             * That should have no impact on:
+             * - lookup: as iova is properly aligned with the stage-1 level and
+             *   granule.
+             * - Invalidation: as it uses the entry mask.
+             */
+            tlbe->entry.addr_mask = MIN(tlbe->entry.addr_mask,
+                                        tlbe_s2->entry.addr_mask);
+            tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
+                                          tlbe->entry.translated_addr);
+
+            /* parent_perm has s2 perm while perm has s1 perm. */
+            tlbe->parent_perm = tlbe_s2->entry.perm;
+            return;
+        }
+
+        /* That was not nested, use the s2. */
+        memcpy(tlbe, tlbe_s2, sizeof(*tlbe));
+}
+
 /**
  * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
  *
@@ -549,28 +605,59 @@ error:
  * return 0 on success
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
 {
-    if (cfg->stage == SMMU_STAGE_1) {
-        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
-    } else if (cfg->stage == SMMU_STAGE_2) {
-        /*
-         * If bypassing stage 1(or unimplemented), the input address is passed
-         * directly to stage 2 as IPA. If the input address of a transaction
-         * exceeds the size of the IAS, a stage 1 Address Size fault occurs.
-         * For AA64, IAS = OAS according to (IHI 0070.E.a) "3.4 Address sizes"
-         */
-        if (iova >= (1ULL << cfg->oas)) {
-            info->type = SMMU_PTW_ERR_ADDR_SIZE;
-            info->stage = SMMU_STAGE_1;
-            tlbe->entry.perm = IOMMU_NONE;
-            return -EINVAL;
+    int ret = 0;
+    SMMUTLBEntry tlbe_s2;
+    dma_addr_t ipa = iova;
+
+    if (cfg->stage & SMMU_STAGE_1) {
+        ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
+        if (ret) {
+            return ret;
         }
+        /* This is the IPA for next stage.*/
+        ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
+    }
+
+    /*
+     * The address output from the translation causes a stage 1 Address Size
+     * fault if it exceeds the range of the effective IPA size for the given CD.
+     * If bypassing stage 1(or unimplemented), the input address is passed
+     * directly to stage 2 as IPA. If the input address of a transaction
+     * exceeds the size of the IAS, a stage 1 Address Size fault occurs.
+     * For AA64, IAS = OAS according to (IHI 0070.E.a) "3.4 Address sizes"
+     */
+    if (ipa >= (1ULL << cfg->oas)) {
+        info->type = SMMU_PTW_ERR_ADDR_SIZE;
+        info->stage = SMMU_STAGE_1;
+        tlbe->entry.perm = IOMMU_NONE;
+        return -EINVAL;
+    }
 
-        return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
+    if (cfg->stage & SMMU_STAGE_2) {
+        ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
+        if (ret) {
+            return ret;
+        }
+        combine_tlb(tlbe, &tlbe_s2, iova, cfg);
     }
 
-    g_assert_not_reached();
+    return ret;
+}
+
+static int validate_tlb_entry(SMMUTLBEntry *cached_entry, IOMMUAccessFlags flag,
+                              SMMUPTWEventInfo *info)
+{
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
+            cached_entry->parent_perm & IOMMU_WO)) {
+            info->type = SMMU_PTW_ERR_PERMISSION;
+            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
+                          SMMU_STAGE_1 :
+                          SMMU_STAGE_2;
+            return -EINVAL;
+        }
+        return 0;
 }
 
 SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
@@ -614,16 +701,14 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
 
     cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
     if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
-            info->type = SMMU_PTW_ERR_PERMISSION;
-            info->stage = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
+        if (validate_tlb_entry(cached_entry, flag, info)) {
             return NULL;
         }
         return cached_entry;
     }
 
     cached_entry = g_new0(SMMUTLBEntry, 1);
-    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
+    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
     if (status) {
             g_free(cached_entry);
             return NULL;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 34b10af83f..215df91ea3 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -18,7 +18,7 @@ smmu_iotlb_inv_stage(int stage) "Stage invalidate stage=%d"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, int stage) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d stage=%d"
+smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, uint64_t mask, int stage) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d mask=0x%"PRIx64" stage=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index c0969e461d..4f9505d91c 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -91,6 +91,7 @@ typedef struct SMMUTLBEntry {
     IOMMUTLBEntry entry;
     uint8_t level;
     uint8_t granule;
+    IOMMUAccessFlags parent_perm;
 } SMMUTLBEntry;
 
 /* Stage-2 configuration. */
@@ -199,7 +200,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * pair, according to @cfg translation config
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
 
 
 /* smmu_translate - Look for a translation in TLB, if not, do a PTW. */
-- 
2.44.0.396.g6e790dbe36-goog


