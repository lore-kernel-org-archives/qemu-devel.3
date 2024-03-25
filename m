Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB46CD11DB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMJ-0004Hg-Mw; Mon, 25 Mar 2024 06:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rk4BZggKCoc3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1rohMI-0004Gp-Qq
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:14 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rk4BZggKCoc3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1rohMG-0004Xd-OC
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:14 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-33ec06aac83so2704268f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361711; x=1711966511; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0zs62To/zJ9W1gm3g27mxbClG/j+VvNKtNLClUaybGo=;
 b=cebLZazaRiz3AjVzYI8t0xDW88zklebAhIdeZyKQu65hvdBRO+tdBzSluADlmILDJz
 6h19Y+QTFiQkIJfAOj/D4L8pz3fiEbHI7Pdbf3akUMvdUrc/QOIqdUx2wMSSZLmYoPAW
 347kTICkHlCCkHkYAzMheGeqNzP4QOGJ4f3YqXXr2lt3PUh4qNhHL6qV4teuZD1medvP
 KW4Y+PI4u9/Y8raEZLIKXJ8lhBX+cJLwJhfluDyPERUqZ8EfXyXdt7X2Vq+Ap35X0sS7
 9aktlCRfdC39qpA/Vy6Uq5QIYkC7suzuVQ6FzEBs6ECKIFu11QFt1HJ4U7tHJtdmFBiw
 piBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361711; x=1711966511;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0zs62To/zJ9W1gm3g27mxbClG/j+VvNKtNLClUaybGo=;
 b=gdTGL3aEHlSaH5haoR2aObUB7zdDERdDHDjmJ0iqgZr0lYgnM2d+cKaX7owmtvymNx
 59yePsN1I2rQvHWf0+1m4hnnTi9SLAQXQCIM/LiIexas5vbQnc5/wQUCduWR5FL+LGGG
 eB53A8M5xfWNKaX2p51DMqaSASwRzAnAS2qaUuZJXAQM9QmeBz8utuH11eNddpvawx+/
 LLGMaga0lbRNdvxwYsOYhhWeQIuoHTK+QweocLIBlx03Y/M4M0mWgtpy/RV1cRgYvm7P
 rhCzZrZ4CHAA200ABHvbKGuhnkpogZPiAKUqz7QMVlPlJwe2jOwtslv315v1u4DEI4HK
 joiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0GJSfgCGpMoSE2HKnVzG7PX3T1AGxuTpgoE2AezZc/KUp/VKFjlad3kKvlXtXE0UhmkXGFaCF3RG/yxoDWBEiSamx2RA=
X-Gm-Message-State: AOJu0YwTednfZtv8Mbh6xixDEP33yJit4A35Uy476T08HN2KVRn6oa+3
 BdNcpvbfs9HpDkkZ9D9QKCMBgrX+eA99fdSR8GiRBLLvV04j/hiR/Unab22WMS8SBgO3r8y61s+
 43D/AFtWBCg==
X-Google-Smtp-Source: AGHT+IETeQArB2ujPLdn1ThPuCEai0FayXQZcRHfRnbXYtcbtk9yVNCMGU65XiYRHxNzju4oO1oSGeWj83gx9Q==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:4572:0:b0:33d:356f:fb82 with SMTP id
 a18-20020a5d4572000000b0033d356ffb82mr21524wrc.11.1711361710691; Mon, 25 Mar
 2024 03:15:10 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:13:59 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-4-smostafa@google.com>
Subject: [RFC PATCH 03/12] hw/arm/smmu: Add stage to TLB
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3rk4BZggKCoc3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com;
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

TLBs for nesting will be extended to be combined, a new index is added
"stage", with 2 valid values:
 - SMMU_STAGE_1: Meaning this translates VA to PADDR, this entry can
   be cached from fully nested configuration or from stage-1 only.
   We don't support separate cached entries (VA to IPA)

 - SMMU_STAGE_2: Meaning this translates IPA to PADDR, cached from
   stage-2 only configuration.

For TLB invalidation:
 - by VA: Invalidate TLBs tagged with SMMU_STAGE_1
 - by IPA: Invalidate TLBs tagged with SMMU_STAGE_2
 - All: Will invalidate both, this is communicated to the TLB as
   SMMU_NESTED which is (SMMU_STAGE_1 | SMMU_STAGE_2) which uses
   it as a mask.

This briefly described in the user manual (ARM IHI 0070 F.b) in
"16.2.1 Caching combined structures".

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 27 +++++++++++++++++----------
 hw/arm/smmu-internal.h       |  2 ++
 hw/arm/smmuv3.c              |  5 +++--
 hw/arm/trace-events          |  3 ++-
 include/hw/arm/smmu-common.h |  8 ++++++--
 5 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 20630eb670..677dcf9a13 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -38,7 +38,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid + key->vmid + key->level + key->tg;
