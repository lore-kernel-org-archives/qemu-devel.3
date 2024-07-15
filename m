Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EF9C3DA5E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLD-0004sW-GC; Mon, 15 Jul 2024 04:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uuGUZggKCg05z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com>)
 id 1sTHLC-0004nE-4b
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:50 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uuGUZggKCg05z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com>)
 id 1sTHLA-000449-3I
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:49 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e03641334e0so6246333276.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033146; x=1721637946; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=wxZxNfjRZUpwmvOtz4Wu2qv05YP33LsxLrkQpvYzqVE=;
 b=3BeebQM8lAbo8LvOHpIkt0lnl3ONQ4/IopZ9/fezmHQhrFbTkWzf8bCr9gQVAl929p
 g/AOvstYd1bC24QOX77ewN1K5N39TJfc87Fm0az8H0CHu6xn1jN6ALsnUavrdt/Gr92H
 b6qv5GtsX5MOtPCqOgQqN3vlzoqZNAYX803Sdcx6V4ZEBSKLl1IjhF2qh0gQ0mslr/1Y
 24AVVitWo/ndshxIhfvGoiccJEe4Ysr6zNUC/uElsB8Go2ai4E0oL8wO1iU+uqBD9x2W
 fjqRAHmjlFznTCKpjK5v+/yZeRBh+mBsKmzEnkta064zcLlj2n8tes6wb56datADgvZI
 cNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033146; x=1721637946;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wxZxNfjRZUpwmvOtz4Wu2qv05YP33LsxLrkQpvYzqVE=;
 b=gUUi2/zHHDgfqfzc/cB/kfm4oKBbuk9S/SyKiPbecwEsFu9VUih/rmTmXeq8wrP7iz
 Zh91APVCBAKrMZSz9cH+yi7sCUnzYbrEs0VNaSMfQ7IeHlvVnF8LrkU/gQ3UnleaT0/E
 yfYutct9QJCAqQxcVTqHIJHk+kiE04e2pXN6oVR3Hiaev6PiKFEwVji8lpLvbBmCi4b1
 uw6m7YgbTN6x0sHm5WsnOa/4HjqQtLrW/Ia8LuQsUBVO1+WaJvWMXIf1Lva6hxPPkxsE
 17Ekh9Uw43gSG9Ml+fAhHFFlR4cKxAVBvUpaUn3TRGONkxDBugZU6dmZ3RYeuJWbRhZ6
 2m1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO6ydfzEwKLJBkNQZM2xIK5RsqUweD+PEGkHmQWT6RKmsBXoLrINWxpN2dEAEHevqGVpPioClAsqkzer5Yz1XcnUxFuA8=
X-Gm-Message-State: AOJu0Ywr9XilZDKWJqw0AKZP89OZ+JBBzghYJkLGwzbcsOJiGw/AB4vU
 4QAMQVEz8vb/DcvaZ9jM3AW49soHdJYMwle1k3KqRuXQq3z6mdwMW3cZZuBTnB44Ulzd33S9M/I
 Dat6xMCRzyA==
X-Google-Smtp-Source: AGHT+IHLZdGm1ekUbHw2StSDaICeaBacbRqo+Oq98G2yGaBQ/q7OP6DFpHlHEDSEPupzjbFbuGcKeyMPUsMfEA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:2b0d:b0:dda:d7cf:5c2c with SMTP
 id 3f1490d57ef6-e041b17798cmr35697276.13.1721033146319; Mon, 15 Jul 2024
 01:45:46 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:08 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-9-smostafa@google.com>
Subject: [PATCH v5 08/18] hw/arm/smmuv3: Translate CD and TT using stage-2
 table
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3uuGUZggKCg05z156nsnt11tyr.p1z3rz7-qr8ry010t07.14t@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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
class, this is useful to:
 - Decide wether a translation is stage-2 only or use the STE config.
 - Populate the class in case of faults, WALK_EABT is left unchanged
   for stage-1 as it is always IN, while stage-2 would match the
   used class (TT, IN, CD), this will change slightly when the ptw
   supports nested translation as it can also issue TT event with
   class IN.

In case for stage-2 only translation, used in the context of nested
translation, the stage and asid are saved and restored before and
after calling smmu_translate().

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

