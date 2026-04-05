Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016BDE64016
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvU-0003yr-M4; Sun, 05 Apr 2026 03:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvT-0003yC-82
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:43 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvQ-0007Px-Oa
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:43 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2cf1646bd11so348020eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374179; x=1775978979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fWuxDaZI7ELjXX3VdrMom5tpL3p2EOAcG4ltkUwfmlI=;
 b=hd64ncbPiGbELjHIkCPLOZwPWamN5YQ8kOjRpS4u28JeWHN3980jmI4qFLAPdUWmY1
 aUZCbTZfpg4GRDhVBN5iL0FkWe0BN37ZeBcK6qQU7N1DgFG3dpYgT+ZUGv6EqZ9ZFQgt
 hALLTT4OHaVrHx3N5hlnI2wOa6bPOc/jkBR1VrM50E7ltw+Dq1sE5MhFisLL2m/dbfOw
 8pT9+Y+GT4q6zQt9GJgRjcrm1Xmv3513A/aV2vqDZD+eNcYIqmyBKeo7bNkEKF88o0Jp
 MFKA3xL74ZuuZqnAfjZAxwPhI0i8XEBBglyylt+JFcWiYdB4vs9a6m7W23ulEWw9NJwl
 SoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374179; x=1775978979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fWuxDaZI7ELjXX3VdrMom5tpL3p2EOAcG4ltkUwfmlI=;
 b=YNlJKxAP13cX4kr5Uo15Zh5b63DhEamiahUpXXs3ZVZWiJIBESYRFN9z/vvvfWUzfQ
 2WzNWAHyvazhtHOMAA6GcRkuZN1l2ZNUicVuFz42iznoYug6QZ/cLUkX2P1+2JQPjrf5
 JqzwwpG8k+bPsAQ2NeQvgsgr7UztksTxajdE9MEVTB/WW41VVWMxKl7IibUcvvjIXygq
 kT/OyaxeWbSgGXtOFyNqgza0fXFKFYj2Zmtrwdw98zbBq2YRxZ5hCNbHX6JZv/xZ6iz0
 cj/s0jvkaXTTLzAfeQwc0rH684j4L73Pmwx64j8nrgYH8lLVLmpfEExP7OmRD8KtiAWx
 1KpA==
X-Gm-Message-State: AOJu0Yx1cO8hLrJCQ+FLeE/vxmCRHwszLw66mkDsN6YsWFlkobVDufV3
 A5Dw2fc2qcV4bWX+ilDUDbgaTrGBw3IUGg/uwF08TRyKtK2o6IZ+SanHpetPVhzRg0I=
X-Gm-Gg: AeBDiet28+eErUrAKMSqPRC2eOfdbop4oWdkrkKKNhF12s2QRf3UHFraXBIHvhowHr4
 zigyqfFcrvPcLfHCQNiXgTZM7QmT37symahYpfiTDDM+D7K0rzIDgNXbI6zJRc3xV5i5S1goEXs
 M+H8WUdPYw0go1UDpgcEdlUlrT1EXbuAsHCZtzJJPaCyQ2IlItwJhkGXmX3KDgGqDopl8hhSa43
 92Mcvm5+xq6T+tOlfIv6+F3ElB3Nc7DfKtn8qOS8PkRvTEJLr883hrdRp+qJ1J1jTQFYjffbbvw
 03mkt8cmqyYYSgTyL7bHXQthCopkoffS9Ukwb9kZ7N8jlGOa9CG7c+uaShP2sQXP6iXXDe2/+Gq
 52c/1IZ4e0M9LcTgLfvSlB6NKa90zyT6WM4/jkZTG5TSBKymT1XuBMa51m9Lh7KSOGDBdC2AR42
 QZMACg1T34sTX3lZJaDnsV5WzZYDaFM05IlE+7arDvt29rxA/kWaTQq8WV87XUJGj2XM1drwiiH
 NHcfQh8fdFKqHnI1UoIUJjt/3Q=
