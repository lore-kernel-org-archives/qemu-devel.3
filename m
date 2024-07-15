Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1342AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHL8-0004WL-1A; Mon, 15 Jul 2024 04:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3s-GUZggKCgYysuyzglgmuumrk.iuswks0-jk1krtutmt0.uxm@flex--smostafa.bounces.google.com>)
 id 1sTHL6-0004Py-D6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:44 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3s-GUZggKCgYysuyzglgmuumrk.iuswks0-jk1krtutmt0.uxm@flex--smostafa.bounces.google.com>)
 id 1sTHL4-00042w-1y
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:44 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-367879e8395so2482941f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033140; x=1721637940; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SZUG8vWPgda5JSi+0ivMM+5unzE39DmY473Vl+6Kelo=;
 b=fDowARojT6I1rCRJWJvphSK+cTdjVzTmUPjskmKf0lCs7UI6gh4wccUAiwsgA3bi9p
 twmncISEvXDzKvfMbM94jCbPX92EV93DZ/lIbvUCEOgyQCnVDHVAEYWHS2y9ur6O6a5S
 YoBsmuw4MSFm2h70LSAWin6wXtCmPfwiDlte9RuHMWTCnr1VjryMa7F5w40XeQ8MIRrC
 AiW/Hb2GHxNedr2YYfnkREKi+zWs3Yazu4K6xvLnLxXIpudDnB0CxDdvkXnNO0X9jZfC
 5/uzz/wUOb/TNCO8L8FTDkp/ZR9JtBuRyU78ZXkpalMSMC3/K0XV9i5RFtx5v+pniV3K
 /yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033140; x=1721637940;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SZUG8vWPgda5JSi+0ivMM+5unzE39DmY473Vl+6Kelo=;
 b=wYeBcSFG2ToLJ2xq1wzG+QFHhM0pDU6ejUNycCbfsiMaKoIxVE4xd6x4oI3A0h15PO
 1utmqNdX5hQ9GSXU8EtqoDSlqA91oKOuz8BSFjtgrt9x2wv/PLdSeYXj/CNgwZBepAnU
 JviZLtVHDf9f0jD8uq8/UYMxaUSiR4NhKe/hag+F5SHV1QM4xIbNKScJY6xt6zYfI8X6
 VNI0H76G+kurLB+QQt9oAL3g1DxGVpvlBlY3HxchRNmFjtIddht4UapUGHK/qYUuNt2Q
 moVsimzH7k6fEdMMz4QPxEO2BLRJFSWTEX4b4obfN7oASRc/wRGtraZsQ2jK+SF/QFok
 XMBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJApxxqVFYGe7ozxOeI86LGfmX5S97aZGTsRneU250n462pk2hBx/w1OD8jjFcBNED+/DIKYgV+yQFRV+XkoU4+N3JZiM=
X-Gm-Message-State: AOJu0Yxj/5h3usAN8TCSxcB4jcPaFZFPhgiiPtQYYtHwp4mVrM7S6EeR
 dcNLpWGYXgAcbl7f8JVSmotKvFB8q6GgfV2F2fROwt41s/opIldxoAvenPaj/0i8TM5c+k+eImw
 jH9KQClkAwQ==
X-Google-Smtp-Source: AGHT+IF6GpSx1mFVuW1s4Flz2crSW1GVcnmEUD7rSfSF9TQ82o/hPJywFaCcKyUDbOKOR5EhU0THgfWaSxGWrw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:5002:0:b0:367:904a:fae9 with SMTP id
 ffacd0b85a97d-367cea8eca8mr33300f8f.7.1721033139639; Mon, 15 Jul 2024
 01:45:39 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:05 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-6-smostafa@google.com>
Subject: [PATCH v5 05/18] hw/arm/smmu: Split smmuv3_translate()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3s-GUZggKCgYysuyzglgmuumrk.iuswks0-jk1krtutmt0.uxm@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
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

smmuv3_translate() does everything from STE/CD parsing to TLB lookup
and PTW.

Soon, when nesting is supported, stage-1 data (tt, CD) needs to be
translated using stage-2.

Split smmuv3_translate() to 3 functions:

- smmu_translate(): in smmu-common.c, which does the TLB lookup, PTW,
  TLB insertion, all the functions are already there, this just puts
  them together.
  This also simplifies the code as it consolidates event generation
  in case of TLB lookup permission failure or in TT selection.

- smmuv3_do_translate(): in smmuv3.c, Calls smmu_translate() and does
  the event population in case of errors.

- smmuv3_translate(), now calls smmuv3_do_translate() for
  translation while the rest is the same.

Also, add stage in trace_smmuv3_translate_success()

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         |  59 +++++++++++
 hw/arm/smmuv3.c              | 194 +++++++++++++----------------------
 hw/arm/trace-events          |   2 +-
 include/hw/arm/smmu-common.h |   8 ++
 4 files changed, 142 insertions(+), 121 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8a5858f69f..d94db6b34f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -566,6 +566,65 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
     g_assert_not_reached();
 }
 
+SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
+                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
+{
+    uint64_t page_mask, aligned_addr;
+    SMMUTLBEntry *cached_entry = NULL;
+    SMMUTransTableInfo *tt;
+    int status;
+
+    /*
+     * Combined attributes used for TLB lookup, as only one stage is supported,
+     * it will hold attributes based on the enabled stage.
+     */
+    SMMUTransTableInfo tt_combined;
+
+    if (cfg->stage == SMMU_STAGE_1) {
+        /* Select stage1 translation table. */
+        tt = select_tt(cfg, addr);
+        if (!tt) {
+            info->type = SMMU_PTW_ERR_TRANSLATION;
+            info->stage = SMMU_STAGE_1;
+            return NULL;
+        }
+        tt_combined.granule_sz = tt->granule_sz;
+        tt_combined.tsz = tt->tsz;
+
+    } else {
+        /* Stage2. */
+        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
+        tt_combined.tsz = cfg->s2cfg.tsz;
+    }
+
+    /*
+     * TLB lookup looks for granule and input size for a translation stage,
+     * as only one stage is supported right now, choose the right values
+     * from the configuration.
+     */
+    page_mask = (1ULL << tt_combined.granule_sz) - 1;
+    aligned_addr = addr & ~page_mask;
+
+    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
+    if (cached_entry) {
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
+            info->type = SMMU_PTW_ERR_PERMISSION;
+            info->stage = cfg->stage;
+            return NULL;
+        }
+        return cached_entry;
+    }
+
+    cached_entry = g_new0(SMMUTLBEntry, 1);
+    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
+    if (status) {
+            g_free(cached_entry);
+            return NULL;
+    }
+    smmu_iotlb_insert(bs, cfg, cached_entry);
+    return cached_entry;
+}
+
 /**
  * The bus number is used for lookup when SID based invalidation occurs.
  * In that case we lazily populate the SMMUPciBus array from the bus hash
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7e9874b4a6..85a3efd357 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -827,6 +827,76 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     g_hash_table_remove(bc->configs, sdev);
 }
 
+/* Do translation with TLB lookup. */
+static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
+                                                 SMMUTransCfg *cfg,
+                                                 SMMUEventInfo *event,
+                                                 IOMMUAccessFlags flag,
+                                                 SMMUTLBEntry **out_entry)
+{
+    SMMUPTWEventInfo ptw_info = {};
+    SMMUState *bs = ARM_SMMU(s);
+    SMMUTLBEntry *cached_entry = NULL;
+
+    cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
+    if (!cached_entry) {
+        /* All faults from PTW has S2 field. */
+        event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
+        switch (ptw_info.type) {
+        case SMMU_PTW_ERR_WALK_EABT:
+            event->type = SMMU_EVT_F_WALK_EABT;
+            event->u.f_walk_eabt.addr = addr;
+            event->u.f_walk_eabt.rnw = flag & 0x1;
+            event->u.f_walk_eabt.class = (ptw_info.stage == SMMU_STAGE_2) ?
+                                          SMMU_CLASS_IN : SMMU_CLASS_TT;
+            event->u.f_walk_eabt.addr2 = ptw_info.addr;
+            break;
+        case SMMU_PTW_ERR_TRANSLATION:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_TRANSLATION;
+                event->u.f_translation.addr = addr;
+                event->u.f_translation.addr2 = ptw_info.addr;
+                event->u.f_translation.class = SMMU_CLASS_IN;
+                event->u.f_translation.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_ADDR_SIZE:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_ADDR_SIZE;
+                event->u.f_addr_size.addr = addr;
+                event->u.f_addr_size.addr2 = ptw_info.addr;
+                event->u.f_addr_size.class = SMMU_CLASS_IN;
+                event->u.f_addr_size.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_ACCESS:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_ACCESS;
+                event->u.f_access.addr = addr;
+                event->u.f_access.addr2 = ptw_info.addr;
+                event->u.f_access.class = SMMU_CLASS_IN;
+                event->u.f_access.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_PERMISSION:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_PERMISSION;
+                event->u.f_permission.addr = addr;
+                event->u.f_permission.addr2 = ptw_info.addr;
+                event->u.f_permission.class = SMMU_CLASS_IN;
+                event->u.f_permission.rnw = flag & 0x1;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return SMMU_TRANS_ERROR;
+    }
+    *out_entry = cached_entry;
+    return SMMU_TRANS_SUCCESS;
+}
+
+/* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
 {
@@ -836,12 +906,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
                            .inval_ste_allowed = false};
-    SMMUPTWEventInfo ptw_info = {};
     SMMUTranslationStatus status;
-    SMMUState *bs = ARM_SMMU(s);
-    uint64_t page_mask, aligned_addr;
-    SMMUTLBEntry *cached_entry = NULL;
-    SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
@@ -850,11 +915,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
-    /*
-     * Combined attributes used for TLB lookup, as only one stage is supported,
-     * it will hold attributes based on the enabled stage.
-     */
-    SMMUTransTableInfo tt_combined;
+    SMMUTLBEntry *cached_entry = NULL;
 
     qemu_mutex_lock(&s->mutex);
 
@@ -883,115 +944,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    if (cfg->stage == SMMU_STAGE_1) {
-        /* Select stage1 translation table. */
-        tt = select_tt(cfg, addr);
-        if (!tt) {
-            if (cfg->record_faults) {
-                event.type = SMMU_EVT_F_TRANSLATION;
-                event.u.f_translation.addr = addr;
-                event.u.f_translation.rnw = flag & 0x1;
-            }
-            status = SMMU_TRANS_ERROR;
-            goto epilogue;
-        }
-        tt_combined.granule_sz = tt->granule_sz;
-        tt_combined.tsz = tt->tsz;
-
-    } else {
-        /* Stage2. */
-        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
-        tt_combined.tsz = cfg->s2cfg.tsz;
-    }
-    /*
-     * TLB lookup looks for granule and input size for a translation stage,
-     * as only one stage is supported right now, choose the right values
-     * from the configuration.
-     */
-    page_mask = (1ULL << tt_combined.granule_sz) - 1;
-    aligned_addr = addr & ~page_mask;
-
-    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
-    if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
-            status = SMMU_TRANS_ERROR;
-            /*
-             * We know that the TLB only contains either stage-1 or stage-2 as
-             * nesting is not supported. So it is sufficient to check the
-             * translation stage to know the TLB stage for now.
-             */
-            event.u.f_walk_eabt.s2 = (cfg->stage == SMMU_STAGE_2);
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_PERMISSION;
-                event.u.f_permission.addr = addr;
-                event.u.f_permission.rnw = flag & 0x1;
-            }
-        } else {
-            status = SMMU_TRANS_SUCCESS;
-        }
-        goto epilogue;
-    }
-
-    cached_entry = g_new0(SMMUTLBEntry, 1);
-
-    if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
-        /* All faults from PTW has S2 field. */
-        event.u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
-        g_free(cached_entry);
-        switch (ptw_info.type) {
-        case SMMU_PTW_ERR_WALK_EABT:
-            event.type = SMMU_EVT_F_WALK_EABT;
-            event.u.f_walk_eabt.addr = addr;
-            event.u.f_walk_eabt.rnw = flag & 0x1;
-            /* Stage-2 (only) is class IN while stage-1 is class TT */
-            event.u.f_walk_eabt.class = (ptw_info.stage == SMMU_STAGE_2) ?
-                                         SMMU_CLASS_IN : SMMU_CLASS_TT;
-            event.u.f_walk_eabt.addr2 = ptw_info.addr;
-            break;
-        case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_TRANSLATION;
-                event.u.f_translation.addr = addr;
-                event.u.f_translation.addr2 = ptw_info.addr;
-                event.u.f_translation.class = SMMU_CLASS_IN;
-                event.u.f_translation.rnw = flag & 0x1;
-            }
-            break;
-        case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_ADDR_SIZE;
-                event.u.f_addr_size.addr = addr;
-                event.u.f_addr_size.addr2 = ptw_info.addr;
-                event.u.f_translation.class = SMMU_CLASS_IN;
-                event.u.f_addr_size.rnw = flag & 0x1;
-            }
-            break;
-        case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_ACCESS;
-                event.u.f_access.addr = addr;
-                event.u.f_access.addr2 = ptw_info.addr;
-                event.u.f_translation.class = SMMU_CLASS_IN;
-                event.u.f_access.rnw = flag & 0x1;
-            }
-            break;
-        case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_PERMISSION;
-                event.u.f_permission.addr = addr;
-                event.u.f_permission.addr2 = ptw_info.addr;
-                event.u.f_translation.class = SMMU_CLASS_IN;
-                event.u.f_permission.rnw = flag & 0x1;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        status = SMMU_TRANS_ERROR;
-    } else {
-        smmu_iotlb_insert(bs, cfg, cached_entry);
-        status = SMMU_TRANS_SUCCESS;
-    }
+    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
 
 epilogue:
     qemu_mutex_unlock(&s->mutex);
