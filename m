Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A731AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdN-0000P1-G9; Sun, 28 Apr 2024 23:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ABMvZggKChsJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com>)
 id 1s1HdM-0000Oc-VY
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:52 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ABMvZggKChsJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com>)
 id 1s1HdK-0003y7-Qo
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:52 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-41ab62f535aso20145795e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361089; x=1714965889; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=sM959CSryem/ayjlI+rG1SS7UxOtrLI/cpqbk+ueezU=;
 b=p1vaSfwGpQtOUxmQCZTqIg5gw2od7ZkRbnDX9t6QtII8aroCZ3K4ndFpDiQlKKLHH0
 s/WBb2OTpfwG/ysCZB//RXDfwwf2I3tHPiN0YX/DL4W5hdXhqeekPJKF/tgbiPMxZEe3
 7FIkL/rHdrgN8J1d98w88UM0akZpChd4FvuADH/NkY6DsDSXdpnnLWxDPoQk9jbKj6mm
 muj1IJHaA3dj2gby/SM94oc2n3ZHAQzymTE7RNWnSZ3TBBDYehK+HjN1gU4D3L29DXsy
 ruU81znZMnhBHNbXqc4R8mVoKzfdwWWX4Af3sYc9nnfMZmZy1ak3jhM593Z5F8zBpwY2
 Ww9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361089; x=1714965889;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sM959CSryem/ayjlI+rG1SS7UxOtrLI/cpqbk+ueezU=;
 b=uG/JW7lDK0ktosx3M61h6a4E9b7f9VvgeenojJoT5uaOMsYpRCq4FZv3KUs8yYNqHT
 fptMZdxscaQoAgKr4IRhOvslbakHfYSBbWjGgw+WRRdLmKCmaOUAcWEUuiqooaHJJpNR
 MSlhHEn94pmczgVw7AFGApIe/I93Alq7vm/xnIoHxLCC3pWTnlsiCPc6gxhXdpJClBX0
 NWd9d17Qc9i9fdqsjAHaWokfS/kIa/Ikb5j05Rn5m98Eg4JM8b4RRAQh/yEgN5FRWnM8
 sBD668r/XZsbQxzumpK7tsjs5kVtzMWXLKoNHtWpT9RMpo5XtU1cnQl3orVt8qwCdoHd
 jLeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYgArAjxnDHL2gKjtHVVwKVsrytO/FJUGB9icEnQp8dYxLWGgC3XDsqEmoQCvk9jWW493eNxuDkEArH+ATW1zHDlQaYv0=
X-Gm-Message-State: AOJu0Yw/SGmDwFKMT8EuYBz/XYFVNjDXYsS5QjfqccjoVQtlvuyvsjqC
 tylPK90fvFkDX9cQbKJ5+E9vd3sZttzs8wtiuXB8NLntLN+dtiYtgJoiMkwkMT4aCHjuql3ElGC
 caiTph4bPCA==
X-Google-Smtp-Source: AGHT+IEjvBy+g/621KlqAkrShcOgfXu6z3bLCLFkSJkmuXKtqWSHz6ZYIXTZgabGfZjxv+i0SKPvRK1+JDyXwg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:216:b0:41a:a78e:f90d with SMTP
 id 22-20020a05600c021600b0041aa78ef90dmr17940wmi.5.1714361088900; Sun, 28 Apr
 2024 20:24:48 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:51 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-8-smostafa@google.com>
Subject: [RFC PATCH v3 07/18] hw/arm/smmuv3: Translate CD and TT using stage-2
 table
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3ABMvZggKChsJDFJK1617FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--smostafa.bounces.google.com;
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

According to ARM SMMU architecture specification (ARM IHI 0070 F.b),
In "5.2 Stream Table Entry":
 [51:6] S1ContextPtr
 If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
 stage 2 and the programmed value must be within the range of the IAS.

In "5.4.1 CD notes":
 The translation table walks performed from TTB0 or TTB1 are always performed
 in IPA space if stage 2 translations are enabled.

This patch implements translation of the S1 context descriptor pointer and
TTBx base addresses through the S2 stage (IPA -> PA)

smmuv3_do_translate() is updated to have one arg which is translation
class, this is useful for:
 - Decide wether a translation is stage-2 only or use the STE config.
 - Populate the class in case of faults, WALK_EABT is lefat as it as
   it is always triggered from TT access so no need to use the input
   class.

In case for stage-2 only translation, which only used in nesting, the
stage and asid are saved and restored before and after calling
smmu_translate().

Translating CD or TTBx can fail for the following reasons:
1) Large address size: This is described in
   (3.4.3 Address sizes of SMMU-originated accesses)
   - For CD ptr larger than IAS, for SMMUv3.1, it can trigger either
     C_BAD_STE or Translation fault, we implement the latter as it
     requires no extra code.
   - For TTBx, if larger than the effective stage 1 output address size, it
     triggers C_BAD_CD.

2) Faults from PTWs (7.3 Event records)
   - F_ADDR_SIZE: large address size after first level causes stage 2 Address
     Size fault (Also in 3.4.3 Address sizes of SMMU-originated accesses)
   - F_PERMISSION: Same as an address translation. However, when
     CLASS == CD, the access is implicitly Data and a read.
   - F_ACCESS: Same as an address translation.
   - F_TRANSLATION: Same as an address translation.
   - F_WALK_EABT: Same as an address translation.
  These are already implemented in the PTW logic, so no extra handling
  required.