X-Received: by 2002:a05:693c:3018:b0:2c0:cc90:a71 with SMTP id
 5a478bee46e88-2cbf9df22d4mr3755706eec.8.1775374178818; 
 Sun, 05 Apr 2026 00:29:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:38 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjg@umich.edu>,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 09/10] vfio/apple: Add apple-dma-pci companion device
Date: Sun,  5 Apr 2026 00:28:53 -0700
Message-ID: <20260405072857.66484-10-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: "Scott J. Goldman" <scottjg@umich.edu>

Add a virtual PCI device ("apple-dma-pci") that acts as the DMA
mapping companion for passthrough devices on macOS.

On Linux, the kernel VFIO driver can directly map guest RAM into the
hardware IOMMU.  On macOS, the DriverKit dext can only DMA-map memory
that belongs to its client process (QEMU).  The guest kernel needs a
way to request DMA mappings for its buffers through the host.

apple-dma-pci provides a simple MMIO register interface in the guest:
the guest driver writes DMA mapping requests (IOVA, GPA, size) to the
device's BAR, and the QEMU device model translates GPAs to HVAs and
calls through to the dext to establish the physical IOMMU mapping.

The device uses PCI vendor/device ID 1b36:0015 (Red Hat, Inc.).

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 docs/specs/pci-ids.rst |   3 +
 hw/vfio/apple-dma.c    | 540 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build    |   5 +-
 include/hw/pci/pci.h   |   1 +
 4 files changed, 546 insertions(+), 3 deletions(-)
 create mode 100644 hw/vfio/apple-dma.c

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359f..48229dab5d 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -100,6 +100,9 @@ PCI devices (other than virtio):
   PCI UFS device (``-device ufs``)
 1b36:0014
   PCI RISC-V IOMMU device
