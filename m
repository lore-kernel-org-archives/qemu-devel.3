Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1151EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdR-0000Qe-0L; Sun, 28 Apr 2024 23:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AxMvZggKCh4MGIMN494AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--smostafa.bounces.google.com>)
 id 1s1HdO-0000Pj-SA
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:54 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AxMvZggKCh4MGIMN494AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--smostafa.bounces.google.com>)
 id 1s1HdN-0003zq-4s
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:54 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-41c23f368e4so2484675e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361091; x=1714965891; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ZpCcezp9/fTsowCTsySf9fmY/aXn95QjnE0/b0e/YVQ=;
 b=ygNC5oKBiMUufdxC8bi/VlH/hIn+HYKTYs17Dnz7CjVXRCrdllkvWgq0br+ugEDqQ5
 p/oh1zu0+EeVM71A+EAPhrp2J1vKvJiY4U9y/pksT+/Y0zisx1C8nuzP9ME4Gc4iYH0r
 SIo0oxVFeTgDk8Q8If/cPKk3pqEAdMTl7zkr1s5YnfeMLU0qawJJnlW05pXWbjGZKnkQ
 FODXU5yiW2T7F0V26gFX34bUFD1Cli/JMyxY2Y8pEGAuW2ennCLqe/KpyXqGzCMJb0l6
 p67pb9a72IBwDT1/wV+EmP1jQYvEPGhmc5V7Pg2mVvsJKN93EWP6J0eJdtanY6Sac6ia
 jKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361091; x=1714965891;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZpCcezp9/fTsowCTsySf9fmY/aXn95QjnE0/b0e/YVQ=;
 b=OONb0Ac7J04+EdJo9gOEdtVd2e8cNdLNPwSXn4lLWbD+2gqyYb4NjTYvpFJH/EHYmi
 4bYgqE+UE1V5TitmIuEhzzAnRERRkW7gEAxrOzpYnfAmkk6b0w2cJj9nTvTf2qigMBbA
 KDY+2XAkCcKEYkZlbghozkcnvQ7XxORKXwDYJqDruqu9VDsZc1tzcqa74Wc9yLELlQXW
 pP3X/40wgpw4yuG6Gl6LdNag0EaBYjqD4XACAwmGXKBfGpopTSu0slmQ21Gg8FSX7ODf
 4nQGpTLktt8calpHfp5uou40Ggv7kjgRTZdLMPhbZr8iD6aHQ0JNuyGP5KWA/1pSJ/PD
 jHkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJoFH9Bo62vlXuxVxuIKP1ThSLMb7fdEX5LQIgNaXYgp45wkS2GeUIB+CJJdQRSl96ZBlHvewzGkAgkRSSKZRJMfgn49Q=
X-Gm-Message-State: AOJu0YzZm7CDLBOGWUkgsfYssrFUXG+59X//myYxYkBxbmbPjbmjgGLy
 At7lJB89appTUZdY8hhdJaDaW3o7ypO1Ma9i8OJ1pXz1ZP33cIceKX6Wxj7JS7A2OdJHYYOeoga
 w3rb54QXUyA==
X-Google-Smtp-Source: AGHT+IFlmFvm8bFLPkRmQqZHSTw5edCekNmbTGPI6RjgH4IB4gxI0vAC1L48k37Wl9JBTfaWcoeZ653OKbEgJQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:2294:b0:418:16b2:a3a4 with SMTP
 id 20-20020a05600c229400b0041816b2a3a4mr41283wmf.3.1714361091028; Sun, 28 Apr
 2024 20:24:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:52 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-9-smostafa@google.com>
Subject: [RFC PATCH v3 08/18] hw/arm/smmu-common: Add support for nested TLB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3AxMvZggKCh4MGIMN494AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x349.google.com
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

This patch adds support for nested(combined) TLB entries.
The main function combine_tlb() is not used here but in the next
patches, but to simplify the patches it is introduced first.

Main changes:
1) New entry added in the TLB, parent_perm, for nested TLB, holds the
   stage-2 permission, this can be used to know the origin of a
   permission fault from a cached entry as caching the =E2=80=9Cand=E2=80=
=9D of the
   permissions loses this information.

   SMMUPTWEventInfo is used to hold information about PTW faults so
   the event can be populated, the value of stage (which maps to S2
   in the event) used to be set based on the current stage for TLB
   permission faults, however with the parent_perm, it is now set
   based on which perm has the missing permission

   When nesting is not enabled it has the same value as perm which
   doesn't change the logic.

2) As combined TLB implementation is used, the combination logic
   chooses:
   - tg and level from the entry which has the smallest addr_mask.
   - Based on that the iova that would be cached is recalculated.
   - Translated_addr is chosen from stage-2.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 32 ++++++++++++++++++++++++++++----
 include/hw/arm/smmu-common.h |  1 +
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 21982621c0..0d6945fa54 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -394,7 +394,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr =3D gpa;
         tlbe->entry.iova =3D iova & ~mask;
         tlbe->entry.addr_mask =3D mask;
-        tlbe->entry.perm =3D PTE_AP_TO_PERM(ap);
+        tlbe->parent_perm =3D tlbe->entry.perm =3D PTE_AP_TO_PERM(ap);
         tlbe->level =3D level;
         tlbe->granule =3D granule_sz;
         return 0;
@@ -515,7 +515,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr =3D gpa;
         tlbe->entry.iova =3D ipa & ~mask;
         tlbe->entry.addr_mask =3D mask;
-        tlbe->entry.perm =3D s2ap;
+        tlbe->parent_perm =3D tlbe->entry.perm =3D s2ap;
         tlbe->level =3D level;
         tlbe->granule =3D granule_sz;
         return 0;
@@ -530,6 +530,27 @@ error:
     return -EINVAL;
 }
=20
+/* combine 2 TLB entries and return in tlbe in nested config. */
+static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
+                                                SMMUTLBEntry *tlbe_s2,
+                                                dma_addr_t iova,
+                                                SMMUTransCfg *cfg)
+{
+    if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
+        tlbe->entry.addr_mask =3D tlbe_s2->entry.addr_mask;
+        tlbe->granule =3D tlbe_s2->granule;
+        tlbe->level =3D tlbe_s2->level;
+    }
+
+    tlbe->entry.translated_addr =3D CACHED_ENTRY_TO_ADDR(tlbe_s2,
+                                    tlbe->entry.translated_addr);
+
+    tlbe->entry.iova =3D iova & ~tlbe->entry.addr_mask;
+    /* parent_perm has s2 perm while perm has s1 perm. */
+    tlbe->parent_perm =3D tlbe_s2->entry.perm;
+    return;
+}
+
 /**
  * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
  *
@@ -607,9 +628,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransC=
fg *cfg, dma_addr_t addr,
=20
     cached_entry =3D smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr=
);
     if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
+            cached_entry->parent_perm & IOMMU_WO)) {
             info->type =3D SMMU_PTW_ERR_PERMISSION;
-            info->stage =3D cfg->stage;
+            info->stage =3D !(cached_entry->entry.perm & IOMMU_WO) ?
+                          SMMU_STAGE_1 :
+                          SMMU_STAGE_2;
             return NULL;
         }
         return cached_entry;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 09d3b9e734..1db566d451 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -77,6 +77,7 @@ typedef struct SMMUTLBEntry {
     IOMMUTLBEntry entry;
     uint8_t level;
     uint8_t granule;
+    IOMMUAccessFlags parent_perm;
 } SMMUTLBEntry;
=20
 /* Stage-2 configuration. */
--=20
2.44.0.769.g3c40516874-goog


