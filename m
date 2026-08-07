Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C52EC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHy4-0007Vt-Cy; Fri, 07 Aug 2026 06:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsHxp-0007S1-7d
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:38:09 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wsHxm-0001JR-Gj
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:38:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so3848007a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786099085; x=1786703885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xOuB0xzagMqJXQ72FfcRiSDCXARyPzaZRE/TJwdx9aI=;
 b=fZOhhKUH5jYpAuqvy/q3lf/rT7lQCWeTLkuJBkXJSlLpZ8s6VTlMWq12x16rzAzU6r
 23gd8Bi2e6QFMNvrtzvRwVvJtP9Ql/KwVQLqPrjR3BjuEEPzL1cYHkrerXRj0fR6Dm7P
 WDtgxaQAE/aKTnBsCfBf0ombmG7R9I/ex7ba1M//N3b9lG+R2sRscu04RBBFrGDFaKJb
 WWGx2UFSm7e94o85Pumol072nQRi2hGMWsf63gN+e4n8feDYlkDL91ZT9J7azCWZ4PEM
 q3F/YZb4mgTd3O0Ift4wG46nxKMxRlI796QmUBHFVeY6wUw9BV3uEWONP3kNLB2otS+c
 xgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786099085; x=1786703885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xOuB0xzagMqJXQ72FfcRiSDCXARyPzaZRE/TJwdx9aI=;
 b=LRudPyuUy6zMsdQBiV1c02ZNlaxCToDv8z+iAagQgU3bDxGdJV4tXsObcaXYHnA+2n
 A45X+HlU4ozZiyA80NvXzHWdA/f2yl6UIErK3386f+LoMM7aBb+u/lLf1Awlt5ywupc8
 g2Pck7MaubvUACr//9a1bx2i6D8ezi4iUiOFENDe+VORDwYov3myEIAbuHwI1GRuO5MD
 3NHmBm4mTvklXZnUsWw9O8QIHHeETKpyW2P3DAQ2lwdzKzkOK5aHNVl4OWXZOiWasz4p
 EjR1OM7Eqz4/C+t0jPFBDuyCbZIhjZCUzfFAvpaxCeikO/0wvwvQpgPi6qIt3DrndI6B
 qF1A==
X-Gm-Message-State: AOJu0YyEaLBXxZ+NAb8CzWuyiHmWy9RZtTRHlaD3Bg6BG1fwuzsLEOaJ
 h6EYM3YqZ4YcpiTZTwdqXN2Hr8VHmYCH0YFGLy8Jj3EuW3bxK76+rfhJTMUSFw==
X-Gm-Gg: AR+sD12kfc3X8irLVHOoIeBmOai6xZTknBwAu+rkqgkbXpncC99vSNZYa3d1yCfTI+9
 zTnNBXffg14qa22O+Fs0CBw02KKpSssbg4f/OROsSW7e5lx08UnIVAUlSG8s7N1+d/L7eMiqEik
 ubFgJjA8qOsk7HipVUf1NK9svF87aR3/Ff/EeA3qq4iiAs7cq0Ol6+QC5kcbLSsJ41AN904ziWR
 f1Ybo/Qj9Jsv0v0UfAPeknHmE29ua/GtgKd7hC5qiR7K6buqm33rbjGVGKEap5sdlyPEBFJxg3v
 xVbPRaIVnsGeUvjp8Ur69g8aLyNs0baSFneWyOB9EsZ6WRLSjZKJFglnYPxiBJHTBOtvIbd1Asm
 2MpbaVNeyB7G8rSi/IUjwmQ03jpzhpSInmdqdcTWpCAccejMREIGUmfe667320U3n35AQXyNz9q
 EEpUpq94+NgFzZLQkgS86iqLvnLwuzqTj4aQSu1I3sgbvGJoKIy3apWmaBhrjiTjBI79e/LbNFU
 CZaH7A=
X-Received: by 2002:a17:90b:4fc9:b0:38e:740f:9764 with SMTP id
 98e67ed59e1d1-3903c5f6477mr22895427a91.18.1786099084929; 
 Fri, 07 Aug 2026 03:38:04 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085c393d5sm4474743a91.0.2026.08.07.03.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:38:04 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 j-young.choi@samsung.com, mikail.sadic@ibm.com, hyenc.jeong@samsung.com
