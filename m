Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C13C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEqX-0004En-Us; Mon, 01 Jul 2024 07:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BI2CZggKCmMTNPTUBGBHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--smostafa.bounces.google.com>)
 id 1sOEpF-0002FH-0a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:02 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BI2CZggKCmMTNPTUBGBHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--smostafa.bounces.google.com>)
 id 1sOEp6-0005Pj-Sb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:56 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-424a5a5f024so19457405e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831812; x=1720436612; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pLiLD9Y6hPJK630FI36/76GCsbQcYnRJXZm5rXlVToQ=;
 b=GCNBLMC6Y+wKL9Bw8MDypCXbl/tHLQmxw4xa2BEywfnnVu5h8PXaJVm0TPuP1bedsx
 GlTYM1WwxdtUxjRijeHAvvXNpW2YP6iTnrttqYQve2D/VM4ASlkefNT676YvKU9tXeLO
 CnxCpBnAAROFmSZokfuAhWJ12U8u/D1MFipTzGtpjmJogLeCHZrGfFkJJzjJlpknDj1/
 UIbzTZcLldGlKfmP8k5OjsO3GzRgn9Mx7ReuwW22CCzK2qp5rc+YQoXB/vKYWXGlBr/T
 8siJftHqvFicmgzZ7yYkwmeHlSPTAHOIpCHTvdj6+rNDD6BLxT80yiQ61OFEdfN60Asq
 upgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831812; x=1720436612;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLiLD9Y6hPJK630FI36/76GCsbQcYnRJXZm5rXlVToQ=;
 b=Glp15LGqc41HvrCM1ehQTf3E0ZFzunE3AcdJeh7f2PJuzI5z4mA0jHHIuTNKLrz2nH
 epQ74zqVl1OztDVFcMUKPjT8Vhjukw78jC5Zaadz5Cso5FoWCOo92RPt0q3Lv8esVoSd
 +qq0PvdILiP220Uq8wj2YIsIZbHjiv8qnC7bs5KaCiGztTFmkQKVn/EPiu+W1H7nphl9
 dvwWz0ZYRSRGGIwWpJgNwx3D1hil1IWRI1RJEUpXyv+DHbYaO8pG3uXZaSPMeLGL3PlN
 vVx3m39lGU8Tsw9ZjdNcaMnJi7DW2Npdkw+avki3QJyXRcrFQ34E91oyWLYGD2il69cm
 9Qfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUGhU9/9H5mzbhB9dpDAVn3W4yG1uPGS1Cqam2yjn22hAxKvL/cY+g9TfTiUOHMDs/c2RWY3fJlldjkYkJE6yvUaZJgws=
X-Gm-Message-State: AOJu0Yy7C34IYUU1CAccwOFZn+BcGzyw5wsan6nTbkzI3Jk6ihQ6QoOD
 x7RPepfxcTf7p8F6VbpmOzT6kITjAtHnlOnpafoBct+4zIuNSF8U4VcKBUMNW5rH4WyWsMLcOJF
 hkQZiAhYcRw==
X-Google-Smtp-Source: AGHT+IE4M0AH42DOJTFwqeKXn9/m3zipf6JPuJXv8nEERd3pFQpf4gLR85Sf9TFoqxGMP/qmIIN/R/SHi/kXyQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6000:1445:b0:366:ebf5:c6cb with SMTP
 id ffacd0b85a97d-3677571b760mr8352f8f.11.1719831812129; Mon, 01 Jul 2024
 04:03:32 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:33 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-12-smostafa@google.com>
Subject: [PATCH v4 11/19] hw/arm/smmu-common: Support nested translation
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3BI2CZggKCmMTNPTUBGBHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--smostafa.bounces.google.com;
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

When nested translation is requested, do the following:

- Translate stage-1 table address IPA into PA through stage-2.
- Translate stage-1 table walk output (IPA) through stage-2.
- Create a single TLB entry from stage-1 and stage-2 translations
  using logic introduced before.

