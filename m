Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E9ACCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 07:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBpKW-0003gl-0J; Thu, 23 Oct 2025 03:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vBWXC-0000eU-7v
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:57:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vBWX9-0004ru-7D
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:57:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-b6cdba2663dso670255a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761130652; x=1761735452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpHh/ZiT9QNuQEoxVuaZesFdPvQ35zAc5QxqzUmQ0Go=;
 b=Sb7NQE4ss5etf/H1cVwFos+EMs35XvY9kJ/HJQxtXL2ugKkSoOrJoV+Sc3AGdQqzH7
 3sru4cQymWko1NWvlzjJcf8jzDyhZHYK0VLTyRFUEaf01VvkcZTpIfdcWj/IrUCkXO5x
 N3RAwKdbmO0Tq7Hr7Q9PPvTOzjYHFXG4ObPdvc0VrQZPi3S2e4roxoH+Mm+6ArAOv9YX
 2vLj1ZgNlpTvFPAG/Fzy8dh8M2W2H6XvWs/5isYDYgV0Q+g6pt9hVrF9zCsaXJqhv3W/
 boQLh4nDo+kXLUfZsEJJWQrUO8fS0pNr5vmfEnT990i3NPFth0BHVIJU8AkyEPh7z3sc
 2Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761130652; x=1761735452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpHh/ZiT9QNuQEoxVuaZesFdPvQ35zAc5QxqzUmQ0Go=;
 b=uD4BhYYq2ZGmIw7NJuZuITAUJC31OuCyLbt4rwIU1/MPuab4BUVJUwPq3xMjhFDz5c
 TBppJP8yw2xW8PTkG4BsnIFV0GPQuBr16JO/TOVxq1Pi1WFJUoGSBJfnoW2tkE3hYKMe
 tcxTYnGNrT1wpl3/CL1gitl7IhuVtFubUcZO+tFzCwM/vWKPccA+6U05KoEuV0G66LF+
 4miZbNbldNypz86rBtDMvhzPW4NTpYXtF7z3qzNcnHuyQyZQ+Jz3E8B2vUvV5d988raq
 Cdqcl7Js2rXiKBhl5UXA5SNlgQbcr7a/NWXLuo8CpQtjVH4UhaYSQdLSxvon30YTnkC+
 2/lw==
X-Gm-Message-State: AOJu0Yy8beidLOF2e1D/WP/ajgDNGAtnE5VRZlJxVmRu4EzmpCU1UiSM
 A18+4l0+SN9RX2AAjKMdfD5ipD3uzq/kPUBzlHkX7pxxnZ1s9rD8FCLZLHURHsdRl9l0dA==
X-Gm-Gg: ASbGncu3/enC41T+4yJlPLkfykouV1kwI4nGtbq2mkEtqu0jZfOQqSgb0BZC60x7MUT
 nhkuYhIjA6RKJ+PX7pC66Z+jKp/mCzs7/rtVgvTGsEn44Rx7Xwe/gTp8+CdlrSJic+lJUoajpqP
 TwNnl8JCJ3IL+nEteS6tDn6xb6ZFoNyH2pha9qBHHW6suMBhwMC7i79aSSa2t1GtpdjBqVeWAT3
 0lXfbzRj/FXc4ADQ8hMrqJ4oqQ95M3UhAY4u/1nVFzEMKDllL//CVuxtzI34ojwIRKtybVROIu8
 Tf/m46sA1+Uru1hn3X8yebJ4O4GodeH/zC21UVK974S40hX3p7To/Fl8i6w3KIJwe1VXGCCbuLy
 unKfdprUvxWZu6fWJiocnEwD1eId3mGSpZ16PeILLDIWeM9Gtp5fLsfR/PzLT/I6+nXVTWSNC1w
 PCAZbj5StRMlZ2UHThOMZjWCTKF/FdVlNnwud3g43YAkRUhlJbsg==