Subject: [PATCH 1/2] hw/ufs: Separate the controller core from the PCI frontend
Date: Fri,  7 Aug 2026 19:36:16 +0900
Message-ID: <6f0a70394e7fcad24daf1b1cffd3b23494893b29.1786096976.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786096976.git.jeuk20.kim@samsung.com>
References: <cover.1786096976.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UfsHc is currently also the PCI device instance, tying common code to
PCI-specific DMA and IRQ interfaces and preventing reuse by non-PCI
frontends.

Make UfsHc transport-independent and embed it in UfsPciState. Move the
PCI-specific handling to ufs-pci.c, pass the owning DeviceState and DMA
AddressSpace to the core, and record the core explicitly in UfsBus.

Split the common implementation into CONFIG_UFS, selected by
CONFIG_UFS_PCI. The user-visible "ufs" device and its properties remain
unchanged. No functional change is intended.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/Kconfig      |   5 ++
 hw/ufs/lu.c         |   2 +-
 hw/ufs/meson.build  |   3 +-
 hw/ufs/trace-events |   4 +-
 hw/ufs/ufs-pci.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c        | 108 +++++++++---------------------------------
 hw/ufs/ufs.h        |  14 ++++--
 7 files changed, 154 insertions(+), 94 deletions(-)
 create mode 100644 hw/ufs/ufs-pci.c