@@ -1002,7 +955,8 @@ epilogue:
                                     (addr & cached_entry->entry.addr_mask);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
-                                       entry.translated_addr, entry.perm);
+                                       entry.translated_addr, entry.perm,
+                                       cfg->stage);
         break;
     case SMMU_TRANS_DISABLE:
         entry.perm = flag;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f1a54a02df..cc12924a84 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -37,7 +37,7 @@ smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
 smmuv3_translate_disable(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x bypass (smmu disabled) iova:0x%"PRIx64" is_write=%d"
 smmuv3_translate_bypass(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x STE bypass iova:0x%"PRIx64" is_write=%d"
 smmuv3_translate_abort(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x abort on iova:0x%"PRIx64" is_write=%d"
-smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=0x%x iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
+smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm, int stage) "%s sid=0x%x iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x stage=%d"
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b3c881f0ee..5944735632 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -183,6 +183,14 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
              SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
 
+
+/*
+ * smmu_translate - Look for a translation in TLB, if not, do a PTW.
+ * Returns NULL on PTW error or incase of TLB permission errors.
+ */
+SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
+                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info);
+
 /**
  * select_tt - compute which translation table shall be used according to
  * the input iova and translation config and return the TT specific info
-- 
2.45.2.993.g49e7a77208-goog


