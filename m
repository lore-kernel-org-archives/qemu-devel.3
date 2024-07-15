Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3FFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHLd-0006of-Jq; Mon, 15 Jul 2024 04:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yuGUZggKCh0LFHLM3839HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--smostafa.bounces.google.com>)
 id 1sTHLR-0005t7-RL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:11 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yuGUZggKCh0LFHLM3839HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--smostafa.bounces.google.com>)
 id 1sTHLQ-00047w-1A
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:46:05 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-367960f4673so2758769f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033162; x=1721637962; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=1XxTn9lU99aLCsa3PM/+eEB25Y0hNHnXmG38B345hjk=;
 b=qp/ieIwHNKuMWw4eVNgEzuagp9oOxETyM9KkoXk/EQo4I6zjp5sodFbRi0vLlAF+ab
 IiMzun/TsWo/QQQFG+9MYlVBppHRahpucBZzLRqvaLmVH/Edpvt+5GJpmEL74HfNs/8k
 xOB69SeusPPEcp0tcYLvnoG4pu5ZDgxw38eIjnkF+nvhtgZNORLsN+O7af1xUiOihw/k
 Mn1OOjy5+5D1tIhkBDtwZR5D0QqEKgggI7WqUh+AQfU4oDw/LmZwEo4yW+cDdnsYvhV6
 r9VerNWYKtvytrGCzwEY/4YSwjJAHGqrxbt8zTtvEYoT2Kl2uRC1Ce+cSfttURTpb/kx
 w3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033162; x=1721637962;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1XxTn9lU99aLCsa3PM/+eEB25Y0hNHnXmG38B345hjk=;
 b=CT5lizantTt5M/WHrV6/lgqAnOZyLRIa4nlVJ7ciXAsoFYLfD3aQOZqf52LYGpj8lJ
 Cd8LCBmS4OkQwdDNtV8ydgaIrdvz7ALOzJPuGMM/4i0aeledF5DZVRPlVjNqJ0P/EtDW
 59st6nBFM3zvp0GiIj0m269I6r/1mhhZSpxvfFoNxmN+8nUBdXc7e8OprzcQNPRRfLuX
 5q/tKF5WWj6H8CJuOptshKFnIZowL6VjDPSoOia98j5Q2wqxnsuoz9yt9DNUk2kl3R+K
 zErn+H3p0ARPkb57WxjiiP4FbJ9hrRByZZDqrcfM3VC4iSSIsJtD/dO9tPwGvNE7yT5p
 aKBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG89Wwupl6hs2KRNh2AdRjojxJLp/gJfwKuWQVOzxasvSuV3xuwASEfns9Jk1xSbF+SdT48xKMNokhIlI5ZYHvNvn01wA=
X-Gm-Message-State: AOJu0YwSD6WERi6HylgDIoBdNEl5+M9JOMVV3PV3fU2M1YCXJ+prNnA0
 rRd+v9ix6CG78qxe3mKXYfDsAUxcCJ4FE1gFhlinSsY3uFma7u1BL7ncU9KJDmc/zxrSaO7k2U0
 COQ2SG1FIXg==
X-Google-Smtp-Source: AGHT+IG5QvFYtLJNBSxdQVQa1bZYSq9HTWY+Y345s0HAPefESRyEn+25u17l4skJpUA/jZruVCJwao9mGfai6A==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:1d86:b0:426:52a8:2847 with SMTP
 id 5b1f17b1804b1-4279dadbd9emr2510365e9.1.1721033162442; Mon, 15 Jul 2024
 01:46:02 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:15 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-16-smostafa@google.com>
Subject: [PATCH v5 15/18] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3yuGUZggKCh0LFHLM3839HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--smostafa.bounces.google.com;
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

IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
SMMU instances we consider the input address as the IOVA, but when
nesting is used, we can't mix stage-1 and stage-2 addresses, so for
nesting only stage-1 is considered the IOVA and would be notified.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c     | 39 +++++++++++++++++++++++++--------------
 hw/arm/trace-events |  2 +-
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9a88b83511..84cd314b33 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1096,27 +1096,38 @@ epilogue:
  * @iova: iova
  * @tg: translation granule (if communicated through range invalidation)
  * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
+ * @stage: Which stage(1 or 2) is used
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages)
+                               uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
+    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
     IOMMUTLBEvent event;
     uint8_t granule;
-    SMMUv3State *s = sdev->smmu;
+
+    if (!cfg) {
+        return;
+    }
+
+    /*
+     * stage is passed from TLB invalidation commands which can be either
+     * stage-1 or stage-2.
+     * However, IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
+     * SMMU instances we consider the input address as the IOVA, but when
+     * nesting is used, we can't mix stage-1 and stage-2 addresses, so for
+     * nesting only stage-1 is considered the IOVA and would be notified.
+     */
+    if ((stage == SMMU_STAGE_2) && (cfg->stage == SMMU_NESTED))
+        return;
 
     if (!tg) {
-        SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
-        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
         SMMUTransTableInfo *tt;
 
-        if (!cfg) {
-            return;
-        }
-
         if (asid >= 0 && cfg->asid != asid) {
             return;
         }
@@ -1125,7 +1136,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
             return;
         }
 
-        if (STAGE1_SUPPORTED(s)) {
+        if (stage == SMMU_STAGE_1) {
             tt = select_tt(cfg, iova);
             if (!tt) {
                 return;
@@ -1151,7 +1162,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages)
+                                      uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev;
 
@@ -1160,10 +1171,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
         IOMMUNotifier *n;
 
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
-                                        iova, tg, num_pages);
+                                        iova, tg, num_pages, stage);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
+            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
         }
     }
 }
@@ -1194,7 +1205,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         } else {
@@ -1217,7 +1228,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
                                  ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         } else {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 593cc571da..be6c8f720b 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.45.2.993.g49e7a77208-goog


