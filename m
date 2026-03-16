Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71954F53D8B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cyg-0000G1-VP; Mon, 16 Mar 2026 14:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2Cyb-0000Fh-CL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:47:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2CyZ-0006F4-Iy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:47:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b04d051664so17538175ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773686858; x=1774291658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcq98p8TBMj9rp8LW0tSIRQYuIxm2SJ2Ri6ycH/WQ9o=;
 b=mTJX1hKr+M44gpD5dnzpCu8yHgkz2aAX63foBxMne8iT/ozq0K3eHtesinooFWugP5
 qtqH8TrDxw8mib5hwuv+vhlFjQqhOujH6/wcBSQIAUzhUz4e+SM4z06uHhu4Rb0WiibH
 TXPWr+VzcyY3UWH/aYh7+DE6ab3dtK8PnJLw9OMD/Nn6XGZUFplYpk21RIKTwvoZ8JtQ
 fAystrXb8/Wdrz5Sb6eTEZvNEQmU3PXDyaCruuNezMQppRPJe1jlZfDzk/7/TMcN02l1
 iSWSQoZymyhOsMlU6YGYx+qBrdgVUhjGu8ziaICwrvmtovwmrM95EQnDeG+DrPUoFJdL
 80xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686858; x=1774291658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rcq98p8TBMj9rp8LW0tSIRQYuIxm2SJ2Ri6ycH/WQ9o=;
 b=MrtofNJE7S3zBe9h9nHLhWxZFppnihq7RjYAOzedRzOasmErP9oqNhVjKKfAIasF9/
 IsyE0wINWyyzqTzc4dNXPhwkthrghsslsHZhmEwuPMJek0C3IBfF9I2PZpvVCD6B/CwD
 I+vMP2uxCrq+fnvo98nTO4NGvNjYiynee9bm1L8m/KUWgN01a86e1kB7GRYoihWYqbaB
 p0cJx+yczssWgCGHbTuk87+B5zt/UHUcXPPU8VYUfi8IgT7HG2szNviGRv3bewRzCPTF
 nZSPLaQ2sLDIPvSOCvLRIAwpqrprd7wkQbgdc4TqmCwhZFl4XSMb3kB1Nei7IIHcVKzv
 LdWg==
X-Gm-Message-State: AOJu0Yy5LF8X3U+9+3XKai2o890QU6plZ9uTuwwFlxeR4mjKlxfy+KPy
 EQnCyolpMFhq0iocOTUkoESAtpdl7cXONpYM2DWUg0ngM3/7X8jAqm65mJ5aD7mw
X-Gm-Gg: ATEYQzyQ0y2jjoXeMCG5C/RG/hdyJ2awW240rvIqnsOuJh0ieMHsDxqhLeLCObxqoHu
 JHPL6lWaIRpwZuiFHg45JKEm1hSxlERb40pmxsGbM6rFnsup7HWMf/RLvHdpOJnKfBEJ6mHTyyQ
 OhYGWnOxoVs4jCdC/cT4bhz8AV2al1gJxeOYeV9JgDgCUQmdzJeyeOQXNmlJ5/NdORQCpp2dLwT
 XN1U8Rn8+TEf9GvtR9MczI/BmkvIp7HLLUkXGVoPFWGbdev/WiMhqJ+hUYe10gD+yKYVm4tIGsZ
 Z3iCzsUNAl5fw2x9tpuNzVQymm9zcZnjii9gAusJAK4gGQcuqn6ObZScqOvt+vzMjPY/TXglg69
 T6MCMPtac6THhabMFNX4fzScsrRf4PWOtPeQHALQqWJ6lCWcCf5IFDGcPI1uCMn1wPjOQzZn59F
 2bS+/gyfiXyjPyzrVPV/kmChrwZoC3TqDpsVtneSELkKhN6UbUkjjrNTa+VKlJ2+bZmeOFEAcMl
 qQL/yy03480sf32XaAa
