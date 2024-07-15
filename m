Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC6AC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLK-00050X-DJ; Mon, 15 Jul 2024 04:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vOGUZggKCg871378pupv33v0t.r315t19-stAt0232v29.36v@flex--smostafa.bounces.google.com>)
 id 1sTHLE-0004vC-11
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:52 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vOGUZggKCg871378pupv33v0t.r315t19-stAt0232v29.36v@flex--smostafa.bounces.google.com>)
 id 1sTHLC-00044Y-6V
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:51 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e03b3f48c65so7048779276.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033149; x=1721637949; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3aUfDOhGoD48EsXGKwPhz+ox5YDV1/R2ByBW8Z0WXWA=;
 b=hNkiBoYqV5Z4agpSZjGJrEkExALDO2cIhDd6ePOnkyagQgqzbLE099qyZMZU41SsNn
 FPs+KRv0br35NEE1rq7yt8tmE4O64fomYtaYrePpkArHRcRLygh1WUNuHCqxV66BYTbS
 EcE3v7aYsxtMqKZ/Wm7bJTE3+JvfVzQWSO83+Jy8Jjk+omq8AT5sKcRdlgtbEDj4mtdF
 KFBB+B+eD418cH4Ka0n2rc8vTJnmkuiBAGt87Y21lheu/mSogWGH2PgQmQS1ttb5zZdB
 1HkYc8E5zRs3OD1tUjgtPsgvve1yBYUzzdN4AQC0uookr1DVLdroeMk97dMpVqpaj0e1
 xkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033149; x=1721637949;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3aUfDOhGoD48EsXGKwPhz+ox5YDV1/R2ByBW8Z0WXWA=;
 b=HAWtGce4+YMczuWzbIuzFCzHcVtinrnTEeJmcb41dssVQfwmD/s4w+rikKCEEp/ww1
 rZV7rKg5SYc2FCtVBcqCZu8i7sovajGhZ1CS/UimFEmIxXoK78JWvR9YbRadp9d0Q9Hz
 a3ZttL7Hor4vP+Rw4DPQljSEn3+YZCicQ4J6he5Z3CbOxCirDof9/+4aoIpsubgIyOyy
 WaIohBaDxBdajWx+/oy/UsR09MmuBAwq+bUvS8ela528vg1OJiDiwegvVll+YwTQLVBg
 TWFMkEIy9ZcHLT00bCkx6b0nFcIcbC8a3CieTjrFtpE1Dr+jidecAei9ER3QnlNknphI
 I7mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLJ9uyuYB1h2XTlt9R/FVgjK1V76Rs+wMCxs9Lpq24bXbL4D4+PRceUGIzQqfAC+doO0OXxT5QtDODtG7TY0XsTJVKEXQ=
X-Gm-Message-State: AOJu0YyyBEDAcAPW4Nxi2ilcEOzFCn1Fi585eZ02S1dsq6keBC/I5brA
 PFs464eEmi+bGGKmeANwTLmI+y9faKn0CLI5gjNkdPUNkcPTDOvJkIuD1gHNnHielXRyrXwg9P/
 jZ1ZlDwcA3A==
X-Google-Smtp-Source: AGHT+IGWEFUxmFoLuy/ZqEx2uKEmQYuA0wK3l6hIfj9u1wnjpD2+xhI+HXhNPIOZI78rLWCWhV9urPFOnwj0QQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:154c:b0:de5:2694:45ba with SMTP
 id 3f1490d57ef6-e041af3e29emr859892276.0.1721033148547; Mon, 15 Jul 2024
 01:45:48 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:09 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-10-smostafa@google.com>
Subject: [PATCH v5 09/18] hw/arm/smmu-common: Rework TLB lookup for nesting
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3vOGUZggKCg871378pupv33v0t.r315t19-stAt0232v29.36v@flex--smostafa.bounces.google.com;
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

