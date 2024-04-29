Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162EFC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdV-0000TO-Il; Sun, 28 Apr 2024 23:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BxMvZggKCiIQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com>)
 id 1s1HdT-0000S7-N8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:59 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BxMvZggKCiIQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com>)
 id 1s1HdR-00040l-1a
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:59 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-41bd87bb458so9899875e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361095; x=1714965895; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4DCf3/0y5iNAG3sQ+Ensu4vclHCTV4/Csx27RH2Mf/w=;
 b=fNI/cHWwZXFGeOPyQBdKlnvfagLwNABzIfuex4N3fbmmMI0Ehfv3bGzQrekGcOeJqY
 Vnot2fL2Q2+ZadNEI7w6GoBgfOnwsCManRxyUhBg4C6zfvkzX6jL/vPk68qykCIziuvg
 9iYio02v5FZueCwhNCbrvjpOdVpWJIN5i/JD/MvX4toEg+DjeTxG4c6GpxXqfQGYuskX
 cs8xTK2iaisM3G/wG093w1S07bD8fUmni6F/V+cyNwMkaRJvRgoTm9A9ZRRp7DR7rE+h
 /VLrOAb1vgUJpD6w2F9QpVFEMjCzZv+6+TuZV2hjA0hasrJ7bXtuqV8+GwZeojfpg1iC
 CiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361095; x=1714965895;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4DCf3/0y5iNAG3sQ+Ensu4vclHCTV4/Csx27RH2Mf/w=;
 b=F/6So6hpk/FBTvb6DqTGtBquPvkv6iOKl8TdVKK6GdiXXkWNlDlamaBbCALYIm/uAF
 zVncH/jn92wPuzDInFJOnTNgF4q7msiLwXsRbEeIkbDD3O21Mxa7cXm6WhHTT/EYsL0R
 HgKqZOsBy7RLeQU2hJeJ7gmGVO+q+JrFy+py1QTKHL42amIP4Kh6vIOP71kvNegJORS1
 GlML7iM+uxVCGCVWtuOvv3cfBq8P7ECY+8rkFxzzfiqhZW0xRT9mFO57XkpuBNZDqEpp
 qjzsDUF+I3VskvD2pOAsQmjLTvdit7AagavwPXMSyLNczVtHSAWLemLjCqTh4bzmdIGj
 YwPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrdV7ojwOKFkHhRALPSglcIxU3KBb5Wx2BoadXd5rsaI2yLY3K/GsoC2HuANz2vfKk5gIA7vQIZl4jKmNZ4fFIJ+AUe3E=
X-Gm-Message-State: AOJu0YxxLoFS2iXYHsITfP7R64b26TixPBA0swIZ3LMmuNzxJE/2H2r7
 e5/RFjuEnt0zd0lK6Z/rwXaH9Ohhuy5rR/Vr+Nb0886PL2qE0adLWfXHkPhq2nnzDIjyRCrpElv
 g1L/p+vfSQQ==
X-Google-Smtp-Source: AGHT+IG4v8PHU0eSOLRDOK5EuqIpfDoj/wpK8XcWd8BJnZchGbsNWDX/3LQoyih3WdrJTTMwYCDlvUh3JICMpg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:4f41:b0:41c:2c5c:6e1b with SMTP
 id m1-20020a05600c4f4100b0041c2c5c6e1bmr7966wmq.6.1714361095208; Sun, 28 Apr
 2024 20:24:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:54 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-11-smostafa@google.com>
Subject: [RFC PATCH v3 10/18] hw/arm/smmu-common: Support nested translation
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3BxMvZggKCiIQKMQR8D8EMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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

- Translate stage-1 IPA using stage-2 to a physical address.
- Translate stage-1 table walks using stage-2.
- Combine both to create a single TLB entry using the logic
  introduced before.

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
 hw/arm/smmu-common.c         | 67 ++++++++++++++++++++++++++++++------
 include/hw/arm/smmu-common.h |  2 +-
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index c67af3bc6d..d48ec08947 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -306,6 +306,32 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
     return NULL;
 }
 
+/* Translate stage-1 table address using stage-2 page table. */
+static inline int translate_table_s1(dma_addr_t *table_addr, SMMUTransCfg *cfg,
+                                     SMMUPTWEventInfo *info, SMMUState *bs)
+{
+    dma_addr_t addr = *table_addr;
+    SMMUTLBEntry *cached_entry;
+    int asid;
+
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
@@ -321,7 +347,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  */
 static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                           dma_addr_t iova, IOMMUAccessFlags perm,
-                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
+                          SMMUState *bs)
 {
     dma_addr_t baseaddr, indexmask;
     SMMUStage stage = cfg->stage;
@@ -369,6 +396,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                 goto error;
             }
             baseaddr = get_table_pte_address(pte, granule_sz);
+            if (cfg->stage == SMMU_NESTED) {
+                if (translate_table_s1(&baseaddr, cfg, info, bs)) {
+                    goto error;
+                }
+            }
             level++;
             continue;
         } else if (is_page_pte(pte, level)) {
@@ -551,10 +583,8 @@ error:
 }
 
 /* combine 2 TLB entries and return in tlbe in nested config. */
-static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
-                                                SMMUTLBEntry *tlbe_s2,
-                                                dma_addr_t iova,
-                                                SMMUTransCfg *cfg)
+static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
+                        dma_addr_t iova, SMMUTransCfg *cfg)
 {
     if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
         tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
@@ -579,14 +609,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
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
@@ -600,11 +635,23 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
             tlbe->entry.perm = IOMMU_NONE;
             return -EINVAL;
         }
-
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
@@ -660,7 +707,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
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
2.44.0.769.g3c40516874-goog