+    a += key->asid + key->vmid + key->level + key->tg + key->stage;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -54,14 +54,14 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
 
     return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
            (k1->level == k2->level) && (k1->tg == k2->tg) &&
-           (k1->vmid == k2->vmid);
+           (k1->vmid == k2->vmid) && (k1->stage == k2->stage);
 }
 
 SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level)
+                                uint8_t tg, uint8_t level, SMMUStage stage)
 {
     SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
-                        .tg = tg, .level = level};
+                        .tg = tg, .level = level, .stage = stage};
 
     return key;
 }
@@ -81,7 +81,8 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
         SMMUIOTLBKey key;
 
         key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
-                                 iova & ~mask, tg, level);
+                                 iova & ~mask, tg, level,
+                                 SMMU_STAGE_TO_TLB_TAG(cfg->stage));
         entry = g_hash_table_lookup(bs->iotlb, &key);
         if (entry) {
             break;
@@ -109,15 +110,16 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
 {
     SMMUIOTLBKey *key = g_new0(SMMUIOTLBKey, 1);
     uint8_t tg = (new->granule - 10) / 2;
+    SMMUStage stage_tag = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
 
     if (g_hash_table_size(bs->iotlb) >= SMMU_IOTLB_MAX_SIZE) {
         smmu_iotlb_inv_all(bs);
     }
 
     *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                              tg, new->level);
+                              tg, new->level, stage_tag);
     trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
-                            tg, new->level);
+                            tg, new->level, stage_tag);
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
@@ -159,18 +161,22 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
     if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
         return false;
     }
+    if (!(info->stage & SMMU_IOTLB_STAGE(iotlb_key))) {
+        return false;
+    }
     return ((info->iova & ~entry->addr_mask) == entry->iova) ||
            ((entry->iova & ~info->mask) == info->iova);
 }
 
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
-                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
+                         SMMUStage stage)
 {
     /* if tg is not set we use 4KB range invalidation */
     uint8_t granule = tg ? tg * 2 + 10 : 12;
 
     if (ttl && (num_pages == 1) && (asid >= 0)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl, stage);
 
         if (g_hash_table_remove(s->iotlb, &key)) {
             return;
@@ -184,6 +190,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
     SMMUIOTLBPageInvInfo info = {
         .asid = asid, .iova = iova,
         .vmid = vmid,
+        .stage = stage,
         .mask = (num_pages * 1 << granule) - 1};
 
     g_hash_table_foreach_remove(s->iotlb,
@@ -597,7 +604,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
-            info->stage = cfg->stage;
+            info->stage = SMMU_STAGE_TO_TLB_TAG(cfg->stage);
             return NULL;
         }
         return cached_entry;
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 843bebb185..6caa0ddf21 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -133,12 +133,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
 
 #define SMMU_IOTLB_ASID(key) ((key).asid)
 #define SMMU_IOTLB_VMID(key) ((key).vmid)
+#define SMMU_IOTLB_STAGE(key) ((key).stage)
 
 typedef struct SMMUIOTLBPageInvInfo {
     int asid;
     int vmid;
     uint64_t iova;
     uint64_t mask;
+    SMMUStage stage;
 } SMMUIOTLBPageInvInfo;
 
 typedef struct SMMUSIDRange {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f081ff0cc4..b27bf297e1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1087,7 +1087,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
-        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
+        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, SMMU_NESTED);
         return;
     }
 
@@ -1105,7 +1105,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
-        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
+        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
+                            num_pages, ttl, SMMU_NESTED);
         addr += mask + 1;
     }
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cc12924a84..3000c3bf14 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -14,10 +14,11 @@ smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
 smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
+smmu_iotlb_inv_stage(int stage) "Stage invalidate stage=%d"
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
 smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
+smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, int stage) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d stage=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 876e78975c..695d6d10ad 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -37,6 +37,8 @@
 #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
                                              VMSA_BIT_LVL(isz, strd, lvl)) - 1)
 
+#define SMMU_STAGE_TO_TLB_TAG(stage)        (((stage) == SMMU_NESTED) ? \
+                                             SMMU_STAGE_1 : (stage))
 /*
  * Page table walk error types
  */
@@ -136,6 +138,7 @@ typedef struct SMMUIOTLBKey {
     uint16_t vmid;
     uint8_t tg;
     uint8_t level;
+    SMMUStage stage;
 } SMMUIOTLBKey;
 
 struct SMMUState {
@@ -203,12 +206,13 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
-                                uint8_t tg, uint8_t level);
+                                uint8_t tg, uint8_t level, SMMUStage stage);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
 void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
-                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
+                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
+                         SMMUStage stage);
 
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
-- 
2.44.0.396.g6e790dbe36-goog