diff --git a/hw/ufs/Kconfig b/hw/ufs/Kconfig
index b7b3392e85..47e28a30ea 100644
--- a/hw/ufs/Kconfig
+++ b/hw/ufs/Kconfig
@@ -1,4 +1,9 @@
+config UFS
+    bool
+    select SCSI
+
 config UFS_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select UFS
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 13f4a90145..eeca865eb5 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -497,7 +497,7 @@ static void ufs_lu_realize(DeviceState *dev, Error **errp)
 {
     UfsLu *lu = DO_UPCAST(UfsLu, qdev, dev);
     BusState *s = qdev_get_parent_bus(dev);
-    UfsHc *u = UFS(s->parent);
+    UfsHc *u = UFS_BUS(s)->hc;
     BlockBackend *blk = lu->conf.blk;
 
     if (!ufs_lu_check_constraints(lu, errp)) {
diff --git a/hw/ufs/meson.build b/hw/ufs/meson.build
index 6e68328b93..880fc52c05 100644
--- a/hw/ufs/meson.build
+++ b/hw/ufs/meson.build
@@ -1 +1,2 @@
-system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_UFS', if_true: files('ufs.c', 'lu.c'))
+system_ss.add(when: 'CONFIG_UFS_PCI', if_true: files('ufs-pci.c'))
diff --git a/hw/ufs/trace-events b/hw/ufs/trace-events
index 662d9afee3..0cd3ba9b02 100644
--- a/hw/ufs/trace-events
+++ b/hw/ufs/trace-events
@@ -1,6 +1,6 @@
 # ufs.c
-ufs_irq_raise(void) "INTx"
-ufs_irq_lower(void) "INTx"
+ufs_irq_raise(void) "IRQ"
+ufs_irq_lower(void) "IRQ"
 ufs_mmio_read(uint64_t addr, uint64_t data, unsigned size) "addr 0x%"PRIx64" data 0x%"PRIx64" size %d"
 ufs_mmio_write(uint64_t addr, uint64_t data, unsigned size) "addr 0x%"PRIx64" data 0x%"PRIx64" size %d"
 ufs_process_db(uint32_t slot) "UTRLDBR slot %"PRIu32""
diff --git a/hw/ufs/ufs-pci.c b/hw/ufs/ufs-pci.c
new file mode 100644
index 0000000000..10e4f06c72
--- /dev/null
+++ b/hw/ufs/ufs-pci.c
@@ -0,0 +1,112 @@
+/*
+ * QEMU Universal Flash Storage (UFS) PCI Controller
+ *
+ * Copyright (c) 2023 Samsung Electronics Co., Ltd. All rights reserved.
+ *
+ * Written by Jeuk Kim <jeuk20.kim@samsung.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/**
+ * Usage
+ * -----
+ *
+ * Add options:
+ *      -drive file=<file>,if=none,id=<drive_id>
+ *      -device ufs,serial=<serial>,id=<bus_name>, \
+ *              nutrs=<N[optional]>,nutmrs=<N[optional]>
+ *      -device ufs-lu,drive=<drive_id>,bus=<bus_name>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
+#include "migration/vmstate.h"
+#include "ufs.h"
+
+#define TYPE_UFS_PCI "ufs"
+OBJECT_DECLARE_SIMPLE_TYPE(UfsPciState, UFS_PCI)
+
+struct UfsPciState {
+    PCIDevice parent_obj;
+    UfsHc ufs;
+};
+
+static void ufs_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    UfsPciState *s = UFS_PCI(pci_dev);
+    UfsHc *u = &s->ufs;
+    uint8_t *pci_conf = pci_dev->config;
+
+    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_config_set_prog_interface(pci_conf, 0x1);
+    u->irq = pci_allocate_irq(pci_dev);
+    if (!ufs_realize(u, DEVICE(pci_dev), pci_get_address_space(pci_dev),
+                     errp)) {
+        qemu_free_irq(u->irq);
+        u->irq = NULL;
+        return;
+    }
+
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
+}
+
+static void ufs_pci_exit(PCIDevice *pci_dev)
+{
+    UfsPciState *s = UFS_PCI(pci_dev);
+
+    ufs_unrealize(&s->ufs);
+    qemu_free_irq(s->ufs.irq);
+}
+
+static const Property ufs_pci_props[] = {
+    DEFINE_PROP_STRING("serial", UfsPciState, ufs.params.serial),
+    DEFINE_PROP_UINT8("nutrs", UfsPciState, ufs.params.nutrs, 32),
+    DEFINE_PROP_UINT8("nutmrs", UfsPciState, ufs.params.nutmrs, 8),
+    DEFINE_PROP_BOOL("mcq", UfsPciState, ufs.params.mcq, false),
+    DEFINE_PROP_UINT8("mcq-maxq", UfsPciState, ufs.params.mcq_maxq, 2),
+    DEFINE_PROP_UINT32("wb-max-size", UfsPciState,
+                       ufs.params.wb_max_size, 0x400),
+    DEFINE_PROP_UINT32("wb-min-size", UfsPciState,
+                       ufs.params.wb_min_size, 0x100),
+};
+
+static const VMStateDescription ufs_pci_vmstate = {
+    .name = "ufs",
+    .unmigratable = 1,
+};
+
+static void ufs_pci_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = ufs_pci_realize;
+    pc->exit = ufs_pci_exit;
+    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
+    pc->class_id = PCI_CLASS_STORAGE_UFS;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "Universal Flash Storage";
+    device_class_set_props(dc, ufs_pci_props);
+    dc->vmsd = &ufs_pci_vmstate;
+}
+
+static const TypeInfo ufs_pci_info = {
+    .name = TYPE_UFS_PCI,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = ufs_pci_class_init,
+    .instance_size = sizeof(UfsPciState),
+    .interfaces = (const InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
+};
+
+static void ufs_pci_register_types(void)
+{
+    type_register_static(&ufs_pci_info);
+}
+
+type_init(ufs_pci_register_types)
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 464fd465b3..36c674af32 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -11,19 +11,10 @@
 /**
  * Reference Specs: https://www.jedec.org/, 4.1
  *
- * Usage
- * -----
- *
- * Add options:
- *      -drive file=<file>,if=none,id=<drive_id>
- *      -device ufs,serial=<serial>,id=<bus_name>, \
- *              nutrs=<N[optional]>,nutmrs=<N[optional]>
- *      -device ufs-lu,drive=<drive_id>,bus=<bus_name>
  */
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "migration/vmstate.h"
 #include "scsi/constants.h"
 #include "hw/core/irq.h"
 #include "trace.h"
@@ -102,7 +93,8 @@ static MemTxResult ufs_addr_read(UfsHc *u, hwaddr addr, void *buf, int size)
         return MEMTX_DECODE_ERROR;
     }
 
-    return pci_dma_read(PCI_DEVICE(u), addr, buf, size);
+    return dma_memory_read(u->dma_as, addr, buf, size,
+                           MEMTXATTRS_UNSPECIFIED);
 }
 
 static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
@@ -117,7 +109,8 @@ static MemTxResult ufs_addr_write(UfsHc *u, hwaddr addr, const void *buf,
         return MEMTX_DECODE_ERROR;
     }
 
-    return pci_dma_write(PCI_DEVICE(u), addr, buf, size);
+    return dma_memory_write(u->dma_as, addr, buf, size,
+                            MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline hwaddr ufs_get_utrd_addr(UfsHc *u, uint32_t slot)
@@ -222,7 +215,7 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
     }
 
     req->sg = g_malloc0(sizeof(QEMUSGList));
