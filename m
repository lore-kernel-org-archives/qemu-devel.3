Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CC6C3065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEqj-0004bC-Ah; Mon, 01 Jul 2024 07:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AY2CZggKCmAQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com>)
 id 1sOEp8-0002Ec-Ti
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:59 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AY2CZggKCmAQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com>)
 id 1sOEoo-0005PE-G3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:47 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-424a5a5f024so19457175e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831810; x=1720436610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Fv7BS8g4xDe926Dlz2fnWNVQmTCy2c0vTs9ZGBz2UIg=;
 b=mXSSSNhe7qAqwtYuTIjwq9yS0Qz06w2TUiPPyxMqMB7d3GdyEAZtF+V9A58h3FGS2T
 +qxb7aYpVkANgw0lngLxd6miLHsoLbhhVMO/Sx1JbJvrr2Buotk9RiupM3D007/QtjyK
 be1912yopEzOQtPwgyO46B1soXrZ1ldWYgrxMakzV207qXBx9XTi5IwZKOnS2fwvytrR
 W1UBcYY0xLS7OYNy+PPKihvTmOo+44JpcBxwVMeGfv8oSIl0/wKJSBxhAVeIuBSo1p29
 hIkAWqOnevNP6H9d3y4lAk1wILoCctf6i5tfZzdwLt/uI6fKz0uKsnH0k5a3wNIYYdF8
 gnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831810; x=1720436610;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fv7BS8g4xDe926Dlz2fnWNVQmTCy2c0vTs9ZGBz2UIg=;
 b=RrFBBIyJpO46FHsvLjiAHx1M+wLdF0be/iiJ95w98T68ZomDUtVP+6LgnI0fPG3sR+
 nfMGNL4y48Qqp9lQhdE7g5M4yA+twk34Y2bBeH3ypSnzVG+FgqNV33e7ug7k667CKUEe
 zdkCz7opzsYcZhSl/FTYekb0XvTtdimdyS2JUb805ay1tB+QsUZNYrGjuNpZIoSQzzNp
 NonArWv+ZgpfTNDhBqMBraoi0fS9A1GCg55Gk2IQnQ9ufHBYlkLBsAewrZ/Me8rgm7cw
 5aWrAlC0yN+7x4BBHipPa3bQaRLf8awq11vL9mB5yJfujnKnKANmPRcleIWAJXqP5xel
 nA1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSo9RLWae97O7fNmjErBmgNZp+9XN/tttBrahVUqsyPqyQ+YK0nYpK+Rcb+uW4J/SkcMnw6jtDymDC9D+4tlyHU9vwcQQ=
X-Gm-Message-State: AOJu0YzzZkPyO3g0iKRvWoKRCdWUu4umJZQkO4A5Mx5EH8CLxsGHtHBm
 7kKqnk7lsTRyHzjGCDtMzNTX4l7lqeb3FY2drLjOEJ0jr+KCJd8CtWYu1uADLg8RkMOqE7+X9TW
 LCgbjBlknUQ==
X-Google-Smtp-Source: AGHT+IHwm67bAhBHv7dJZUN8mCt5SQ4ipmxn5RP6+ZSGDsNtAPHR5mMXCnUqaTODAsL9//V8EkKSbx487kpj0Q==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:19c9:b0:424:9c77:4dfd with SMTP
 id 5b1f17b1804b1-4257a06c738mr538705e9.7.1719831809978; Mon, 01 Jul 2024
 04:03:29 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:32 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-11-smostafa@google.com>
Subject: [PATCH v4 10/19] hw/arm/smmu-common: Add support for nested TLB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3AY2CZggKCmAQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com;
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

This patch adds support for nested (combined) TLB entries.
The main function combine_tlb() is not used here but in the next
patches, but to simplify the patches it is introduced first.

Main changes:
1) New field added in the SMMUTLBEntry struct: parent_perm, for
   nested TLB, holds the stage-2 permission, this can be used to know
   the origin of a permission fault from a cached entry as caching
   the =E2=80=9Cand=E2=80=9D of the permissions loses this information.

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

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++++++++++++----
 include/hw/arm/smmu-common.h |  1 +
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0840b5cffd..24b7d09e2b 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -426,7 +426,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr =3D gpa;
         tlbe->entry.iova =3D iova & ~mask;
         tlbe->entry.addr_mask =3D mask;
-        tlbe->entry.perm =3D PTE_AP_TO_PERM(ap);
+        tlbe->parent_perm =3D PTE_AP_TO_PERM(ap);
+        tlbe->entry.perm =3D tlbe->parent_perm;
         tlbe->level =3D level;
         tlbe->granule =3D granule_sz;
         return 0;
@@ -547,7 +548,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         tlbe->entry.translated_addr =3D gpa;
         tlbe->entry.iova =3D ipa & ~mask;
         tlbe->entry.addr_mask =3D mask;
-        tlbe->entry.perm =3D s2ap;
+        tlbe->parent_perm =3D s2ap;
+        tlbe->entry.perm =3D tlbe->parent_perm;
         tlbe->level =3D level;
         tlbe->granule =3D granule_sz;
         return 0;
@@ -562,6 +564,30 @@ error:
     return -EINVAL;
 }
=20
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
+        tlbe->entry.addr_mask =3D tlbe_s2->entry.addr_mask;
+        tlbe->granule =3D tlbe_s2->granule;
+        tlbe->level =3D tlbe_s2->level;
+    }
+
+    tlbe->entry.translated_addr =3D CACHED_ENTRY_TO_ADDR(tlbe_s2,
+                                    tlbe->entry.translated_addr);
+
+    tlbe->entry.iova =3D iova & ~tlbe->entry.addr_mask;
+    /* parent_perm has s2 perm while perm keeps s1 perm. */
+    tlbe->parent_perm =3D tlbe_s2->entry.perm;
+    return;
+}
+
 /**
  * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
  *
@@ -639,9 +665,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransC=
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
2.45.2.803.g4e1b14247a-goog