For stage-1 table translation, the spec (ARM IHI 0070 F.b) says in:
    7.3.12 F_WALK_EABT:
        Translation of an IPA for Stage 1 descriptor fetch:
	S2 == 1 (stage 2), CLASS == T
So, F_WALK_EABT is used which propagtes to CLASS == TT.

smmu_ptw() has a new argument SMMUState which include the TLB as
stage-1 table address can be cached in there.

Also in smmu_ptw() a separate path used for nesting to simplify the
code, although some logic can be combined.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 72 +++++++++++++++++++++++++++++++-----
 include/hw/arm/smmu-common.h |  2 +-
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 24b7d09e2b..71afd486ba 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -318,6 +318,38 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
     return NULL;
 }
 
+/* Translate stage-1 table address using stage-2 page table. */
+static inline int translate_table_addr_ipa(dma_addr_t *table_addr,
+                                           SMMUTransCfg *cfg,
+                                           SMMUPTWEventInfo *info,
+                                           SMMUState *bs)
+{
+    dma_addr_t addr = *table_addr;
+    SMMUTLBEntry *cached_entry;
+    int asid;
+
+    /*
+     * The translation table walks performed from TTB0 or TTB1 are always
+     * performed in IPA space if stage 2 translations are enabled.
+     */
+    asid = cfg->asid;
+    cfg->stage = SMMU_STAGE_2;
+    cfg->asid = -1;
+    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
+    cfg->asid = asid;
+    cfg->stage = SMMU_NESTED;
+
+    if (cached_entry) {
+        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
+        return 0;
+    }
+
+    info->stage = SMMU_STAGE_2;
+    info->type = SMMU_PTW_ERR_WALK_EABT;
+    info->addr = addr;
+    return -EINVAL;
+}
+
 /**
  * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
  * @cfg: translation config
@@ -333,7 +365,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  */
 static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                           dma_addr_t iova, IOMMUAccessFlags perm,
-                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
+                          SMMUState *bs)
 {
     dma_addr_t baseaddr, indexmask;
     SMMUStage stage = cfg->stage;
@@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                 goto error;
             }
             baseaddr = get_table_pte_address(pte, granule_sz);
+            if (cfg->stage == SMMU_NESTED) {
+                if (translate_table_addr_ipa(&baseaddr, cfg, info, bs)) {
+                    goto error;
+                }
+            }
             level++;
             continue;
         } else if (is_page_pte(pte, level)) {
@@ -568,10 +606,8 @@ error:
  * combine S1 and S2 TLB entries into a single entry.
  * As a result the S1 entry is overriden with combined data.
  */
-static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
-                                                SMMUTLBEntry *tlbe_s2,
-                                                dma_addr_t iova,
-                                                SMMUTransCfg *cfg)
+static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
+                        dma_addr_t iova, SMMUTransCfg *cfg)
 {
     if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
         tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
@@ -596,14 +632,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
  * @perm: tentative access type
  * @tlbe: returned entry
  * @info: ptw event handle
+ * @bs: smmu state which includes TLB instance
  *
  * return 0 on success
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
 {
+    int ret;
+    SMMUTLBEntry tlbe_s2;
+    dma_addr_t ipa;
+
     if (cfg->stage == SMMU_STAGE_1) {
-        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
+        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
     } else if (cfg->stage == SMMU_STAGE_2) {
         /*
          * If bypassing stage 1(or unimplemented), the input address is passed
@@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
         return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
     }
 
-    g_assert_not_reached();
+    /* SMMU_NESTED. */
+    ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
+    if (ret) {
+        return ret;
+    }
+
+    ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
+    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
+    if (ret) {
+        return ret;
+    }
+
+    combine_tlb(tlbe, &tlbe_s2, iova, cfg);
+    return 0;
 }
 
 SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
@@ -677,7 +731,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
     }
 
     cached_entry = g_new0(SMMUTLBEntry, 1);
-    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
+    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
     if (status) {
             g_free(cached_entry);
             return NULL;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 1db566d451..cf0fd3ec74 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -185,7 +185,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * pair, according to @cfg translation config
  */
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
+             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
 
 
 /*
-- 
2.45.2.803.g4e1b14247a-goog


