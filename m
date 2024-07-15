Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC66C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLM-0005UY-Sx; Mon, 15 Jul 2024 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3weGUZggKChQC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1sTHLJ-0005J0-V0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:58 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3weGUZggKChQC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1sTHLH-00046c-Vv
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:57 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so3648328f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033153; x=1721637953; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=l0Soo9RWetj5yxS136m2PIQhSOE18Tim7cY2xe4qkxM=;
 b=I5CVSe3fC1sI6xPVut3XnT9dYsY0zfv6shT1W562n7P4yP7F35YTtEp9JnMCFXW5T4
 WjIZc16TAlq75OEcZ6PTpnyWlw3GRYq0yw+ag2YnTAMYfVAs+zuHZjALPewuVf5+NmQc
 3jT2sKGQI3m/mlg0/3DMNRuCNYfN+uSMtWPu4oribIJtiDdl4/izACW/xI9L3zKTFmXA
 eUyF6qysVWr4On1k0KhuHB1YGR7ID5oDAwJENMt2qD3b3bjyiq0rSFiKWhSnv53Ji4qp
 f/zCUn9grXJGpI1Q9QZI4SVg8UfUbhsko1PglyyvsRhx9g9+nLSzMQeW/O+kud/P+s3Z
 HQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033153; x=1721637953;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0Soo9RWetj5yxS136m2PIQhSOE18Tim7cY2xe4qkxM=;
 b=Bvjaz6jZztfCF10x0J7hk6ctCRQEKRzVZkkkUGgR3lNF7br6OFI/odOQ1KiqG8UJit
 8z/L297jm+Ii9vU2KrmIVbesWsKOIssYsxlG7Ar96Mx0JCgjhSljQrg5G+6HviT+jpqp
 omm0HJ3MerI1iOEmQ6V+AdWgyFv68He6iybxfkhKxW42eT/ecWGts+9mdyr5BuJgHKp7
 UQ+zHl4NY1SiRmKQAWKsWigawAflMFJU4Rsq4+JfFlqLFQH4kt57QUns0/YZ19LQxQXV
 ARpUfn4iax+gNPXakTOqKLOjCJ9/ED1Y654Pfr6c9hEGQV8WxWRBPmkHsAeNrcREISz0
 onlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD5JDUnm63XDKobx/DU0LwjnqA/gB7zGYIMwP2chds1k3IWUrvINhRs9w0mqLCGOemACzwAuhO0Bj57A0i/IPjuUYiYHk=
X-Gm-Message-State: AOJu0YyoDNYro8kO2J8mOYNJxX9vJgHVZgF0qpwlcqfTNmMYogyUX8a5
 328W3Jp+9yp7fZ8zcWpTR0FmBhHu7+Vk3NcAr0o2GLR+7AQof9Jlf5G2gmLlupygrtzdhgr6skY
 HOAH6kZXTBA==
X-Google-Smtp-Source: AGHT+IFb/6ITOtb9CoGhqXNQ6F5+1aO1YUAiqFhf0rBwObaxua+cZuRYKSBiB4nawtbP5DTzrT0RfTqP1LwAlQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:5542:0:b0:367:f0f2:66c2 with SMTP id
 ffacd0b85a97d-367f0f27d02mr21798f8f.2.1721033153477; Mon, 15 Jul 2024
 01:45:53 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:11 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-12-smostafa@google.com>
Subject: [PATCH v5 11/18] hw/arm/smmu-common: Support nested translation
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3weGUZggKChQC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
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

When nested translation is requested, do the following:
- Translate stage-1 table address IPA into PA through stage-2.
- Translate stage-1 table walk output (IPA) through stage-2.
- Create a single TLB entry from stage-1 and stage-2 translations
  using logic introduced before.

smmu_ptw() has a new argument SMMUState which include the TLB as
stage-1 table address can be cached in there.

Also in smmu_ptw(), a separate path used for nesting to simplify the
code, although some logic can be combined.