X-Received: by 2002:a17:903:3c6e:b0:2ae:80f9:d8ad with SMTP id
 d9443c01a7336-2aeca9412c6mr153357785ad.5.1773686857845; 
 Mon, 16 Mar 2026 11:47:37 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b04f40f515sm77284145ad.74.2026.03.16.11.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:47:37 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH v3 v3 4/4] hw/pci/msix: fix error handling for msix_init
 callers
Date: Tue, 17 Mar 2026 03:46:40 +0900
Message-ID: <20260316184644.68116-5-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316184644.68116-1-vikingtc4@gmail.com>
References: <20260311183432.214960-1-viking4@gmail.com>
 <20260316184644.68116-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=vikingtc4@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Check return value of msix_init() and return early on
failure instead of continuing with invalid state.
- Use ret < 0 to handle negative return value.
- Use errp parameter to handle failure instead of NULL.
- No functional changes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 16 +++++++++++-----
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 48d56e43ac..9a165c7063 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -260,7 +260,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
 
     ret = msix_init(dev, IGBVF_MSIX_VEC_NUM, &s->msix, IGBVF_MSIX_BAR_IDX, 0,
         &s->msix, IGBVF_MSIX_BAR_IDX, 0x2000, 0x70, errp);
-    if (ret) {
+    if (ret < 0) {
         return;
     }
 
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 4a7056bd45..910dce901b 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1228,7 +1228,7 @@ static int rocker_msix_init(Rocker *r, Error **errp)
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
                     0, errp);
-    if (err) {
+    if (err < 0) {
         return err;
     }
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index b35476d057..1b23eaf100 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -432,7 +432,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
                     0, &dev->msix_exclusive_bar,
                     bar_nr, bar_pba_offset,
                     0, errp);
-    if (ret) {
+    if (ret < 0) {
         return ret;
     }
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index f62e420a91..a29742d449 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2380,11 +2380,17 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->queue_io, OBJECT(s), &megasas_queue_ops, s,
                           "megasas-queue", 0x40000);
 
-    if (megasas_use_msix(s) &&
-        msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
-                  &s->mmio_io, b->mmio_bar, 0x3800, 0x68, NULL)) {
-        /* TODO: check msix_init's error, and should fail on msix=on */
-        s->msix = ON_OFF_AUTO_OFF;
+    if (megasas_use_msix(s)) {
+        ret = msix_init(dev, 15, &s->mmio_io, b->mmio_bar, 0x2000,
+                        &s->mmio_io, b->mmio_bar, 0x3800, 0x68,
+                        s->msix == ON_OFF_AUTO_ON ? errp : NULL);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                return;
+            }
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
 
     if (pci_is_express(dev)) {
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index aa570506fc..c5446a4a5e 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -173,11 +173,17 @@ static void usb_xhci_pci_realize(struct PCIDevice *dev, Error **errp)
     }
 
     if (s->msix != ON_OFF_AUTO_OFF) {
-        /* TODO check for errors, and should fail when msix=on */
-        msix_init(dev, s->xhci.numintrs,
-                  &s->xhci.mem, 0, OFF_MSIX_TABLE,
-                  &s->xhci.mem, 0, OFF_MSIX_PBA,
-                  0x90, NULL);
+        ret = msix_init(dev, s->xhci.numintrs,
+                        &s->xhci.mem, 0, OFF_MSIX_TABLE,
+                        &s->xhci.mem, 0, OFF_MSIX_PBA,
+                        0x90, s->msix == ON_OFF_AUTO_ON ? errp : NULL);
+
+        if (ret < 0) {
+            if (s->msix == ON_OFF_AUTO_ON) {
+                return;
+            }
+            s->msix = ON_OFF_AUTO_OFF;
+        }
     }
     s->xhci.as = pci_get_address_space(dev);
 }
-- 
2.43.0


