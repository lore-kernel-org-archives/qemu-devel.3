Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB4C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohMX-0004Rw-5j; Mon, 25 Mar 2024 06:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3s04BZggKCow82489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com>)
 id 1rohMV-0004PM-3p
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:27 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3s04BZggKCow82489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com>)
 id 1rohML-0004ZQ-3r
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:15:24 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60a54004e9fso76351007b3.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1711361715; x=1711966515; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=eHoUPCH/YMadeu6TWvrJiZJZDJjDW6k+aPnqL5b9wjg=;
 b=YeyUwBZWq3EistBngdbSsyOlNTGspzC7Xj5Dp2zr20KXXbiQLYkhqr9dlKZ58DPeEH
 ZUoRRrCCVn9JxN4OSvWqVvlJLZ01sd+UT1/fBhpqjCxQZWl/EIxKdrBcE7NiC8nEss/w
 a3NPy0AdUGb/1BdCLKKVoxRlQ5ccQGztSZd1hnhOXcDA2pgjEECuZNPMMBDD7hWyHOHw
 hJL70vRhfLvwZok5zLp0AkGLSzDn+8Rl7kdq3FJKDm/yoUSPd0EoRNutFpWPXK4mrpvU
 N8z3qaoTAhiEkVA/ILjkMb1OhGS1PrI1AenVKqAmQga4MJf5jrzgLuhmYxkB2dbAV+kB
 PbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711361715; x=1711966515;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHoUPCH/YMadeu6TWvrJiZJZDJjDW6k+aPnqL5b9wjg=;
 b=BxM55N7HGSCBGZx70+idXGqsDyYwdbRmW34zyNk0ANqv4x6QwMz2n7wIEoAmY/p9g9
 5JwIWpzo2bouRKL/K5eqGzkbobpsfbLlhVcepuIJjs3ZQFyWOGL3QI0WpyDur7mkKJzz
 hJORc4KS8HucEFqzn8z6ub7+Ee/cjFKgKxQfRNX1q/F9exO2wsg6rS4wpBXRlIpUnVVY
 ooWCmLYnHsv4sxBIKJAJEAa4V3G0v6wgpCQ23XIuVJ9PTv6YQgQmzD2v/pQ5v+u1LiNR
 yqtINgxUpYS6GiJ0I3ElMxIdjkYzGIf2q0SF6eRRFVtkKQdJt3Y36QsAGIsTSrbi7MR9
 vbhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj6FIlwfVeFb1wkq3jOgU18sBCD07nLs0IRYhc4NHuHnWS1aWnJYpozGNB63Wd8r67/ucc6iXbDzQfESlkiLWOyHkLR2Q=
X-Gm-Message-State: AOJu0YwN8xQ5RMXosMXtV21e6moQy3wG6ilY1LL+gl++wW0Pu9Wvpqo+
 ghF78C3piCbt1aQjZe7AR4HyXndCYrguOwxKIU0y/NY89/pvp8e0PLyB7iw9NFgHhesHBddKgvF
 fsHPOavp6dA==
X-Google-Smtp-Source: AGHT+IHXtcE8vPKkk9UnxjONeFhwulYVc7m3vqAZvDSAzUouYEXPKzc8bJvOkPwoM+SHcFv94wU9qV48jPc59Q==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:690c:fcd:b0:611:967b:ed8e with SMTP
 id dg13-20020a05690c0fcd00b00611967bed8emr288621ywb.10.1711361715231; Mon, 25
 Mar 2024 03:15:15 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:14:01 +0000
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240325101442.1306300-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325101442.1306300-6-smostafa@google.com>
Subject: [RFC PATCH 05/12] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3s04BZggKCow82489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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
index 9460fff0ed..d9ee203d09 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -993,7 +993,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages)
+                               uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     IOMMUTLBEvent event;
@@ -1017,14 +1017,21 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
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
@@ -1043,7 +1050,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages)
+                                      uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev;
 
@@ -1052,10 +1059,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
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
@@ -1086,7 +1093,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, stage);
         return;
     }
@@ -1105,7 +1112,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg,
                                  num_pages, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
         smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl, stage);
         addr += mask + 1;
     }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 73cec52d21..34b10af83f 100644
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
2.44.0.396.g6e790dbe36-goog