In the next patch, combine_tlb() will be added which combines 2 TLB
entries into one for nested translations, which chooses the granule
and level from the smallest entry.

This means that with nested translation, an entry can be cached with
the granule of stage-2 and not stage-1.

However, currently, the lookup for an IOVA is done with input stage
granule, which is stage-1 for nested configuration, which will not
work with the above logic.
This patch reworks lookup in that case, so it falls back to stage-2
granule if no entry is found using stage-1 granule.

Also, drop aligning the iova to avoid over-aligning in case the iova
is cached with a smaller granule, the TLB lookup will align the iova
anyway for each granule and level, and the page table walker doesn't
consider the page offset bits.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c | 64 +++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 21982621c0..f224e9c1e0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
     return key;
 }
 
-SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                SMMUTransTableInfo *tt, hwaddr iova)
+static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
+                                                  SMMUTransCfg *cfg,
+                                                  SMMUTransTableInfo *tt,
+                                                  hwaddr iova)
 {
     uint8_t tg = (tt->granule_sz - 10) / 2;
     uint8_t inputsize = 64 - tt->tsz;
@@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
         }
         level++;
     }
+    return entry;
+}
+
+/**
+ * smmu_iotlb_lookup - Look up for a TLB entry.
+ * @bs: SMMU state which includes the TLB instance
+ * @cfg: Configuration of the translation
+ * @tt: Translation table info (granule and tsz)
+ * @iova: IOVA address to lookup
+ *
+ * returns a valid entry on success, otherwise NULL.
+ * In case of nested translation, tt can be updated to include
+ * the granule of the found entry as it might different from
+ * the IOVA granule.
+ */
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                SMMUTransTableInfo *tt, hwaddr iova)
+{
+    SMMUTLBEntry *entry = NULL;
+
+    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    /*
+     * For nested translation also try the s2 granule, as the TLB will insert
+     * it if the size of s2 tlb entry was smaller.
+     */
+    if (!entry && (cfg->stage == SMMU_NESTED) &&
+        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
+        tt->granule_sz = cfg->s2cfg.granule_sz;
+        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    }
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -569,18 +601,21 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
 SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
                              IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
 {
-    uint64_t page_mask, aligned_addr;
     SMMUTLBEntry *cached_entry = NULL;
     SMMUTransTableInfo *tt;
     int status;
 
     /*
-     * Combined attributes used for TLB lookup, as only one stage is supported,
-     * it will hold attributes based on the enabled stage.
+     * Combined attributes used for TLB lookup, holds the attributes for
+     * the input stage.
      */
     SMMUTransTableInfo tt_combined;
 
-    if (cfg->stage == SMMU_STAGE_1) {
+    if (cfg->stage == SMMU_STAGE_2) {
+        /* Stage2. */
+        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
+        tt_combined.tsz = cfg->s2cfg.tsz;
+    } else {
         /* Select stage1 translation table. */
         tt = select_tt(cfg, addr);
         if (!tt) {
@@ -590,22 +625,9 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
         }
         tt_combined.granule_sz = tt->granule_sz;
         tt_combined.tsz = tt->tsz;
-
-    } else {
-        /* Stage2. */
-        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
-        tt_combined.tsz = cfg->s2cfg.tsz;
     }
 
-    /*
-     * TLB lookup looks for granule and input size for a translation stage,
-     * as only one stage is supported right now, choose the right values
-     * from the configuration.
-     */
-    page_mask = (1ULL << tt_combined.granule_sz) - 1;
-    aligned_addr = addr & ~page_mask;
-
-    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr);
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
@@ -616,7 +638,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
     }
 
     cached_entry = g_new0(SMMUTLBEntry, 1);
-    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
+    status = smmu_ptw(cfg, addr, flag, cached_entry, info);
     if (status) {
             g_free(cached_entry);
             return NULL;
-- 
2.45.2.993.g49e7a77208-goog