-    pci_dma_sglist_init(req->sg, PCI_DEVICE(u), prdt_len);
+    qemu_sglist_init(req->sg, u->dev, prdt_len, u->dma_as);
     req->data_len = 0;
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
@@ -317,14 +310,12 @@ static MemTxResult ufs_dma_write_upiu(UfsRequest *req)
 
 static void ufs_irq_check(UfsHc *u)
 {
-    PCIDevice *pci = PCI_DEVICE(u);
-
     if ((u->reg.is & UFS_INTR_MASK) & u->reg.ie) {
         trace_ufs_irq_raise();
-        pci_irq_assert(pci);
+        qemu_irq_raise(u->irq);
     } else {
         trace_ufs_irq_lower();
-        pci_irq_deassert(pci);
+        qemu_irq_lower(u->irq);
     }
 }
 
@@ -596,7 +587,7 @@ static bool ufs_mcq_create_sq(UfsHc *u, uint8_t qid, uint32_t attr)
     sq->size = qsize;
 
     sq->bh = qemu_bh_new_guarded(ufs_mcq_process_sq, sq,
-                                 &DEVICE(u)->mem_reentrancy_guard);
+                                 &u->dev->mem_reentrancy_guard);
     sq->req = g_new0(UfsRequest, sq->size);
     QTAILQ_INIT(&sq->req_list);
     for (int i = 0; i < sq->size; i++) {
@@ -690,7 +681,7 @@ static bool ufs_mcq_create_cq(UfsHc *u, uint8_t qid, uint32_t attr)
     cq->size = qsize;
 
     cq->bh = qemu_bh_new_guarded(ufs_mcq_process_cq, cq,
-                                 &DEVICE(u)->mem_reentrancy_guard);
+                                 &u->dev->mem_reentrancy_guard);
     QTAILQ_INIT(&cq->req_list);
 
     u->cq[qid] = cq;
@@ -2488,19 +2479,6 @@ static bool ufs_check_constraints(UfsHc *u, Error **errp)
     return true;
 }
 
-static void ufs_init_pci(UfsHc *u, PCIDevice *pci_dev)
-{
-    uint8_t *pci_conf = pci_dev->config;
-
-    pci_conf[PCI_INTERRUPT_PIN] = 1;
-    pci_config_set_prog_interface(pci_conf, 0x1);
-
-    memory_region_init_io(&u->iomem, OBJECT(u), &ufs_mmio_ops, u, "ufs",
-                          u->reg_size);
-    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &u->iomem);
-    u->irq = pci_allocate_irq(pci_dev);
-}
-
 static void ufs_init_state(UfsHc *u)
 {
     u->req_list = g_new0(UfsRequest, u->params.nutrs);
@@ -2513,9 +2491,9 @@ static void ufs_init_state(UfsHc *u)
     }
 
     u->doorbell_bh = qemu_bh_new_guarded(ufs_process_req, u,
-                                         &DEVICE(u)->mem_reentrancy_guard);
+                                         &u->dev->mem_reentrancy_guard);
     u->complete_bh = qemu_bh_new_guarded(ufs_sendback_req, u,
-                                         &DEVICE(u)->mem_reentrancy_guard);
+                                         &u->dev->mem_reentrancy_guard);
 
     if (u->params.mcq) {
         memset(u->sq, 0, sizeof(u->sq));
@@ -2689,35 +2667,36 @@ static void ufs_init_hc(UfsHc *u)
     timer_mod(&u->idle_timer, now + UFS_IDLE_TIMER_TICK);
 }
 
-static void ufs_realize(PCIDevice *pci_dev, Error **errp)
+bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
+                 Error **errp)
 {
-    UfsHc *u = UFS(pci_dev);
+    u->dev = dev;
+    u->dma_as = dma_as;
 
     if (!ufs_check_constraints(u, errp)) {
-        return;
+        return false;
     }
 
-    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, &pci_dev->qdev,
-              u->parent_obj.qdev.id);
+    qbus_init(&u->bus, sizeof(UfsBus), TYPE_UFS_BUS, dev, dev->id);
+    u->bus.hc = u;
 
     ufs_init_state(u);
     ufs_init_hc(u);
-    ufs_init_pci(u, pci_dev);
+    memory_region_init_io(&u->iomem, OBJECT(dev), &ufs_mmio_ops, u, "ufs",
+                          u->reg_size);
 
     ufs_init_wlu(&u->report_wlu, UFS_UPIU_REPORT_LUNS_WLUN);
     ufs_init_wlu(&u->dev_wlu, UFS_UPIU_UFS_DEVICE_WLUN);
     ufs_init_wlu(&u->boot_wlu, UFS_UPIU_BOOT_WLUN);
     ufs_init_wlu(&u->rpmb_wlu, UFS_UPIU_RPMB_WLUN);
+
+    return true;
 }
 