As in CD and TTBx translation context, the iova is not known, setting
the InputAddr was removed from "smmuv3_do_translate" and set after
from "smmuv3_translate" with the new function "smmuv3_fixup_event"

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c | 120 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 17 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3f2dfada44..73d5a25705 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -337,14 +337,35 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
 
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
+
+        /* Same PTW faults are reported but with CLASS = CD. */
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
@@ -659,10 +680,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
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
@@ -713,9 +737,26 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
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
+            /*
+             * Same PTW faults are reported but with CLASS = TT.
+             * If TTBx is larger than the effective stage 1 output addres
+             * size, it reports C_BAD_CD, which is handled by the above case.
+             */
+            if (status != SMMU_TRANS_SUCCESS) {
+                return -EINVAL;
+            }
+            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
+        }
+
         tt->had = CD_HAD(cd, i);
         trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
     }
@@ -767,12 +808,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
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
@@ -832,58 +873,80 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
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
+    bool desc_s2_translation = class != SMMU_CLASS_IN;
+
+    /*
+     * The function uses the argument class to identify which stage is used:
+     * - CLASS = IN: Means an input translation, determine the stage from STE.
+     * - CLASS = CD: Means the addr is an IPA of the CD, and it would be
+     *   translated using the stage-2.
+     * - CLASS = TT: Means the addr is an IPA of the stage-1 translation table
+     *   and it would be translated using the stage-2.
+     * For the last 2 cases instead of having intrusive changes in the common
+     * logic, we modify the cfg to be a stage-2 translation only in case of
+     * nested, and then restore it after.
+     */
+    if (desc_s2_translation) {
+        asid = cfg->asid;
+        stage = cfg->stage;
+        cfg->asid = -1;
+        cfg->stage = SMMU_STAGE_2;
+    }
 
     cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
+
+    if (desc_s2_translation) {
+        cfg->asid = asid;
+        cfg->stage = stage;
+    }
+
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event->type = SMMU_EVT_F_WALK_EABT;
-            event->u.f_walk_eabt.addr = addr;
             event->u.f_walk_eabt.rnw = flag & 0x1;
             event->u.f_walk_eabt.class = (ptw_info.stage == SMMU_STAGE_2) ?
-                                          SMMU_CLASS_IN : SMMU_CLASS_TT;
+                                          class : SMMU_CLASS_TT;
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
-                event->u.f_translation.addr = addr;
                 event->u.f_translation.addr2 = ptw_info.addr;
-                event->u.f_translation.class = SMMU_CLASS_IN;
+                event->u.f_translation.class = class;
                 event->u.f_translation.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
-                event->u.f_addr_size.addr = addr;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
-                event->u.f_addr_size.class = SMMU_CLASS_IN;
+                event->u.f_addr_size.class = class;
                 event->u.f_addr_size.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
-                event->u.f_access.addr = addr;
                 event->u.f_access.addr2 = ptw_info.addr;
-                event->u.f_access.class = SMMU_CLASS_IN;
+                event->u.f_access.class = class;
                 event->u.f_access.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
             if (PTW_RECORD_FAULT(cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
-                event->u.f_permission.addr = addr;
                 event->u.f_permission.addr2 = ptw_info.addr;
-                event->u.f_permission.class = SMMU_CLASS_IN;
+                event->u.f_permission.class = class;
                 event->u.f_permission.rnw = flag & 0x1;
             }
             break;
@@ -896,6 +959,27 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
     return SMMU_TRANS_SUCCESS;
 }
 
+/*
+ * Sets the InputAddr for an SMMU_TRANS_ERROR, as it can't be
+ * set from all contexts, as smmuv3_get_config() can return
+ * translation faults in case of nested translation (for CD
+ * and TTBx). But in that case the iova is not known.
+ */
+static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
+{
+    switch (event->type) {
+    case SMMU_EVT_F_WALK_EABT:
+    case SMMU_EVT_F_TRANSLATION:
+    case SMMU_EVT_F_ADDR_SIZE:
+    case SMMU_EVT_F_ACCESS:
+    case SMMU_EVT_F_PERMISSION:
+        event->u.f_walk_eabt.addr = iova;
+        break;
+    default:
+        break;
+    }
+}
+
 /* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
@@ -944,7 +1028,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
+    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
+                                 &cached_entry, SMMU_CLASS_IN);
 
 epilogue:
     qemu_mutex_unlock(&s->mutex);
@@ -975,6 +1060,7 @@ epilogue:
                                      entry.perm);
         break;
     case SMMU_TRANS_ERROR:
+        smmuv3_fixup_event(&event, addr);
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s translation failed for iova=0x%"PRIx64" (%s)\n",
                       mr->parent_obj.name, addr, smmu_event_string(event.type));
-- 
2.45.2.993.g49e7a77208-goog