X-Google-Smtp-Source: AGHT+IE+FdwyIwpqxifSTyoM2f7/6U4/zWrN1sFU5vhParxpHiNRI+Dyn/xWzovKcuwqqvL6+fmGww==
X-Received: by 2002:a17:902:ea08:b0:28e:caee:40d4 with SMTP id
 d9443c01a7336-290c9cbbf3emr257369725ad.15.1761130652093; 
 Wed, 22 Oct 2025 03:57:32 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472197d3sm134532605ad.102.2025.10.22.03.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 03:57:31 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v3 #2a/10] Adding LASI's NCR710 SCSI Controller Wrapper.
Date: Wed, 22 Oct 2025 16:27:03 +0530
Message-ID: <20251022105703.12663-2-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251017200653.23337-3-deller@kernel.org>
References: <20251017200653.23337-3-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pg1-x542.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 03:01:43 -0400
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

>> Changes since v1:
>> - Removed testing callback timer.
>> - Improved Scsi fifo documentation and implementation.
>> - Fixed Sync/Async functionality.

Changes since v2:
- Breaking down the NCR710 SCSI Controller into two patches [PATCH v3 #2a/10] and [PATCH v3 #2b/10]. 
- Since the intial v2 patch was too long.

[PATCH v3 #2a/10] 
- Adding the Lasi-Wrapper for the NCR710 SCSI Controller.
- Adding trace-events for the LASI's wrapper for NCR710 SCSI Controller.

[PATCH v3 #2b/10]
- Adding the core NCR710 SCSI Controller driver code.
- The previous patch added the code for LASI to access this driver,
  while the core patch is generic code which could be used for other machines
  as well.
- Adding trace-events for the NCR710 Core.

---
 hw/scsi/lasi_ncr710.c | 286 ++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/lasi_ncr710.h |  61 +++++++++
 hw/scsi/trace-events  |  17 +++
 3 files changed, 364 insertions(+)
 create mode 100644 hw/scsi/lasi_ncr710.c
 create mode 100644 hw/scsi/lasi_ncr710.h

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
new file mode 100644
index 0000000000..5a1b667170
--- /dev/null
+++ b/hw/scsi/lasi_ncr710.c
@@ -0,0 +1,286 @@
+/*
+ * LASI Wrapper for NCR710 SCSI Controller
+ *
+ * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
+ * This driver was developed during the Google Summer of Code 2025 program.
+ * Mentored by Helge Deller <deller@gmx.de>
+ *
+ * NCR710 SCSI Controller implementation
+ * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/scsi/lasi_ncr710.h"
+#include "hw/scsi/ncr53c710.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "system/blockdev.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "system/dma.h"
+
+#define LASI_710_SVERSION    0x00082
+#define SCNR                 0xBEEFBABE
+#define LASI_710_HVERSION    0x3D
+#define HPHW_FIO             5        /* Fixed I/O module */
+
+static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    LasiNCR710State *s = LASI_NCR710(opaque);
+    uint64_t val = 0;
+
+    trace_lasi_ncr710_reg_read(addr, 0, size);
+
+    if (addr == 0x00) {  /* Device ID */
+        val = (HPHW_FIO << 24) | LASI_710_SVERSION;
+        trace_lasi_ncr710_reg_read_id(HPHW_FIO, LASI_710_SVERSION, val);
+        return val;
+    }
+
+    if (addr == 0x08) {  /* HVersion */
+        val = LASI_710_HVERSION;
+        trace_lasi_ncr710_reg_read_hversion(val);
+        return val;
+    }
+
+    if (addr >= 0x100) {
+        hwaddr ncr_addr = addr - 0x100;
+        if (size == 1) {
+            ncr_addr ^= 3;
+            NCR710_DPRINTF("Reading value to LASI WRAPPER == 0x%lx%s, "
+                           "val=0x%lx, size=%u\n",
+                           addr - 0x100, size == 1 ? " (XORed)" : "",
+                           val, size);
+            val = ncr710_reg_read(&s->ncr710, ncr_addr, size);
+        } else {
+            val = 0;
+            for (unsigned i = 0; i < size; i++) {
+                uint8_t byte_val = ncr710_reg_read(&s->ncr710, ncr_addr + i, 1);
+                val |= ((uint64_t)byte_val) << (i * 8);
+                NCR710_DPRINTF("  Read byte %u from NCR addr 0x%lx: "
+                               "0x%02x\n", i, ncr_addr + i, byte_val);
+            }
+            NCR710_DPRINTF("  Reconstructed %u-byte value: 0x%lx\n",
+                           size, val);
+        }
+
+        trace_lasi_ncr710_reg_forward_read(addr, val);
+    } else {
+        val = 0;
+        trace_lasi_ncr710_reg_read(addr, val, size);
+    }
+    return val;
+}
+
+static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned size)
+{
+    LasiNCR710State *s = LASI_NCR710(opaque);
+
+    trace_lasi_ncr710_reg_write(addr, val, size);
+
+    if (addr <= 0x0F) {
+        return;
+    }
+
+    if (addr >= 0x100) {
+        hwaddr ncr_addr = addr - 0x100;
+
+        if (size == 1) {
+            ncr_addr ^= 3;
+            NCR710_DPRINTF("Writing value to LASI WRAPPER == 0x%lx%s, "
+                           "val=0x%lx, size=%u\n",
+                           addr - 0x100, size == 1 ? " (XORed)" : "",
+                           val, size);
+            ncr710_reg_write(&s->ncr710, ncr_addr, val, size);
+        } else {
+            for (unsigned i = 0; i < size; i++) {
+                uint8_t byte_val = (val >> (i * 8)) & 0xff;
+                 NCR710_DPRINTF("  Writing byte %u to NCR addr 0x%lx: 0x%02x\n",
+                       i, ncr_addr + i, byte_val);
+                ncr710_reg_write(&s->ncr710, ncr_addr + i, byte_val, 1);
+            }
+        }
+
+        trace_lasi_ncr710_reg_forward_write(addr, val);
+    } else {
+        trace_lasi_ncr710_reg_write(addr, val, size);
+    }
+}
+
+/*
+ * req_cancelled, command_complete, transfer_data forwards
+ * commands to its core counterparts.
+ */
+static void lasi_ncr710_request_cancelled(SCSIRequest *req)
+{
+    trace_lasi_ncr710_request_cancelled(req);
+    ncr710_request_cancelled(req);
+}
+
+static void lasi_ncr710_command_complete(SCSIRequest *req, size_t resid)
+{
+    trace_lasi_ncr710_command_complete(req->status, resid);
+    ncr710_command_complete(req, resid);
+}
+
+ static void lasi_ncr710_transfer_data(SCSIRequest *req, uint32_t len)
+{
+    trace_lasi_ncr710_transfer_data(len);
+    ncr710_transfer_data(req, len);
+}
+
+static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
+    .tcq = true,
+    .max_target = 8,
+    .max_lun = 8,  /* full LUN support */
+
+    .transfer_data = lasi_ncr710_transfer_data,
+    .complete = lasi_ncr710_command_complete,
+    .cancel = lasi_ncr710_request_cancelled,
+};
+
+static const MemoryRegionOps lasi_ncr710_mmio_ops = {
+    .read = lasi_ncr710_reg_read,
+    .write = lasi_ncr710_reg_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static const VMStateDescription vmstate_lasi_ncr710 = {
+    .name = "lasi-ncr710",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
+{
+    LasiNCR710State *s = LASI_NCR710(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    trace_lasi_ncr710_device_realize();
+
+    scsi_bus_init(&s->ncr710.bus, sizeof(s->ncr710.bus), dev,
+                  &lasi_ncr710_scsi_info);
+    s->ncr710.as = &address_space_memory;
+    s->ncr710.irq = s->lasi_irq;
+
+    s->ncr710.reselection_retry_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                     ncr710_reselection_retry_callback,
+                     &s->ncr710);
+
+    ncr710_soft_reset(&s->ncr710);
+
+    trace_lasi_ncr710_timers_initialized(
+        (uint64_t)s->ncr710.reselection_retry_timer);
+
+    /* Initialize memory region */
+    memory_region_init_io(&s->mmio, OBJECT(dev), &lasi_ncr710_mmio_ops, s,
+                          "lasi-ncr710", 0x200);
+    sysbus_init_mmio(sbd, &s->mmio);
+}
+
+void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev)
+{
+    LasiNCR710State *s = LASI_NCR710(lasi_dev);
+    SCSIBus *bus = &s->ncr710.bus;
+    int found_drives = 0;
+
+    if (!bus) {
+        return;
+    }
+
+    for (int unit = 0; unit <= 7; unit++) {
+        DriveInfo *dinfo = drive_get(IF_SCSI, bus->busnr, unit);
+        if (dinfo) {
+            trace_lasi_ncr710_legacy_drive_found(bus->busnr, unit);
+            found_drives++;
+        }
+    }
+
+    trace_lasi_ncr710_handle_legacy_cmdline(bus->busnr, found_drives);
+
+    scsi_bus_legacy_handle_cmdline(bus);
+    BusChild *kid;
+    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
+        trace_lasi_ncr710_scsi_device_created(
+            object_get_typename(OBJECT(kid->child)));
+    }
+}
+
+DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
+                               qemu_irq irq)
+{
+    DeviceState *dev;
+    LasiNCR710State *s;
+    SysBusDevice *sbd;
+
+    dev = qdev_new(TYPE_LASI_NCR710);
+    s = LASI_NCR710(dev);
+    sbd = SYS_BUS_DEVICE(dev);
+    s->lasi_irq = irq;
+    sysbus_realize_and_unref(sbd, &error_fatal);
+    memory_region_add_subregion(addr_space, hpa,
+                               sysbus_mmio_get_region(sbd, 0));
+    return dev;
+}
+
+static void lasi_ncr710_reset(DeviceState *dev)
+{
+    LasiNCR710State *s = LASI_NCR710(dev);
+    trace_lasi_ncr710_device_reset();
+    ncr710_soft_reset(&s->ncr710);
+}
+
+static void lasi_ncr710_instance_init(Object *obj)
+{
+    LasiNCR710State *s = LASI_NCR710(obj);
+
+    s->hw_type = HPHW_FIO;
+    s->sversion = LASI_710_SVERSION;
+    s->hversion = LASI_710_HVERSION;
+}
+
+static void lasi_ncr710_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = lasi_ncr710_realize;
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->fw_name = "scsi";
+    dc->desc = "HP-PARISC LASI NCR710 SCSI adapter";
+    device_class_set_legacy_reset(dc, lasi_ncr710_reset);
+    dc->vmsd = &vmstate_lasi_ncr710;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo lasi_ncr710_info = {
+    .name          = TYPE_LASI_NCR710,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LasiNCR710State),
+    .instance_init = lasi_ncr710_instance_init,
+    .class_init    = lasi_ncr710_class_init,
+};
+
+static void lasi_ncr710_register_types(void)
+{
+    type_register_static(&lasi_ncr710_info);
+}
+
+type_init(lasi_ncr710_register_types)
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
new file mode 100644
index 0000000000..26e3105244
--- /dev/null
+++ b/hw/scsi/lasi_ncr710.h
@@ -0,0 +1,61 @@
+/*
+ * LASI Wrapper for NCR710 SCSI Controller
+ *
+ * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
+ * This driver was developed during the Google Summer of Code 2025 program.
+ * Mentored by Helge Deller <deller@gmx.de>
+ *
+ * NCR710 SCSI Controller implementation
+ * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef HW_LASI_NCR710_H
+#define HW_LASI_NCR710_H
+
+#include "hw/sysbus.h"
+#include "qemu/osdep.h"
+#include "exec/memattrs.h"
+#include "hw/scsi/scsi.h"
+#include "hw/scsi/ncr53c710.h"
+
+#define TYPE_LASI_NCR710 "lasi-ncr710"
+OBJECT_DECLARE_SIMPLE_TYPE(LasiNCR710State, LASI_NCR710)
+
+#define LASI_SCSI_RESET         0x000   /* SCSI Reset Register */
+#define LASI_SCSI_NCR710_BASE   0x100   /* NCR710 Base Register Offset */
+
+#define PARISC_DEVICE_ID_OFF    0x00    /* HW type, HVERSION, SVERSION */
+#define PARISC_DEVICE_CONFIG_OFF 0x04   /* Configuration data */
+
+#define PHASE_MASK              7
+#define PHASE_DO                0
+
+#define NCR710_SCNTL1_RST       0x08    /* SCSI Reset */
+#define NCR710_ISTAT_RST        0x40    /* Device Reset */
+#define NCR710_ISTAT_ABRT       0x80    /* Script Abort */
+#define NCR710_ISTAT_CON        0x08    /* ISTAT_Connected */
+#define NCR710_DSTAT_DFE        0x80    /* DMA FIFO Empty */
+#define NCR710_CTEST2_DACK      0x01    /* DMA Acknowledge */
+
+typedef struct LasiNCR710State {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+    qemu_irq lasi_irq;       /* IRQ line to LASI controller */
+    uint32_t hw_type;        /* Hardware type (HPHW_*) */
+    uint32_t sversion;       /* Software version */
+    uint32_t hversion;       /* Hardware version */
+    SCSIBus bus;
+    NCR710State ncr710;
+} LasiNCR710State;
+
+DeviceState *lasi_ncr710_init(MemoryRegion *addr_space, hwaddr hpa,
+                               qemu_irq irq);
+void lasi_ncr710_handle_legacy_cmdline(DeviceState *lasi_dev);
+
+#endif
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 6c2788e202..0604050a67 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -306,6 +306,23 @@ lsi_reg_write(const char *name, int offset, uint8_t val) "Write reg %s 0x%x = 0x
 lsi_scripts_timer_triggered(void) "SCRIPTS timer triggered"
 lsi_scripts_timer_start(void) "SCRIPTS timer started"
 