+1b36:0015
+  Apple DMA mapping device (``-device apple-dma-pci``,
+  :doc:`../system/devices/vfio-apple`)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/hw/vfio/apple-dma.c b/hw/vfio/apple-dma.c
new file mode 100644
index 0000000000..e705179b0d
--- /dev/null
+++ b/hw/vfio/apple-dma.c
@@ -0,0 +1,540 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Apple DMA mapping PCI device
+ *
+ * A simple PCI device that receives batched DMA map/unmap requests from
+ * the guest via a shared command page + doorbell register, resolves guest
+ * physical addresses to host virtual addresses, and registers them with
+ * the macOS DriverKit dext for DART mapping.
+ *
+ * Protocol:
+ *   1. Guest allocates a command page and request/response buffers in RAM.
+ *   2. Guest writes the command page GPA to BAR registers (one-time setup).
+ *   3. Per batch: guest fills the command page and request buffer (no VMEXIT),
+ *      then writes the doorbell register (single VMEXIT triggers processing).
+ *   4. Device reads the command page, processes all entries, writes responses
+ *      and status back to guest RAM before the doorbell write returns.
+ *
+ * Copyright (c) 2026 Scott J. Goldman
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/pci/pci_device.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/vfio/apple-dext-client.h"
+#include "hw/vfio/apple.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "system/address-spaces.h"
+#include "system/dma.h"
+#include "system/memory.h"
+
+#include "hw/pci/pci.h"
+
+/* BAR0 register offsets */
+#define APPLE_DMA_REG_VERSION       0x00    /* R:  protocol version */
+#define APPLE_DMA_REG_MANAGED_BDF   0x04    /* R:  guest BDF this maps for */
+#define APPLE_DMA_REG_MAX_ENTRIES   0x08    /* R:  max entries per batch */
+#define APPLE_DMA_REG_STATUS        0x0C    /* R:  result of last doorbell */
+#define APPLE_DMA_REG_CMD_GPA_LO    0x10    /* W:  command page GPA [31:0] */
+#define APPLE_DMA_REG_CMD_GPA_HI    0x14    /* W:  command page GPA [63:32] */
+#define APPLE_DMA_REG_DOORBELL      0x18    /* W:  any write triggers batch */
+#define APPLE_DMA_BAR_SIZE          0x1000  /* page-aligned */
+
+#define APPLE_DMA_VERSION           2
+#define APPLE_DMA_MAX_ENTRIES       4096
+
+/* Command types (in command page) */
+#define APPLE_DMA_CMD_MAP           1
+#define APPLE_DMA_CMD_UNMAP         2
+
+/* Status codes */
+#define APPLE_DMA_S_OK              0
+#define APPLE_DMA_S_IOERR           1
+#define APPLE_DMA_S_INVAL           3
+
+/*
+ * Command page layout (in guest RAM, 32 bytes):
+ *
+ *   0x00  uint32_t  type         MAP=1, UNMAP=2
+ *   0x04  uint32_t  count        number of entries
+ *   0x08  uint32_t  status       (written by device) 0=OK
+ *   0x0C  uint32_t  reserved
+ *   0x10  uint64_t  req_gpa      GPA of request entries array
+ *   0x18  uint64_t  resp_gpa     GPA of response entries array
+ */
+#define CMD_OFF_TYPE      0x00
+#define CMD_OFF_COUNT     0x04
+#define CMD_OFF_STATUS    0x08
+#define CMD_OFF_REQ_GPA   0x10
+#define CMD_OFF_RESP_GPA  0x18
+#define CMD_PAGE_SIZE     0x20
+
+/*
+ * Map request entry (16 bytes):
+ *   uint64_t gpa, uint32_t len, uint32_t flags
+ *
+ * Map response entry (24 bytes):
+ *   uint64_t id, uint64_t dma_addr, uint32_t dma_len, uint32_t status
+ *
+ * Unmap request entry (16 bytes):
+ *   uint64_t id, uint64_t size
+ *
+ * Unmap response entry (16 bytes):
+ *   uint64_t id, uint32_t status, uint32_t reserved
+ */
+
+typedef struct AppleDMAMapReq {
+    uint64_t gpa;
+    uint32_t len;
+    uint32_t flags;
+} QEMU_PACKED AppleDMAMapReq;
+
+typedef struct AppleDMAMapResp {
+    uint64_t id;
+    uint64_t dma_addr;
+    uint32_t dma_len;
+    uint32_t status;
+} QEMU_PACKED AppleDMAMapResp;
+
+typedef struct AppleDMAUnmapReq {
+    uint64_t id;
+    uint64_t size;
+} QEMU_PACKED AppleDMAUnmapReq;
+
+typedef struct AppleDMAUnmapResp {
+    uint64_t id;
+    uint32_t status;
+    uint32_t reserved;
+} QEMU_PACKED AppleDMAUnmapResp;
+
+#define TYPE_APPLE_DMA_PCI "apple-dma-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(AppleDMAState, APPLE_DMA_PCI)
+
+struct AppleDMAState {
+    PCIDevice parent_obj;
+
+    MemoryRegion bar;
+
+    /* Configuration (set via properties) */
+    uint32_t managed_bdf;
+    uint32_t max_entries;
+    uint32_t apple_host_bus;
+    uint32_t apple_host_device;
+    uint32_t apple_host_function;
+
+    /* Runtime state */
+    uint64_t cmd_gpa;
+    uint32_t last_status;
+    io_connect_t dext_conn;
+    bool shared_dext_conn;
+};
+
+/* ------------------------------------------------------------------ */
+/* DMA backend operations                                              */
+/* ------------------------------------------------------------------ */
+
+static bool apple_dma_backend_map(AppleDMAState *s, uint64_t gpa, uint32_t size,
+                                  uint64_t *out_dma_addr, uint32_t *out_dma_len)
+{
+    hwaddr map_len = size;
+    void *hva;
+    uint64_t bus_addr = 0, bus_len = 0;
+
+    hva = dma_memory_map(&address_space_memory, gpa, &map_len,
+                         DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
+    if (!hva || map_len < size) {
+        if (hva) {
+            dma_memory_unmap(&address_space_memory, hva, map_len,
+                             DMA_DIRECTION_TO_DEVICE, 0);
+        }
+        return false;
+    }
+
+    /*
+     * Use the GPA as the dext lookup key. The dext treats this as an
+     * opaque handle for matching register/unregister calls; the actual
+     * DMA bus address is assigned by the platform and returned in
+     * bus_addr.
+     */
+    if (s->dext_conn != IO_OBJECT_NULL) {
+        kern_return_t kr;
+
+        kr = apple_dext_register_dma(s->dext_conn, gpa,
+                                     (uint64_t)hva, size,
+                                     &bus_addr, &bus_len);
+        dma_memory_unmap(&address_space_memory, hva, map_len,
+                         DMA_DIRECTION_TO_DEVICE, 0);
+        if (kr != KERN_SUCCESS) {
+            return false;
+        }
+        *out_dma_addr = bus_addr;
+        *out_dma_len = (uint32_t)bus_len;
+    } else {
+        dma_memory_unmap(&address_space_memory, hva, map_len,
+                         DMA_DIRECTION_TO_DEVICE, 0);
+        *out_dma_addr = gpa;
+        *out_dma_len = size;
+    }
+
+    return true;
+}
+
+static uint32_t apple_dma_backend_unmap(AppleDMAState *s, uint64_t id)
+{
+    if (s->dext_conn != IO_OBJECT_NULL) {
+        kern_return_t kr;
+
+        kr = apple_dext_unregister_dma(s->dext_conn, id);
+        if (kr != KERN_SUCCESS) {
+            return APPLE_DMA_S_IOERR;
+        }
+    }
+
+    return APPLE_DMA_S_OK;
+}
+
+/* ------------------------------------------------------------------ */
+/* Doorbell — process a batch from the command page                    */
+/* ------------------------------------------------------------------ */
+
+static void apple_dma_handle_map(AppleDMAState *s, uint64_t req_gpa,
+                                 uint64_t resp_gpa, uint32_t count)
+{
+    AddressSpace *as = &address_space_memory;
+    hwaddr req_len = count * sizeof(AppleDMAMapReq);
+    hwaddr resp_len = count * sizeof(AppleDMAMapResp);
+    AppleDMAMapReq *reqs;
+    AppleDMAMapResp *resps;
+    uint32_t i;
+    bool ok = true;
+
+    reqs = dma_memory_map(as, req_gpa, &req_len, DMA_DIRECTION_TO_DEVICE,
+                          MEMTXATTRS_UNSPECIFIED);
+    if (!reqs || req_len < count * sizeof(AppleDMAMapReq)) {
+        if (reqs) {
+            dma_memory_unmap(as, reqs, req_len, DMA_DIRECTION_TO_DEVICE, 0);
+        }
+        s->last_status = APPLE_DMA_S_INVAL;
+        return;
+    }
+
+    resps = dma_memory_map(as, resp_gpa, &resp_len, DMA_DIRECTION_FROM_DEVICE,
+                           MEMTXATTRS_UNSPECIFIED);
+    if (!resps || resp_len < count * sizeof(AppleDMAMapResp)) {
+        if (resps) {
+            dma_memory_unmap(as, resps, resp_len,
+                             DMA_DIRECTION_FROM_DEVICE, 0);
+        }
+        dma_memory_unmap(as, reqs, req_len, DMA_DIRECTION_TO_DEVICE, 0);
+        s->last_status = APPLE_DMA_S_INVAL;
+        return;
+    }
+
+    for (i = 0; i < count; i++) {
+        uint64_t gpa = le64_to_cpu(reqs[i].gpa);
+        uint64_t dma_addr = 0;
+        uint32_t dma_len = 0;
+
+        if (apple_dma_backend_map(s, gpa, le32_to_cpu(reqs[i].len),
+                                  &dma_addr, &dma_len)) {
+            resps[i].id = cpu_to_le64(gpa);
+            resps[i].dma_addr = cpu_to_le64(dma_addr);
+            resps[i].dma_len = cpu_to_le32(dma_len);
+            resps[i].status = cpu_to_le32(APPLE_DMA_S_OK);
+        } else {
+            resps[i].status = cpu_to_le32(APPLE_DMA_S_IOERR);
+            ok = false;
+        }
+    }
+
+    s->last_status = ok ? APPLE_DMA_S_OK : APPLE_DMA_S_IOERR;
+    dma_memory_unmap(as, resps, resp_len, DMA_DIRECTION_FROM_DEVICE,
+                     resp_len);
+    dma_memory_unmap(as, reqs, req_len, DMA_DIRECTION_TO_DEVICE, 0);
+}
+
+static void apple_dma_handle_unmap(AppleDMAState *s, uint64_t req_gpa,
+                                   uint64_t resp_gpa, uint32_t count)
+{
+    AddressSpace *as = &address_space_memory;
+    hwaddr req_len = count * sizeof(AppleDMAUnmapReq);
+    hwaddr resp_len = count * sizeof(AppleDMAUnmapResp);
+    AppleDMAUnmapReq *reqs;
+    AppleDMAUnmapResp *resps;
+    uint32_t i;
+    bool ok = true;
+
+    reqs = dma_memory_map(as, req_gpa, &req_len, DMA_DIRECTION_TO_DEVICE,
+                          MEMTXATTRS_UNSPECIFIED);
+    if (!reqs || req_len < count * sizeof(AppleDMAUnmapReq)) {
+        if (reqs) {
+            dma_memory_unmap(as, reqs, req_len, DMA_DIRECTION_TO_DEVICE, 0);
+        }
+        s->last_status = APPLE_DMA_S_INVAL;
+        return;
+    }
+
+    resps = dma_memory_map(as, resp_gpa, &resp_len, DMA_DIRECTION_FROM_DEVICE,
+                           MEMTXATTRS_UNSPECIFIED);
+    if (!resps || resp_len < count * sizeof(AppleDMAUnmapResp)) {
+        if (resps) {
+            dma_memory_unmap(as, resps, resp_len,
+                             DMA_DIRECTION_FROM_DEVICE, 0);
+        }
+        dma_memory_unmap(as, reqs, req_len, DMA_DIRECTION_TO_DEVICE, 0);
+        s->last_status = APPLE_DMA_S_INVAL;
+        return;
+    }
+
+    for (i = 0; i < count; i++) {
+        uint64_t id = le64_to_cpu(reqs[i].id);
+        uint32_t status = apple_dma_backend_unmap(s, id);
+
+        resps[i].id = cpu_to_le64(id);
+        resps[i].status = cpu_to_le32(status);
+        if (status != APPLE_DMA_S_OK) {
+            ok = false;
+        }
+    }
+
+    s->last_status = ok ? APPLE_DMA_S_OK : APPLE_DMA_S_IOERR;
+    dma_memory_unmap(as, resps, resp_len, DMA_DIRECTION_FROM_DEVICE,
+                     resp_len);
+    dma_memory_unmap(as, reqs, req_len, DMA_DIRECTION_TO_DEVICE, 0);
+}
+
+static void apple_dma_doorbell(AppleDMAState *s)
+{
+    AddressSpace *as = &address_space_memory;
+    uint8_t cmd_buf[CMD_PAGE_SIZE];
+    uint32_t type, count;
+    uint64_t req_gpa, resp_gpa;
+    uint32_t le_status;
+
+    if (!s->cmd_gpa) {
+        s->last_status = APPLE_DMA_S_INVAL;
+        return;
+    }
+
+    if (dma_memory_read(as, s->cmd_gpa, cmd_buf, CMD_PAGE_SIZE,
+                        MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+        s->last_status = APPLE_DMA_S_INVAL;
+        return;
+    }
+
+    type = ldl_le_p(cmd_buf + CMD_OFF_TYPE);
+    count = ldl_le_p(cmd_buf + CMD_OFF_COUNT);
+    req_gpa = ldq_le_p(cmd_buf + CMD_OFF_REQ_GPA);
+    resp_gpa = ldq_le_p(cmd_buf + CMD_OFF_RESP_GPA);
+
+    if (!count || count > s->max_entries || !req_gpa || !resp_gpa) {
+        s->last_status = APPLE_DMA_S_INVAL;
+        goto write_status;
+    }
+
+    switch (type) {
+    case APPLE_DMA_CMD_MAP:
+        apple_dma_handle_map(s, req_gpa, resp_gpa, count);
+        break;
+    case APPLE_DMA_CMD_UNMAP:
+        apple_dma_handle_unmap(s, req_gpa, resp_gpa, count);
+        break;
+    default:
+        s->last_status = APPLE_DMA_S_INVAL;
+        break;
+    }
+
+write_status:
+    le_status = cpu_to_le32(s->last_status);
+    dma_memory_write(as, s->cmd_gpa + CMD_OFF_STATUS, &le_status, 4,
+                     MEMTXATTRS_UNSPECIFIED);
+}
+
+/* ------------------------------------------------------------------ */
+/* MMIO BAR handlers                                                   */
+/* ------------------------------------------------------------------ */
+
+static uint64_t apple_dma_bar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    AppleDMAState *s = opaque;
+
+    switch (addr) {
+    case APPLE_DMA_REG_VERSION:
+        return APPLE_DMA_VERSION;
+    case APPLE_DMA_REG_MANAGED_BDF:
+        return s->managed_bdf;
+    case APPLE_DMA_REG_MAX_ENTRIES:
+        return s->max_entries;
+    case APPLE_DMA_REG_STATUS:
+        return s->last_status;
+    default:
+        return 0;
+    }
+}
+
+static void apple_dma_bar_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    AppleDMAState *s = opaque;
+
+    switch (addr) {
+    case APPLE_DMA_REG_CMD_GPA_LO:
+        s->cmd_gpa = deposit64(s->cmd_gpa, 0, 32, val);
+        break;
+    case APPLE_DMA_REG_CMD_GPA_HI:
+        s->cmd_gpa = deposit64(s->cmd_gpa, 32, 32, val);
+        break;
+    case APPLE_DMA_REG_DOORBELL:
+        apple_dma_doorbell(s);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps apple_dma_bar_ops = {
+    .read = apple_dma_bar_read,
+    .write = apple_dma_bar_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+/* ------------------------------------------------------------------ */
+/* Dext connection                                                     */
+/* ------------------------------------------------------------------ */
+
+static bool apple_dma_connect_dext(AppleDMAState *s, Error **errp)
+{
+    io_connect_t conn;
+    kern_return_t kr;
+
+    conn = apple_vfio_dext_lookup(s->apple_host_bus, s->apple_host_device,
+                                  s->apple_host_function);
+    if (conn != IO_OBJECT_NULL) {
+        s->dext_conn = conn;
+        s->shared_dext_conn = true;
+        return true;
+    }
+
+    conn = apple_dext_connect(s->apple_host_bus, s->apple_host_device,
+                                  s->apple_host_function);
+    if (conn == IO_OBJECT_NULL) {
+        error_setg(errp,
+                   "apple-dma: could not connect to dext for host PCI "
+                   "%02x:%02x.%x",
+                   s->apple_host_bus, s->apple_host_device,
+                   s->apple_host_function);
+        return false;
+    }
+
+    kr = apple_dext_claim(conn);
+    if (kr != KERN_SUCCESS) {
+        error_setg(errp,
+                   "apple-dma: failed to claim dext-backed PCI device "
+                   "%02x:%02x.%x (kr=0x%x)",
+                   s->apple_host_bus, s->apple_host_device,
+                   s->apple_host_function, kr);
+        apple_dext_disconnect(conn);
+        return false;
+    }
+
+    s->dext_conn = conn;
+    s->shared_dext_conn = false;
+    return true;
+}
+
+/* ------------------------------------------------------------------ */
+/* PCI device lifecycle                                                */
+/* ------------------------------------------------------------------ */
+
+static void apple_dma_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    AppleDMAState *s = APPLE_DMA_PCI(pdev);
+
+    if (s->apple_host_bus == UINT32_MAX ||
+        s->apple_host_device == UINT32_MAX ||
+        s->apple_host_function == UINT32_MAX) {
+        error_setg(errp, "apple-dma: requires x-apple-host-bus, "
+                   "x-apple-host-device, and x-apple-host-function");
+        return;
+    }
+
+    if (!s->max_entries) {
+        s->max_entries = APPLE_DMA_MAX_ENTRIES;
+    }
+
+    if (!apple_dma_connect_dext(s, errp)) {
+        return;
+    }
+
+    memory_region_init_io(&s->bar, OBJECT(s), &apple_dma_bar_ops, s,
+                          "apple-dma-bar", APPLE_DMA_BAR_SIZE);
+    pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->bar);
+}
+
+static void apple_dma_pci_exit(PCIDevice *pdev)
+{
+    AppleDMAState *s = APPLE_DMA_PCI(pdev);
+
+    if (s->dext_conn != IO_OBJECT_NULL) {
+        if (s->shared_dext_conn) {
+            apple_vfio_dext_release(s->apple_host_bus, s->apple_host_device,
+                                    s->apple_host_function, s->dext_conn);
+        } else {
+            apple_dext_disconnect(s->dext_conn);
+        }
+        s->dext_conn = IO_OBJECT_NULL;
+    }
+}
+
+static const Property apple_dma_pci_properties[] = {
+    DEFINE_PROP_UINT32("managed-bdf", AppleDMAState, managed_bdf, 0),
+    DEFINE_PROP_UINT32("max-entries", AppleDMAState, max_entries, 0),
+    DEFINE_PROP_UINT32("x-apple-host-bus", AppleDMAState,
+                       apple_host_bus, UINT32_MAX),
+    DEFINE_PROP_UINT32("x-apple-host-device", AppleDMAState,
+                       apple_host_device, UINT32_MAX),
+    DEFINE_PROP_UINT32("x-apple-host-function", AppleDMAState,
+                       apple_host_function, UINT32_MAX),
+};
+
+static void apple_dma_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    pdc->realize = apple_dma_pci_realize;
+    pdc->exit = apple_dma_pci_exit;
+    pdc->vendor_id = PCI_VENDOR_ID_REDHAT;
+    pdc->device_id = PCI_DEVICE_ID_REDHAT_APPLE_DMA;
+    pdc->class_id = PCI_CLASS_SYSTEM_OTHER;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, apple_dma_pci_properties);
+    dc->desc = "Apple DMA mapping device";
+}
+
+static const TypeInfo apple_dma_pci_info = {
+    .name = TYPE_APPLE_DMA_PCI,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(AppleDMAState),
+    .class_init = apple_dma_pci_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void apple_dma_pci_register(void)
+{
+    type_register_static(&apple_dma_pci_info);
+}
+
+type_init(apple_dma_pci_register)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 473f8669f9..d7b4cbcc19 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -40,8 +40,7 @@ system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 # Apple VFIO backend
 if host_os == 'darwin'
   system_ss.add(when: 'CONFIG_VFIO',
-                if_true: [files('apple-device.c',
-                                'container-apple.c',
-                                'apple-dext-client.c'),
+                if_true: [files('apple-device.c', 'apple-dma.c',
+                                'container-apple.c', 'apple-dext-client.c'),
                           coref, iokit])
 endif
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091de..8e3fe77cc7 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -121,6 +121,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
+#define PCI_DEVICE_ID_REDHAT_APPLE_DMA   0x0015
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.50.1 (Apple Git-155)