As, there is multiple locations where the address is calculated from
cached entry, a new macro is introduced CACHED_ENTRY_TO_ADDR.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c              | 76 ++++++++++++++++++++++++++++++------
 include/hw/arm/smmu-common.h |  3 ++
 2 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cc61708160..cc61c82321 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -337,14 +337,33 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
 }
 
+static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
+                                                 SMMUTransCfg *cfg,
+                                                 SMMUEventInfo *event,
+                                                 IOMMUAccessFlags flag,
+                                                 SMMUTLBEntry **out_entry,
+                                                 SMMUTranslationClass class);
 /* @ssid > 0 not supported yet */
-static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
-                       CD *buf, SMMUEventInfo *event)
+static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
+                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
 {
     dma_addr_t addr = STE_CTXPTR(ste);
     int ret, i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     trace_smmuv3_get_cd(addr);
+
+    if (cfg->stage == SMMU_NESTED) {
+        status = smmuv3_do_translate(s, addr, cfg, event,
+                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
+        if (status != SMMU_TRANS_SUCCESS) {
+            return -EINVAL;
+        }
+
+        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
+    }
+
     /* TODO: guarantee 64-bit single-copy atomicity */
     ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
                           MEMTXATTRS_UNSPECIFIED);
@@ -659,10 +678,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
     return 0;
 }
 
-static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
+static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
+                     CD *cd, SMMUEventInfo *event)
 {
     int ret = -EINVAL;
     int i;
+    SMMUTranslationStatus status;
+    SMMUTLBEntry *entry;
 
     if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
         goto bad_cd;
@@ -713,9 +735,21 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
         tt->tsz = tsz;
         tt->ttb = CD_TTB(cd, i);
+
         if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
             goto bad_cd;
         }
+
+        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
+        if (cfg->stage == SMMU_NESTED) {
+            status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
+                                         &entry, SMMU_CLASS_TT);
+            if (status != SMMU_TRANS_SUCCESS) {
+                return -EINVAL;
+            }
+            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
+        }
+
         tt->had = CD_HAD(cd, i);
         trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
@@ -767,12 +801,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return 0;
     }
 
-    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
+    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
     if (ret) {
         return ret;
     }
 
-    return decode_cd(cfg, &cd, event);
+    return decode_cd(s, cfg, &cd, event);
 }
 
 /**
@@ -832,13 +866,29 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                                                  SMMUTransCfg *cfg,
                                                  SMMUEventInfo *event,
                                                  IOMMUAccessFlags flag,
-                                                 SMMUTLBEntry **out_entry)
+                                                 SMMUTLBEntry **out_entry,
+                                                 SMMUTranslationClass class)
 {
     SMMUPTWEventInfo ptw_info = {};
     SMMUState *bs = ARM_SMMU(s);
     SMMUTLBEntry *cached_entry = NULL;
+    int asid, stage;
+    bool S2_only = class != SMMU_CLASS_IN;
+
+    if (S2_only) {
+        asid = cfg->asid;
+        stage = cfg->stage;
+        cfg->asid = -1;
+        cfg->stage = SMMU_STAGE_2;
+    }
 
     cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
+
+    if (S2_only) {
+        cfg->asid = asid;
+        cfg->stage = stage;
+    }
+
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
@@ -855,7 +905,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr = addr;
                 event->u.f_translation.addr2 = ptw_info.addr;
-                event->u.f_translation.class = SMMU_CLASS_IN;
+                event->u.f_translation.class = class;
                 event->u.f_translation.rnw = flag & 0x1;
             }
             break;
@@ -864,7 +914,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
-                event->u.f_addr_size.class = SMMU_CLASS_IN;
+                event->u.f_addr_size.class = class;
                 event->u.f_addr_size.rnw = flag & 0x1;
             }
             break;
@@ -873,7 +923,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr = addr;
                 event->u.f_access.addr2 = ptw_info.addr;
-                event->u.f_access.class = SMMU_CLASS_IN;
+                event->u.f_access.class = class;
                 event->u.f_access.rnw = flag & 0x1;
             }
             break;
@@ -882,7 +932,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr = addr;
                 event->u.f_permission.addr2 = ptw_info.addr;
-                event->u.f_permission.class = SMMU_CLASS_IN;
+                event->u.f_permission.class = class;
                 event->u.f_permission.rnw = flag & 0x1;
             }
             break;
@@ -943,15 +993,15 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
+    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
+                                 &cached_entry, SMMU_CLASS_IN);
 
 epilogue:
     qemu_mutex_unlock(&s->mutex);
     switch (status) {
     case SMMU_TRANS_SUCCESS:
         entry.perm = cached_entry->entry.perm;
-        entry.translated_addr = cached_entry->entry.translated_addr +
-                                    (addr & cached_entry->entry.addr_mask);
+        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
                                        entry.translated_addr, entry.perm,
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 96eb017e50..09d3b9e734 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -37,6 +37,9 @@
 #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
                                              VMSA_BIT_LVL(isz, strd, lvl)) - 1)
 
+#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
+                                             ((addr) & (ent)->entry.addr_mask);
+
 /*
  * Page table walk error types
  */
-- 
2.44.0.769.g3c40516874-goog


