Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B90FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLZ-0006SS-Br; Mon, 15 Jul 2024 04:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3w-GUZggKChYE8AEFw1w2AA270.yA8C08G-z0H079A929G.AD2@flex--smostafa.bounces.google.com>)
 id 1sTHLL-0005Pw-Mf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:59 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3w-GUZggKChYE8AEFw1w2AA270.yA8C08G-z0H079A929G.AD2@flex--smostafa.bounces.google.com>)
 id 1sTHLJ-00046t-NN
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:59 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-36789dfcc8bso2513296f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033156; x=1721637956; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qqr+nya9Tbgn4Iimld4OHaPq21aNI9rWPo4mQAadqNU=;
 b=TQF+EmqJPdWMA9RWP9EobtQao5IL/5biIf6+5RqdXzNKjtWKPBveXJ1VzsU0F9RH8B
 /+lWE2zMvfOiS8xueBQ0Rii5fzeP/7I5faO3Uy3+q0nBRWoCQNTkdBC2kbsTNBdyKWIO
 uOGJCaPZMoi9tl+yhSfYJpBWvofLS2MEBX112tfVQAgzKfZ0nyzFg58bCQXRl5/p/ajM
 3OSOguPHsslv3idP8XeZxfsALECCRNueNGwpLvz8EOxRuWpEnEGJ3YjhSUvlsZzgI/XV
 qC0uxKzJc3j5Yk534DvXG/hYBbpgp+8o70r3i7YmeTd8/0lSzp0Ar5nqBI5So9w3dcSC
 5B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033156; x=1721637956;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qqr+nya9Tbgn4Iimld4OHaPq21aNI9rWPo4mQAadqNU=;
 b=vvz0/kY68IHsnHJp69NpDWRQiCqLvcHNsr32k0oakbAT0T49YrVZO8FIrn6lTvzQL9
 FI154/IkvhZ6Q9gq81Sh5ACNj/AzryIW9+fxUVvuJk3UGuW9JLy5L18X97Q8Kny3zzYE
 dhgjId+zF6GvXJQMjchLbLF42bvdSgeyZ9TtMChOFYFWu8RKuow3z+DPiMwPHcbBI7CG
 1FCHJVMw6HZaHh0DVwsXwhvBUJrFPUUwy8QeDP7xcTm/NpcDWHFnYC94qCphnKf0Uc6S
 swKlecR1sXoVPhufbgO/qdutrHtKVfSUQfcbVKmuPysfytkFDntnXKI0Lv6xJPnx3il9
 66pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp8qrsjFnhiQyssq2lVjvZ7PmuNlXeWUgl/M9aZCGSGF7fshgG4VPYACccgUzWlNxvI+URs8il45zGYVjr8qCCDbv2aBg=
X-Gm-Message-State: AOJu0Yz9zqwi7xehvTpXi0ZS05EwpPWnyrZMYTVwo1RfSQ65l4COuRXL
 9KbFJRWeL6AAxznnZ+9q5G+RtCvzfdx6MILAN2fmjFLRoG1GPTmlmxUhymIvKTzPtiPd9Xs5Hud
 I25+D6Y/x7w==
X-Google-Smtp-Source: AGHT+IFYcl2XtYv2/IFIsNkv0jeyIiZgv8PEWZ/O2vWPOm2oj+ab9VZJnr2A1P9fMH/psovYLNrceE0B5+j+jw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:6712:0:b0:367:90cc:48e with SMTP id
 ffacd0b85a97d-367cea74a51mr25071f8f.5.1721033155745; Mon, 15 Jul 2024
 01:45:55 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:12 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-13-smostafa@google.com>
Subject: [PATCH v5 12/18] hw/arm/smmu: Support nesting in smmuv3_range_inval()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3w-GUZggKChYE8AEFw1w2AA270.yA8C08G-z0H079A929G.AD2@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x449.google.com
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

With nesting, we would need to invalidate IPAs without
over-invalidating stage-1 IOVAs. This can be done by
distinguishing IPAs in the TLBs by having ASID=-1.
To achieve that, rework the invalidation for IPAs to have a
separate function, while for IOVA invalidation ASID=-1 means
invalidate for all ASIDs.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c         | 47 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3.c              | 23 ++++++++++++------
 hw/arm/trace-events          |  2 +-
 include/hw/arm/smmu-common.h |  3 ++-
 4 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8ed53f5b1d..a100700497 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -195,6 +195,25 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
            ((entry->iova & ~info->mask) == info->iova);
 }
 
+static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
+                                             gpointer user_data)
+{
+    SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
+    IOMMUTLBEntry *entry = &iter->entry;
+    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
+    SMMUIOTLBKey iotlb_key = *(SMMUIOTLBKey *)key;
+
+    if (SMMU_IOTLB_ASID(iotlb_key) >= 0) {
+        /* This is a stage-1 address. */
+        return false;
+    }
+    if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
+        return false;
+    }
+    return ((info->iova & ~entry->addr_mask) == entry->iova) ||
+           ((entry->iova & ~info->mask) == info->iova);
+}
+
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
@@ -223,6 +242,34 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                                 &info);
 }
 
+/*
+ * Similar to smmu_iotlb_inv_iova(), but for Stage-2, ASID is always -1,
+ * in Stage-1 invalidation ASID = -1, means don't care.
+ */
+void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
+                        uint64_t num_pages, uint8_t ttl)
+{
+    uint8_t granule = tg ? tg * 2 + 10 : 12;
+    int asid = -1;
+
+   if (ttl && (num_pages == 1)) {
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
+
+        if (g_hash_table_remove(s->iotlb, &key)) {
+            return;
+        }
+    }
+
+    SMMUIOTLBPageInvInfo info = {
+        .iova = ipa,
+        .vmid = vmid,
+        .mask = (num_pages << granule) - 1};
+
+    g_hash_table_foreach_remove(s->iotlb,
+                                smmu_hash_remove_by_vmid_ipa,
+                                &info);
+}
+
 void smmu_iotlb_inv_asid(SMMUState *s, int asid)
 {
     trace_smmu_iotlb_inv_asid(asid);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 06a96c65eb..a0979f15a0 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1168,7 +1168,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
     }
 }
 
-static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1193,9 +1193,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
     }
 
     if (!tg) {
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
+        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
-        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
+        if (stage == SMMU_STAGE_1) {
+            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
+        } else {
+            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
+        }
         return;
     }
 
@@ -1211,9 +1215,14 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
         uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
 
         num_pages = (mask + 1) >> granule;
-        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
+        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
+                                 ttl, leaf, stage);
         smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
-        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
+        if (stage == SMMU_STAGE_1) {
+            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
+        } else {
+            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
+        }
         addr += mask + 1;
     }
 }
@@ -1372,7 +1381,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
@@ -1397,7 +1406,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 09ccd39548..7d9c1703da 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -46,7 +46,7 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
+smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
 smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index a3e6ab1b36..f9c8b00c9d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -217,7 +217,8 @@ void smmu_iotlb_inv_asid(SMMUState *s, int asid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
-
+void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
+                        uint64_t num_pages, uint8_t ttl);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.45.2.993.g49e7a77208-goog


