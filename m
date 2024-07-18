Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1D3C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR46-0001QC-0r; Thu, 18 Jul 2024 09:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3o-0008Ey-Tp
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3m-0004Uf-Ne
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4267345e746so2778935e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308837; x=1721913637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6dTvjxai6uiJYWxFa2VnT/h+ITwv1YE0ztLSMd17uDg=;
 b=rf9zhmep8ClTsKZ96s22WqkH+2AM9rHs9darOnXL/3+5gqJxrwfpeW/GwHNAAdS6az
 61HkdRvoD6YZSyr9VaBu3F+PEAUH+m77jH/et8k46CNAmi22waTjxTrXER4GoXPz6qqk
 vSRI8NvWtPEGXoe+2b+/Z6wZhkdJFykBQeENF4r1gUkFYkf7AAG/Qz5w3P8wpJ+neCHI
 ZWnUQmEWauFnKikeTOEqWM6RZSIwMhdaLgnpSmQc7KVdsoXVSHJ32iPW+/NFaAT2VxU6
 7eaKBNepLB2e7mt+PdGbzU+499Qtc3JOLIKU/XdSt+3t5FNiyv4EHDrJg57CQmnSyeF8
 cbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308837; x=1721913637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dTvjxai6uiJYWxFa2VnT/h+ITwv1YE0ztLSMd17uDg=;
 b=qc8QCLdpmNON0T5VShtsD8+EotvaUCnmIiJITe83r2/SQhToWWqEySjk+MCGmnzQsR
 Mu+P75obQGs/Bp1wQOxcuwBy8hLti9mC3VXEtLOI7Bg+3eOZfZWY2pw6zmXOxmhq+FIM
 EtUebRIHcY61/W9fhdC5qeXfoV4gLdDoSkecol1/7yyVKTvk4Lo971N3S4JJM55wYCWX
 1X+ChnM6wlugZiB1onUq1Ej0/nOOSocx7+kKpnSqfl69UmiYvh5CIEMpAbuL0UnwVyI7
 XGy58LiKaN81pXnsD8lR/mhFd+Fsj6zwXKrkVl4z7Y42Xbh0F9z0DDh7z+7N1joNkpyQ
 k3aA==
X-Gm-Message-State: AOJu0Yx9UYZu9VAKkrW68Rqs1rAUjFGDjpLV1PCxzpCV7+qq6O5zpfz8
 7yupr/7RB8Sw6FXuwRkKmBbb+48rSc9ovM1M9511YF9GeTfyO33V2FUdmKL5mlr97IU9fWE39pw
 u
X-Google-Smtp-Source: AGHT+IGa8PWjPGz6zqt+YQpzonEoyL/w5O0j6qsh+S1q4bBpa4maJzO8APMvpi32O7gGHbR+A3V1/A==
X-Received: by 2002:a05:600c:154c:b0:426:67f0:b4f3 with SMTP id
 5b1f17b1804b1-427c2d1c6cfmr30194275e9.26.1721308836913; 
 Thu, 18 Jul 2024 06:20:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/26] hw/arm/smmu-common: Add support for nested TLB
Date: Thu, 18 Jul 2024 14:20:15 +0100
Message-Id: <20240718132028.697927-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mostafa Saleh <smostafa@google.com>

This patch adds support for nested (combined) TLB entries.
The main function combine_tlb() is not used here but in the next
patches, but to simplify the patches it is introduced first.

Main changes:
1) New field added in the SMMUTLBEntry struct: parent_perm, for
   nested TLB, holds the stage-2 permission, this can be used to know
   the origin of a permission fault from a cached entry as caching
   the “and” of the permissions loses this information.

   SMMUPTWEventInfo is used to hold information about PTW faults so
   the event can be populated, the value of stage used to be set
   based on the current stage for TLB permission faults, however
   with the parent_perm, it is now set based on which perm has
   the missing permission

   When nesting is not enabled it has the same value as perm which
   doesn't change the logic.

2) As combined TLB implementation is used, the combination logic
   chooses:
   - tg and level from the entry which has the smallest addr_mask.
   - Based on that the iova that would be cached is recalculated.
   - Translated_addr is chosen from stage-2.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-11-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index f793b54388d..08775364723 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -77,6 +77,7 @@ typedef struct SMMUTLBEntry {
     IOMMUTLBEntry entry;
     uint8_t level;
     uint8_t granule;
+    IOMMUAccessFlags parent_perm;
 } SMMUTLBEntry;
 
 /* Stage-2 configuration. */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e374cae0db6..bf55b9c5a42 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -426,7 +426,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = iova & ~mask;
         tlbe->entry.addr_mask = mask;
-        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
+        tlbe->parent_perm = PTE_AP_TO_PERM(ap);
+        tlbe->entry.perm = tlbe->parent_perm;
         tlbe->level = level;
         tlbe->granule = granule_sz;
         return 0;
@@ -547,7 +548,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr = gpa;
         tlbe->entry.iova = ipa & ~mask;
         tlbe->entry.addr_mask = mask;
-        tlbe->entry.perm = s2ap;
+        tlbe->parent_perm = s2ap;
+        tlbe->entry.perm = tlbe->parent_perm;
         tlbe->level = level;
         tlbe->granule = granule_sz;
         return 0;
@@ -562,6 +564,30 @@ error:
     return -EINVAL;
 }
 
+/*
+ * combine S1 and S2 TLB entries into a single entry.
+ * As a result the S1 entry is overriden with combined data.
+ */
+static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
+                                                SMMUTLBEntry *tlbe_s2,
+                                                dma_addr_t iova,
+                                                SMMUTransCfg *cfg)
+{
+    if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
+        tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
+        tlbe->granule = tlbe_s2->granule;
+        tlbe->level = tlbe_s2->level;
+    }
+
+    tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
+                                    tlbe->entry.translated_addr);
+
+    tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
+    /* parent_perm has s2 perm while perm keeps s1 perm. */
+    tlbe->parent_perm = tlbe_s2->entry.perm;
+    return;
+}
+
 /**
  * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
  *
@@ -629,9 +655,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
 
     cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr);
     if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
+            cached_entry->parent_perm & IOMMU_WO)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
-            info->stage = cfg->stage;
+            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
+                          SMMU_STAGE_1 :
+                          SMMU_STAGE_2;
             return NULL;
         }
         return cached_entry;
-- 
2.34.1