-static void ufs_exit(PCIDevice *pci_dev)
+void ufs_unrealize(UfsHc *u)
 {
-    UfsHc *u = UFS(pci_dev);
-
     timer_del(&u->idle_timer);
 
-    qemu_free_irq(u->irq);
-
     qemu_bh_delete(u->doorbell_bh);
     qemu_bh_delete(u->complete_bh);
 
@@ -2740,38 +2719,6 @@ static void ufs_exit(PCIDevice *pci_dev)
     }
 }
 
-static const Property ufs_props[] = {
-    DEFINE_PROP_STRING("serial", UfsHc, params.serial),
-    DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
-    DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
-    DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
-    DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 2),
-    DEFINE_PROP_UINT32("wb-max-size", UfsHc, params.wb_max_size, 0x400),
-    DEFINE_PROP_UINT32("wb-min-size", UfsHc, params.wb_min_size, 0x100),
-};
-
-static const VMStateDescription ufs_vmstate = {
-    .name = "ufs",
-    .unmigratable = 1,
-};
-
-static void ufs_class_init(ObjectClass *oc, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
-
-    pc->realize = ufs_realize;
-    pc->exit = ufs_exit;
-    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
-    pc->device_id = PCI_DEVICE_ID_REDHAT_UFS;
-    pc->class_id = PCI_CLASS_STORAGE_UFS;
-
-    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    dc->desc = "Universal Flash Storage";
-    device_class_set_props(dc, ufs_props);
-    dc->vmsd = &ufs_vmstate;
-}
-
 static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
                                   Error **errp)
 {
@@ -2798,14 +2745,6 @@ static void ufs_bus_class_init(ObjectClass *class, const void *data)
     bc->check_address = ufs_bus_check_address;
 }
 
-static const TypeInfo ufs_info = {
-    .name = TYPE_UFS,
-    .parent = TYPE_PCI_DEVICE,
-    .class_init = ufs_class_init,
-    .instance_size = sizeof(UfsHc),
-    .interfaces = (const InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
-};
-
 static const TypeInfo ufs_bus_info = {
     .name = TYPE_UFS_BUS,
     .parent = TYPE_BUS,
@@ -2816,7 +2755,6 @@ static const TypeInfo ufs_bus_info = {
 
 static void ufs_register_types(void)
 {
-    type_register_static(&ufs_info);
     type_register_static(&ufs_bus_info);
 }
 
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index feb47f460d..aa8361d93d 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -11,9 +11,11 @@
 #ifndef HW_UFS_UFS_H
 #define HW_UFS_UFS_H
 
-#include "hw/pci/pci_device.h"
+#include "hw/core/qdev.h"
 #include "hw/scsi/scsi.h"
 #include "block/ufs.h"
+#include "scsi/constants.h"
+#include "system/dma.h"
 
 #define UFS_MAX_LUS 32
 #define UFS_MAX_MCQ_QNUM 32
@@ -27,6 +29,7 @@ typedef struct UfsBusClass {
 
 typedef struct UfsBus {
     BusState parent_bus;
+    struct UfsHc *hc;
 } UfsBus;
 
 #define TYPE_UFS_BUS "ufs-bus"
@@ -141,7 +144,8 @@ typedef struct UfsWb {
 } UfsWb;
 
 typedef struct UfsHc {
-    PCIDevice parent_obj;
+    DeviceState *dev;
+    AddressSpace *dma_as;
     UfsBus bus;
     MemoryRegion iomem;
     UfsReg reg;
@@ -268,9 +272,6 @@ static inline bool ufs_is_write_req(UfsRequest *req)
     return (cmd == WRITE_6) || (cmd == WRITE_10) || (cmd == WRITE_16);
 }
 
-#define TYPE_UFS "ufs"
-#define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
-
 #define TYPE_UFS_LU "ufs-lu"
 #define UFSLU(obj) OBJECT_CHECK(UfsLu, (obj), TYPE_UFS_LU)
 
@@ -302,4 +303,7 @@ void ufs_build_query_response(UfsRequest *req);
 void ufs_complete_req(UfsRequest *req, UfsReqResult req_result);
 void ufs_wb_update_avail_buffer(UfsHc *u);
 void ufs_init_wlu(UfsLu *wlu, uint8_t wlun);
+bool ufs_realize(UfsHc *u, DeviceState *dev, AddressSpace *dma_as,
+                 Error **errp);
+void ufs_unrealize(UfsHc *u);
 #endif /* HW_UFS_UFS_H */
-- 
2.43.0


