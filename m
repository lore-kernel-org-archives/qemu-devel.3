Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72ADC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOErQ-0005j8-RD; Mon, 01 Jul 2024 07:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DY2CZggKCmwcWYcdKPKQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--smostafa.bounces.google.com>)
 id 1sOEpa-0002XH-HQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:29 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DY2CZggKCmwcWYcdKPKQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--smostafa.bounces.google.com>)
 id 1sOEpN-0005SU-6t
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:04:14 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4256f895ce8so19629795e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831822; x=1720436622; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lFf7LTyQryhCqwJWdSrsDWz4NW2inRaYmsKx7TIXcNM=;
 b=tjANMOGsq3rmgV/HWtwQdVMXiZbTsX9uyyI1BoziooiORC9gtqSlQFyeGEVL/1YW3c
 h1p+ItXtE/mFXBwAo0krY4HBHFYpFMYm+DL3ICbbBau4vCqlE8/n21UqYev3jRruqdn/
 moK0fRNMrrYvrWtxk0ItjB8OZmA8ey0VGY29njp5qf7NimRY+Arxs5EjId6e+qfttuTm
 x6K2/cwyZR1xqA5pXtNXSp/zIpeuYCroEy5gE4EQQ7KHu+1WL0R/dVQJlmK1ziBCvikZ
 YPbJvxvHTq1OU+YTnaUsRgcPB58y6tzKTN8CFU6jte6jgzA/4ZQX061lZLQkWnkRkRB/
 /shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831822; x=1720436622;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFf7LTyQryhCqwJWdSrsDWz4NW2inRaYmsKx7TIXcNM=;
 b=aZJqTb7nkzubAEf+sqocPMNe6Ao/0qLg356nA9vjoG7LmKYjA6G9IuX/9YAOy8mWv7
 bJz/+3lFzEyWTNs7Z96rlHHS8ZwXE8ftVvKloOMI8Oe0GKISUeQW7lI3VMe+NRz+H1J8
 LZqj1cLDduqGFbQWX/Xfmplummkdl5xcHcanrxwk8ssDDhEX8MjC4ptp4N05+lczhqkL
 6cvIUTpvN74rnyU44n/eBDgz4JjyNrFIARkLxvPn9J0taVNFPg9slktVYT6b+bnQGjS2
 v29oD4PfHh/Lbs67VEOyFbc3ii4E5f48gHs3ZX/Jd1QDmUs7YMbS3ci4JB1TapjiV/vB
 onGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Ccxych00nzIckEkQuIvW3EmmIGt3jR2NiVY4qvMyqgWCc7mduQUr0hmILRinEjas05eod9IiNHL9XZZg/XdH24XLhio=
X-Gm-Message-State: AOJu0YxJy5sW4jC4p+9mugbYSdQcDhGSX3VTsvYHvstCmZLlK3ctDx2o
 Vhn7R0FCyuG/46IHRUWaeCUabRxXPS8Gke9Fp5QtOEjiHKKyPccSoQKBTha3qm0IkYeNn+/ksi1
 ejs0UoRe1MQ==
X-Google-Smtp-Source: AGHT+IFxdDw/zMT5mUyxzY5kRonRo/WQXM4JeI7ZxY0226hit9+Bo9BAi7N8CHvRqD2FUGck4n8tFgEEc7rC0w==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:35c7:b0:425:672a:769b with SMTP
 id 5b1f17b1804b1-4257a05c6b4mr297475e9.5.1719831821932; Mon, 01 Jul 2024
 04:03:41 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:37 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-16-smostafa@google.com>
Subject: [PATCH v4 15/19] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3DY2CZggKCmwcWYcdKPKQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--smostafa.bounces.google.com;
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

IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
SMMU instances we consider the input address as the IOVA, but when
nesting is used, we can't mix stage-1 and stage-2 addresses, so for
nesting only stage-1 is considered the IOVA and would be notified.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c     | 28 +++++++++++++++++++---------
 hw/arm/trace-events |  2 +-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e9007af3cd..36eb6f514a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1064,17 +1064,17 @@ epilogue:
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
     IOMMUTLBEvent event;
     uint8_t granule;
-    SMMUv3State *s = sdev->smmu;
 
     if (!tg) {
         SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
@@ -1093,14 +1093,24 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
             return;
         }
 
-        if (STAGE1_SUPPORTED(s)) {
+        /*
+         * stage is passed from TLB invalidation commands which can be either
+         * stage-1 or stage-2.
+         * However, IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
+         * SMMU instances we consider the input address as the IOVA, but when
+         * nesting is used, we can't mix stage-1 and stage-2 addresses, so for
+         * nesting only stage-1 is considered the IOVA and would be notified.
+         */
+        if (stage == SMMU_STAGE_1) {
             tt = select_tt(cfg, iova);
             if (!tt) {
                 return;
             }
             granule = tt->granule_sz;
-        } else {
+        } else if ((stage == SMMU_STAGE_2) && (cfg->stage != SMMU_NESTED)) {
             granule = cfg->s2cfg.granule_sz;
+        } else {
+            return;
         }
 
     } else {
@@ -1119,7 +1129,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages)
+                                      uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev;
 
@@ -1128,10 +1138,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
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
@@ -1162,7 +1172,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         } else {
@@ -1185,7 +1195,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
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
2.45.2.803.g4e1b14247a-goog


