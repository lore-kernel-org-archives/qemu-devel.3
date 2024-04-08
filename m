Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766FCD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtphT-0007kG-Sn; Mon, 08 Apr 2024 10:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3jvoTZggKCgs3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1rtpgi-00076Z-Jl
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:34 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3jvoTZggKCgs3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1rtpgZ-0001Np-GV
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:32 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dcc05887ee9so5911051276.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585359; x=1713190159; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3HqNDgdJVJw0NA38Rt0khH0xSYdgx1axY3awgliAoN0=;
 b=fccCI3fg+ThSBJdvD+HfqPugfWoAFwuqW3atJSyRrTvUAptBjfMmBQg1IQIuMFdB/5
 1EjP6ZLQR8OaWPdMHNRbVQKu2iDeGVsZOa5ZX4biX/LnIPGIvfG1BUTTVq1zQKtQi5V6
 2WXuDWSkaKkyVU4NF3ovLll6HQXWHN2AaVHnxJuN2tKVBMK1XEZkiyTtBFriCxnK8CRr
 A/XPTDTa5or3JkYXPNZDR4I56S2SXLnXA95lXUc0gIwZGCdXWCxWk7jUPg/hLPj41gov
 bm8j34UiAUY3SeL2XpBPN+wHoRRQBmlnctwUk+vNRx32ENVVmE2Sxioe17x70gzkr6sG
 /MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585359; x=1713190159;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3HqNDgdJVJw0NA38Rt0khH0xSYdgx1axY3awgliAoN0=;
 b=XnfU6ACZWMw64uS84KW5RzGOsRY0HfqGFkNAPEDAR4HG6vUXK3Dlr/DctyAPp3OdRs
 Ac7FcwxrK1QQXS/sQ1OpAajo7bZlzx8+8JwUzOdj0BLt21y/kXd2g7lfjeKqE8k1XvLX
 PRjHz3eMJ0vL3U8WXmY3Ddu7rloJOrlnf+VyyrOtTgVvbjx4/p5ZWZyIf60VIYUcGzPX
 gRXEq73/W+/5rW48WgrkvaEU++b0kP7LBRpp0u5N+vg3Y/36wylW8l6bXtOi5/w8+c5+
 ORhovPRuwNIlXPcXeSwhgJXBBLsXZ3R9Ku1Zxuv98rLqMXA7x5QDVUvEy7FjdGmiulZA
 HeKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV80q1iiRY1HpQlIuauCwwgl0YFuVHjLoPicku7djBKzOwsH8ZkOTETV6/ZqaQC93hJSkdNr0JM/rCbpt4flz7TrnhEDYM=
X-Gm-Message-State: AOJu0Yw1R2N/5shOhT/++LNIvP117OEfsjox+oDJ94Lb05jEDubSKY+T
 +y5jLvwaWXdEIT3E+swROoW5O53ai7HSmJZ+oQw5fqYx7WZllkfSf7sItilNGMO2NKCaGuKfonx
 LaqqLQ09vCw==
X-Google-Smtp-Source: AGHT+IEWg5K7fM2dcPCvRd9RMsFcEdOBM1qMISm61aHu3BqQA/Rfue4/66wDQOMCL5NYhR7j9lozroVomxR0yg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:727:b0:dcc:8927:7496 with SMTP
 id l7-20020a056902072700b00dcc89277496mr672950ybt.5.1712585358833; Mon, 08
 Apr 2024 07:09:18 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:13 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-9-smostafa@google.com>
Subject: [RFC PATCH v2 08/13] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3jvoTZggKCgs3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com;
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

IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs keep
the implementation, while only notify for stage-1 invalidation
in case of nesting.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3.c     | 23 +++++++++++++++--------
 hw/arm/trace-events |  2 +-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ece647b8bf..85b3ac6a9c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1028,7 +1028,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages)
+                               uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     IOMMUTLBEvent event;
@@ -1052,14 +1052,21 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
             return;
         }
 
-        if (STAGE1_SUPPORTED(s)) {
+        /*
+         * IOMMUTLBEvent only understands IOVA, for stage-2 only SMMUs
+         * keep the implementation, while only notify for stage-1
+         * invalidation in case of nesting.
+         */
+        if (stage == SMMU_STAGE_1) {
             tt = select_tt(cfg, iova);
             if (!tt) {
                 return;
             }
             granule = tt->granule_sz;
-        } else {
+        } else if (!STAGE1_SUPPORTED(s)) {
             granule = cfg->s2cfg.granule_sz;
+        } else {
+            return;
         }
 
     } else {
@@ -1078,7 +1085,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages)
+                                      uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev;
 
@@ -1087,10 +1094,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
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
@@ -1121,7 +1128,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         } else {
@@ -1144,7 +1151,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
                                  ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         } else {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 2556f4721a..53b9d11feb 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.44.0.478.gd926399ef9-goog