With nested translation class of translation fault can be different,
from the class of the translation, as faults from translating stage-1
tables are considered as CLASS_TT and not CLASS_IN, a new member
"is_ipa_descriptor" added to "SMMUPTWEventInfo" to differ faults
from walking stage 1 translation table and faults from translating
an IPA for a transaction.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 74 +++++++++++++++++++++++++++++++-----
 hw/arm/smmuv3.c              | 14 +++++++
 include/hw/arm/smmu-common.h |  7 ++--
 3 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index c894c4c621..8ed53f5b1d 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -318,8 +318,41 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
     return NULL;
 }
 
+/* Translate stage-1 table address using stage-2 page table. */
+static inline int translate_table_addr_ipa(SMMUState *bs,
+                                           dma_addr_t *table_addr,
+                                           SMMUTransCfg *cfg,
+                                           SMMUPTWEventInfo *info)
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
+    info->addr = addr;
+    info->is_ipa_descriptor = true;
+    return -EINVAL;
+}
+
 /**
  * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
+ * @bs: smmu state which includes TLB instance
  * @cfg: translation config
  * @iova: iova to translate
  * @perm: access type
@@ -331,7 +364,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  * Upon success, @tlbe is filled with translated_addr and entry
  * permission rights.
  */
-static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
+static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
                           dma_addr_t iova, IOMMUAccessFlags perm,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
@@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                 goto error;
             }
             baseaddr = get_table_pte_address(pte, granule_sz);
+            if (cfg->stage == SMMU_NESTED) {
+                if (translate_table_addr_ipa(bs, &baseaddr, cfg, info)) {
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
@@ -591,6 +627,7 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
 /**
  * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
  *
+ * @bs: smmu state which includes TLB instance
  * @cfg: translation configuration
  * @iova: iova to translate
  * @perm: tentative access type
@@ -599,11 +636,15 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
  *
  * return 0 on success
  */
-int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
+             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
+    int ret;
+    SMMUTLBEntry tlbe_s2;
+    dma_addr_t ipa;
+
     if (cfg->stage == SMMU_STAGE_1) {
-        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
+        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
     } else if (cfg->stage == SMMU_STAGE_2) {
         /*
          * If bypassing stage 1(or unimplemented), the input address is passed
@@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
         return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
     }
 
-    g_assert_not_reached();
+    /* SMMU_NESTED. */
+    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
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
@@ -667,7 +721,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
     }
 
     cached_entry = g_new0(SMMUTLBEntry, 1);
-    status = smmu_ptw(cfg, addr, flag, cached_entry, info);
+    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info);
     if (status) {
             g_free(cached_entry);
             return NULL;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 73d5a25705..06a96c65eb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -910,6 +910,20 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
+        /*
+         * Fault class is set as follows based on "class" input to
+         * the function and to "ptw_info" from "smmu_translate()"
+         * For stage-1:
+         *   - EABT => CLASS_TT (hardcoded)
+         *   - other events => CLASS_IN (input to function)
+         * For stage-2 => CLASS_IN (input to function)
+         * For nested, for all events:
+         *  - CD fetch => CLASS_CD (input to function)
+         *  - walking stage 1 translation table  => CLASS_TT (from
+         *    is_ipa_descriptor or input in case of TTBx)
+         *  - s2 translation => CLASS_IN (input to function)
+         */
+        class = ptw_info.is_ipa_descriptor ? SMMU_CLASS_TT : class;
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event->type = SMMU_EVT_F_WALK_EABT;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index d84de64122..a3e6ab1b36 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -63,6 +63,7 @@ typedef struct SMMUPTWEventInfo {
     SMMUStage stage;
     SMMUPTWEventType type;
     dma_addr_t addr; /* fetched address that induced an abort, if any */
+    bool is_ipa_descriptor; /* src for fault in nested translation. */
 } SMMUPTWEventInfo;
 
 typedef struct SMMUTransTableInfo {
@@ -184,9 +185,9 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * smmu_ptw - Perform the page table walk for a given iova / access flags
  * pair, according to @cfg translation config
  */
-int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
-
+int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
+             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe,
+             SMMUPTWEventInfo *info);
 
 /*
  * smmu_translate - Look for a translation in TLB, if not, do a PTW.
-- 
2.45.2.993.g49e7a77208-goog