+# lasi_ncr710.c
+lasi_ncr710_device_realize(void) "Device realized"
+lasi_ncr710_device_reset(void) "Device reset"
+lasi_ncr710_reg_read(uint32_t addr, uint32_t val, unsigned size) "addr=0x%03x val=0x%08x size=%u"
+lasi_ncr710_reg_write(uint32_t addr, uint32_t val, unsigned size) "addr=0x%03x val=0x%08x size=%u"
+lasi_ncr710_reg_read_id(uint32_t hw_type, uint32_t sversion, uint32_t val) "hw_type=%u sversion=0x%04x val=0x%08x"
+lasi_ncr710_reg_read_hversion(uint32_t hversion) "LASI NCR710: HVersion read -> 0x%02x"
+lasi_ncr710_reg_forward_read(uint32_t addr, uint32_t val) "LASI NCR710: Forward read to NCR710 core addr=0x%03x val=0x%08x"
+lasi_ncr710_reg_forward_write(uint32_t addr, uint32_t val) "LASI NCR710: Forward write to NCR710 core addr=0x%03x val=0x%08x"
+lasi_ncr710_command_complete(uint32_t status, size_t resid) "LASI NCR710: Command complete status=0x%02x resid=%zu"
+lasi_ncr710_transfer_data(uint32_t len) "LASI NCR710: Transfer data len=%u"
+lasi_ncr710_request_cancelled(void *req) "LASI NCR710: Request cancelled req=%p"
+lasi_ncr710_timers_initialized(uint64_t reselection) "Timers: reselection=0x%" PRIx64
+lasi_ncr710_handle_legacy_cmdline(int busnr, int found_drives) "LASI NCR710: Handle legacy cmdline busnr=%d found_drives=%d"
+lasi_ncr710_legacy_drive_found(int busnr, int unit) "LASI NCR710: Found legacy drive at bus=%d unit=%d"
+lasi_ncr710_scsi_device_created(const char *type) "LASI NCR710: SCSI device created: %s"
+
 # virtio-scsi.c
 virtio_scsi_cmd_req(int lun, uint32_t tag, uint8_t cmd) "virtio_scsi_cmd_req lun=%u tag=0x%x cmd=0x%x"
 virtio_scsi_cmd_resp(int lun, uint32_t tag, int response, uint8_t status) "virtio_scsi_cmd_resp lun=%u tag=0x%x response=%d status=0x%x"
-- 
2.49.0


